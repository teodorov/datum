import 'package:datum/src/cesk/configuration.dart';
import 'package:datum/src/cesk/closure.dart';
import 'package:datum/src/cesk/primitives.dart';
import 'package:datum/src/evaluation/reader.dart';

import 'package:datum/src/model/datum_model.dart' as datum;

import 'is_value_visitor.dart';

// https://drs.is/post/crafting-semantics-3/

read(String expression) => DatumReader().parseString(expression);
print(datum.Datum expression) => expression.toString();

datum.Datum eval(datum.Datum expression) {
  var initial = inject(expression);
  Configuration? source = initial;
  while (source != null) {
    var target = step(source);
    if (target == source) {
      if (target!.kontinuation is! DoneFrame) {
        throw AssertionError('fixed point with not empty kontinuation stack');
      }
      return target.control;
    }
    source = target;
  }
  //we got stuck
  return datum.Null.instance;
}

Configuration inject(datum.Datum expression) =>
    Configuration(expression, Environment(), [], EndFrame());

Configuration? step(Configuration source) {
  if (source.kontinuation is DoneFrame) {
    return source;
  }
  // if the control cannot be reduced anymore get the continuation-steps
  // guard=[ isValue(source.control) ] / action={ applyKontinuationStep; }
  if (isValue(source.control)) {
    return applyKontinuationStep(source);
  }

  //quote ast node - eval rule
  if (source.control is datum.Quote) {
    return Configuration((source.control as datum.Quote).datum,
        source.environment, source.store, source.kontinuation);
  }

  if (source.control is! datum.Pair) {
    throw ArgumentError('The control expression should be a List');
  }
  dynamic control = source.control as datum.Pair;

  //conditional evaluation
  // guard=[ source.control.car = 'if ] / action={ eval cond, push IfFrame }
  if (control.car == datum.Symbol('if')) {
    var condition = control.cdr.car;
    var thenB = control.cdr.cdr.car;
    var elseB = control.cdr.cdr.cdr.car;
    return Configuration(condition, source.environment, source.store,
        IfFrame(thenB, elseB, source.kontinuation));
  }

  //mutation - eval rule
  if (control.car == datum.Symbol('set!')) {
    var symbol = control.cdr.car;
    var address = source.environment[symbol]!;
    var expression = control.cdr.cdr.car;
    return Configuration(expression, source.environment, source.store,
        SetFrame(address, source.kontinuation));
  }

  //quote - eval rule
  if (control.car == datum.Symbol('quote')) {
    return Configuration(
        control.cdr.car, source.environment, source.store, source.kontinuation);
  }

  if (control.car == datum.Symbol('begin') ||
      control.car == datum.Symbol('sequence')) {
    return Configuration(control.cdr.car, source.environment, source.store,
        SequenceFrame(control.cdr.cdr, source.kontinuation));
  }

  if (isValue(control.car) && !isFunction(control.car)) {
    return applyKontinuationStep(source);
  }

  //function application
  // if no primitive forms matched the it is a function application
  var closureExpr = control.car;
  var arguments = control.cdr;

  return Configuration(
      closureExpr,
      source.environment,
      source.store,
      ApplicationFrame(
          null, [], arguments, source.environment, source.kontinuation));
}

applyKontinuationStep(Configuration source) {
  var value = evalValue(source.control, source.environment, source.store);

  //apply the halt continuation, when the stack is empty
  if (source.kontinuation is EndFrame) {
    var target =
        Configuration(value, source.environment, source.store, DoneFrame());
    return target;
  }

  if (source.kontinuation is IfFrame) {
    IfFrame frame = source.kontinuation as IfFrame;
    if (value == datum.Boolean.dFalse) {
      var target = Configuration(
          frame.falseBranch, source.environment, source.store, frame.parent);
      return target;
    }
    //if not false then surely true
    var target = Configuration(
        frame.trueBranch, source.environment, source.store, frame.parent);
    return target;
  }

  //mutation kontinuation rule
  if (source.kontinuation is SetFrame) {
    dynamic frame = source.kontinuation;
    source.store[frame.address] = value;
    return Configuration(
        datum.Null.instance, source.environment, source.store, frame.parent);
  }

  //sequence kontinuation rule
  if (source.kontinuation is SequenceFrame) {
    dynamic frame = source.kontinuation;
    if (frame.rest == datum.Null.instance) {
      return Configuration(
          value, source.environment, source.store, frame.parent);
    }
    return Configuration(frame.rest.car, source.environment, source.store,
        SequenceFrame(frame.rest.cdr, frame.parent));
  }

  if (source.kontinuation is ApplicationFrame) {
    //resume execution, popping the stack
    ApplicationFrame frame = source.kontinuation as ApplicationFrame;
    //add the control value to the values
    var closure = frame.closure;
    if (closure == null) {
      if (value is! Klosure) {
        throw ArgumentError(
            "The first argument of an application should be a closure");
      }
      closure = value;
    } else {
      frame.values.add(value);
      if (!closure.isVariadic && frame.values.length > closure.formals.length) {
        throw ArgumentError(
            "Too many arguments: expected ${closure.formals.length} but given more than ${frame.values.length} arguments");
      }
    }

    //if we have more expressions to evaluate
    if (frame.expressions != datum.Null.instance) {
      return Configuration(
          (frame.expressions as datum.Pair).car,
          source.environment,
          source.store,
          ApplicationFrame(
              closure,
              frame.values,
              (frame.expressions as datum.Pair).cdr!,
              frame.environment,
              frame.parent));
    }

    if (frame.values.length < closure.numberOfMandatoryArguments) {
      throw ArgumentError(
          "Not enough arguments: expected ${closure.numberOfMandatoryArguments} but given only ${frame.values.length} arguments");
    }

    //prepare the optional arguments
    var numberOfDirectArguments = closure.isVariadic
        ? closure.formals.length - 1
        : closure.formals.length;
    dynamic defaultExpressions = datum.Null.instance;
    for (int i = numberOfDirectArguments - 1; i >= frame.values.length; i--) {
      var defaultExpression = (closure.formals[i] as datum.Pair).cdr!;
      defaultExpressions = datum.Pair(defaultExpression, defaultExpressions);
    }

    if (defaultExpressions != datum.Null.instance) {
      return Configuration(
          defaultExpressions.car,
          source.environment,
          source.store,
          ApplicationFrame(closure, frame.values, defaultExpressions.cdr!,
              frame.environment, frame.parent));
    }

    //create the application environment to bind the formals to the actuals
    Environment applicationEnvironment = frame.environment.create();
    int i;
    for (i = 0; i < frame.values.length; i++) {
      if (closure.isVariadic && i == numberOfDirectArguments) {
        break;
      }
      datum.Symbol formal;
      if (closure.formals[i] is datum.Symbol) {
        //the argument is mandatory
        formal = closure.formals[i] as datum.Symbol;
      } else {
        //the argument is optional, its car is a symbol
        formal = (closure.formals[i] as datum.Pair).car as datum.Symbol;
      }
      var actual = frame.values[i];
      var address = source.store.length;
      applicationEnvironment.define(formal, address);
      source.store.add(actual);
    }

    if (closure.isVariadic) {
      datum.Symbol formal = closure.formals[i] as datum.Symbol;
      dynamic actual = datum.Null.instance;
      for (var j = frame.values.length - 1; j >= i; j--) {
        actual = datum.Pair(frame.values[j], actual);
      }
      var address = source.store.length;
      applicationEnvironment.define(formal, address);
      source.store.add(actual);
    }

    return Configuration(
        closure.code, applicationEnvironment, source.store, frame.parent);
  }
  return null;
}

evalValue(
    datum.Datum expression, Environment environment, List<datum.Datum> store) {
  //null is self-evaluating
  if (expression is datum.Null) {
    return expression;
  }
  //number is self-evaluating
  if (expression is datum.Number) {
    return expression;
  }
  //boolean is self-evaluating
  if (expression is datum.Boolean) {
    return expression;
  }
  //character is self-evaluating
  if (expression is datum.Character) {
    return expression;
  }
  //string is self-evaluating
  if (expression is datum.String) {
    return expression;
  }
  // //symbol returns the value from the store
  if (expression is datum.Symbol) {
    return store[environment[expression]!];
  }
  //closure is self-evaluating
  if (expression is Klosure) {
    return expression;
  }
  //primitive is self-evaluating
  if (expression is datum.Primitive) {
    return expression;
  }

  if (expression is datum.Pair && expression.car == datum.Symbol('lambda')) {
    return lambda2closure(expression.cdr, environment);
  }
  return expression;
}

isFunction(expression) {
  if (expression is Klosure) {
    return true;
  }
  if (expression is datum.Pair && expression.car == datum.Symbol('lambda')) {
    return true;
  }
  return false;
}
