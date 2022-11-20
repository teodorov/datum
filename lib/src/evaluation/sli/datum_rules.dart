import 'package:datum/src/evaluation/cesk/closure.dart';
import 'package:datum/src/evaluation/cesk/configuration.dart';
import 'package:datum/src/evaluation/cesk/primitives.dart';
import 'package:datum/src/evaluation/sli/rule.dart';
import 'package:datum/src/model/datum_model.dart' as datum;

// define symbol exp
// E <(define symbol exp), ρ, σ, κ >  ⟶  E <exp, ρ, σ, DefFrame(symbol, κ)>
//      where symbol is Symbol

// define function
// E <(define (symbol args) body), ρ, σ, κ> ⟶ E <(lambda args body), ρ, σ, DefFrame(symbol, κ)>
//      where symbol is Symbol

// define kontinuation
// K <v, ρ, σ, DefFrame(symbol, κ)> ⟶ E <null, ρ[symbol ↦ a], σ[a ↦ v], k>

rules() {
  List<Rule> erules = [
    Rule.eval(
        'symbol',
        (c) => c.control is datum.Symbol,
        (c) => Configuration(c.store[c.environment[c.control]], c.environment,
            c.store, c.kontinuation)),
    Rule.eval("'", (c) => c.control is datum.Quote, quoteAction),
    Rule.eval(
        'quote',
        (c) =>
            c.control is datum.Pair && c.control.car == datum.Symbol('quote'),
        quoteSymbolAction),
    Rule.eval(
        'lambda',
        (c) =>
            c.control is datum.Pair && c.control.car == datum.Symbol('lambda'),
        (c) => Configuration(lambda2closure(c.control.cdr, c.environment),
            c.environment, c.store, c.kontinuation)),
    Rule.eval(
        'if',
        (c) => c.control is datum.Pair && c.control.car == datum.Symbol('if'),
        ifAction),
    Rule.eval(
        'set!',
        (c) => c.control is datum.Pair && c.control.car == datum.Symbol('set!'),
        setAction),
    Rule.eval('sequence', sequenceGuard, sequenceAction),
    Rule.eval(
        'application',
        (c) => c.control is datum.Pair && !primitiveForm(c.control.car),
        applicationAction),
// define symbol exp
// E <('define symbol exp), ρ, σ, κ >  ⟶  E <exp, ρ, σ, DefFrame(symbol, κ)>
//      where symbol is Symbol
    Rule.eval(
        'define symbol exp',
        (c) =>
            c.control is datum.Pair &&
            c.control.car == datum.Symbol('define') &&
            c.control.cdr.car is datum.Symbol,
        defineSymbolAction),

// define function
// E <(define (symbol args) body), ρ, σ, κ> ⟶ E <(lambda args body), ρ, σ, DefFrame(symbol, κ)>
//      where symbol is Symbol
    Rule.eval(
        'define symbol exp',
        (c) =>
            c.control is datum.Pair &&
            c.control.car == datum.Symbol('define') &&
            c.control.cdr.car is datum.Pair &&
            c.control.cdr.car.car is datum.Symbol,
        defineFunctionAction),
  ];
  List<Rule> krules = [
    Rule.kontinuation('k: end', EndFrame, (c) => true, endKAction),
    Rule.kontinuation('k: if (true)', IfFrame,
        (c) => c.control == datum.Boolean.dTrue, ifKActionTrue),
    Rule.kontinuation('k: if (false)', IfFrame,
        (c) => c.control == datum.Boolean.dFalse, ifKActionFalse),
    Rule.kontinuation('k: set!', SetFrame, (c) => true, setKAction),
    Rule.kontinuation(
        'k-sequence',
        SequenceFrame,
        (c) => c.kontinuation.rest == datum.Null.instance,
        sequenceResultKAction),
    Rule.kontinuation('k-sequence', SequenceFrame,
        (c) => c.kontinuation.rest != datum.Null.instance, sequenceRestKAction),
    //application
    Rule.kontinuation('k-application args', ApplicationFrame,
        applicationArgsKGuard, applicationArgsKAction),
    Rule.kontinuation('k-application defaults', ApplicationFrame,
        applicationDefaultKGuard, applicationDefaultKAction),
    Rule.kontinuation('k-application eval code', ApplicationFrame,
        applicationEvalKGuard, applicationEvalKAction),
    Rule.kontinuation(
        'k-application done',
        ApplicationFrame,
        (c) => c.kontinuation.isDone,
        (c) => Configuration(c.control, c.kontinuation.environment, c.store,
            c.kontinuation.parent)),

// define kontinuation
// K <v, ρ, σ, DefFrame(symbol, κ)> ⟶ E <null, ρ[symbol ↦ a], σ[a ↦ v], k>
    Rule.kontinuation('k-define', DefFrame, (c) => true, (c) {
      int idx = c.store.length;
      c.environment.define(c.kontinuation.symbol, idx);
      c.store.add(c.control);
      return Configuration(
          datum.Null.instance, c.environment, c.store, c.kontinuation.parent);
    })
  ];
  return {'eval': erules, 'kont': krules};
}

primitiveForm(item) {
  var primitives = [
    'if',
    'quote',
    'lambda',
    'set!',
    'begin',
    'sequence',
    'define'
  ];
  return primitives.where((c) => item == datum.Symbol(c)).isNotEmpty;
}

quoteAction(c) =>
    Configuration(c.control.datum, c.environment, c.store, c.kontinuation);
quoteSymbolAction(c) =>
    Configuration(c.control.cdr.car, c.environment, c.store, c.kontinuation);

ifAction(c) => Configuration(c.control.cdr.car, c.environment, c.store,
    IfFrame(c.control.cdr.cdr.car, c.control.cdr.cdr.cdr.car, c.kontinuation));

setAction(c) => Configuration(c.control.cdr.cdr.car, c.environment, c.store,
    SetFrame(c.environment[c.control.cdr.car], c.kontinuation));

//sequence evaluation rule
sequenceGuard(c) =>
    c.control is datum.Pair &&
    (c.control.car == datum.Symbol('begin') ||
        c.control.car == datum.Symbol('sequence'));

sequenceAction(c) => Configuration(c.control.cdr.car, c.environment.create(),
    c.store, SequenceFrame(c.control.cdr.cdr, c.kontinuation));

//application evaluation rule
applicationAction(c) => Configuration(
    c.control.car,
    c.environment,
    c.store,
    ApplicationFrame(
        null, [], c.control.cdr, c.environment, false, c.kontinuation));

//kontinuation rules
//end
endKAction(c) {
  return Configuration(c.control, c.environment, c.store, c.kontinuation);
}

//if
ifKActionTrue(c) => Configuration(
    c.kontinuation.trueBranch, c.environment, c.store, c.kontinuation.parent);
ifKActionFalse(c) => Configuration(
    c.kontinuation.falseBranch, c.environment, c.store, c.kontinuation.parent);
//set!

setKAction(c) {
  dynamic frame = c.kontinuation;
  c.store[frame.address] = c.control;
  return Configuration(
      datum.Null.instance, c.environment, c.store, frame.parent);
}

//sequence
sequenceResultKAction(c) => Configuration(
    c.control, c.environment.parent, c.store, c.kontinuation.parent);

sequenceRestKAction(c) => Configuration(c.kontinuation.rest.car, c.environment,
    c.store, SequenceFrame(c.kontinuation.rest.cdr, c.kontinuation.parent));

defineSymbolAction(c) => Configuration(c.control.cdr.cdr.car, c.environment,
    c.store, DefFrame(c.control.cdr.car, c.kontinuation));

defineFunctionAction(c) {
  var function = datum.Pair(datum.Symbol('lambda'),
      datum.Pair(c.control.cdr.car.cdr, c.control.cdr.cdr));
  return Configuration(function, c.environment, c.store,
      DefFrame(c.control.cdr.car.car, c.kontinuation));
}

//application
//eval arguments
applicationArgsKGuard(c) {
  return c.kontinuation.expressions != datum.Null.instance;
}

applicationArgsKAction(c) {
  var closure = c.kontinuation.closure;
  if (closure == null) {
    if (c.control is! Klosure && c.control is! datum.Primitive) {
      throw ArgumentError(
          "The first argument of an application should be a closure or primitive");
    }
    closure = c.control;
  } else {
    c.kontinuation.values.add(c.control);
    if (!closure.isVariadic &&
        c.kontinuation.values.length > closure.formals.length) {
      throw ArgumentError(
          "Too many arguments: expected ${closure.formals.length} but given more than ${c.continuation.values.length} arguments");
    }
  }
  return Configuration(
      (c.kontinuation.expressions as datum.Pair).car,
      c.environment,
      c.store,
      ApplicationFrame(
          closure,
          c.kontinuation.values,
          (c.kontinuation.expressions as datum.Pair).cdr!,
          c.kontinuation.environment,
          false,
          c.kontinuation.parent));
}

//eval defaults for missing optional arguments
applicationDefaultKGuard(c) {
  ApplicationFrame frame = c.kontinuation as ApplicationFrame;
  if (frame.expressions != datum.Null.instance) return false;
  var closure = c.kontinuation.closure ?? c.control;
  var numberOfDirectArguments =
      closure.isVariadic ? closure.formals.length - 1 : closure.formals.length;

  return (frame.expressions == datum.Null.instance) &&
      (numberOfDirectArguments > (frame.values.length + 1));
}

applicationDefaultKAction(c) {
  var closure = c.kontinuation.closure;
  if (closure == null) {
    if (c.control is! Klosure) {
      throw ArgumentError(
          "The first argument of an application should be a closure");
    }
    closure = c.control;
  } else {
    c.kontinuation.values.add(c.control);
    if (!closure.isVariadic &&
        c.kontinuation.values.length > closure.formals.length) {
      throw ArgumentError(
          "Too many arguments: expected ${closure.formals.length} but given more than ${c.continuation.values.length} arguments");
    }
  }

  if (c.kontinuation.values.length < closure.numberOfMandatoryArguments) {
    throw ArgumentError(
        "Not enough arguments: expected ${closure.numberOfMandatoryArguments} but given only ${c.kontinuation.values.length} arguments");
  }

  //prepare the optional arguments
  var numberOfDirectArguments =
      closure.isVariadic ? closure.formals.length - 1 : closure.formals.length;
  dynamic defaultExpressions = datum.Null.instance;
  for (int i = numberOfDirectArguments - 1;
      i >= c.kontinuation.values.length;
      i--) {
    var defaultExpression = (closure.formals[i] as datum.Pair).cdr!;
    defaultExpressions = datum.Pair(defaultExpression, defaultExpressions);
  }

  return Configuration(
      defaultExpressions.car,
      c.environment,
      c.store,
      ApplicationFrame(closure, c.kontinuation.values, defaultExpressions.cdr!,
          c.kontinuation.environment, false, c.kontinuation.parent));
}

//eval code in the created environment
applicationEvalKGuard(c) {
  ApplicationFrame frame = c.kontinuation as ApplicationFrame;
  if (frame.expressions != datum.Null.instance) return false;
  var closure = c.kontinuation.closure ?? c.control;
  var numberOfDirectArguments =
      closure.isVariadic ? closure.formals.length - 1 : closure.formals.length;
  var condition = //(frame.expressions == datum.Null.instance) &&
      (numberOfDirectArguments <= frame.values.length + 1) && (!frame.isDone);
  return condition;
}

applicationEvalKAction(c) {
  var closure = c.kontinuation.closure;
  if (closure == null) {
    if (c.control is! Klosure) {
      throw ArgumentError(
          "The first argument of an application should be a closure");
    }
    closure = c.control;
  } else {
    c.kontinuation.values.add(c.control);
    if (!closure.isVariadic &&
        c.kontinuation.values.length > closure.formals.length) {
      throw ArgumentError(
          "Too many arguments: expected ${closure.formals.length} but given more than ${c.kontinuation.values.length} arguments");
    }
  }

  ApplicationFrame frame = c.kontinuation;

  if (closure is datum.Primitive) {
    var result = closure.primitive(frame.values);
    return Configuration(result, frame.environment, c.store, frame.parent);
  }

  if (frame.values.length < closure.numberOfMandatoryArguments) {
    throw ArgumentError(
        "Not enough arguments: expected ${closure.numberOfMandatoryArguments} but given only ${frame.values.length} arguments");
  }

  var numberOfDirectArguments =
      closure.isVariadic ? closure.formals.length - 1 : closure.formals.length;
  Environment applicationEnvironment = closure.environment.create();
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
    var address = c.store.length;
    applicationEnvironment.define(formal, address);
    c.store.add(actual);
  }

  if (closure.isVariadic) {
    datum.Symbol formal = closure.formals[i] as datum.Symbol;
    dynamic actual = datum.Null.instance;
    for (var j = frame.values.length - 1; j >= i; j--) {
      actual = datum.Pair(frame.values[j], actual);
    }
    var address = c.store.length;
    applicationEnvironment.define(formal, address);
    c.store.add(actual);
  }

  return Configuration(
      closure.code,
      applicationEnvironment,
      c.store,
      ApplicationFrame(closure, frame.values, frame.expressions,
          frame.environment, true, frame.parent));
}
