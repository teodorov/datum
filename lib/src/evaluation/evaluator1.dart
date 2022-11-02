import 'dart:collection';

import 'package:datum/src/domains/environment.dart';
import 'package:datum/src/model/datum_model.dart' as datum;

class Evaluator extends datum.DatumVisitor {
  Evaluator(this.root) {
    stack = Queue.of([root]);
  }
  final Environment root;
  late Queue<Environment> stack;

  push(Environment e) {
    stack.addLast(e);
  }

  pop() {
    return stack.removeLast();
  }

  peek() {
    return stack.last;
  }

  @override
  visitBoolean(datum.Boolean item) {
    return item;
  }

  @override
  visitCharacter(datum.Character item) {
    return item;
  }

  @override
  visitClosure(datum.Closure item) {
    return item;
  }

  @override
  visitCommented(datum.Commented item) {
    return datum.Null.instance;
  }

  @override
  visitDatum(datum.Datum item) {
    //this is abstract do not implement
    throw UnimplementedError();
  }

  @override
  visitDefinition(datum.Definition item) {
    peek()[item.name] = item.datum;
    return item.datum;
  }

  @override
  visitDottedPair(datum.DottedPair item) {
    //this should not occur
    throw UnimplementedError();
  }

  @override
  visitEnvironment(Environment item) {
    return item;
  }

  @override
  visitLiteral(datum.Literal item) {
    //this is abstract do not implement
    throw UnimplementedError();
  }

  @override
  visitNull(datum.Null item) {
    return item;
  }

  @override
  visitNumber(datum.Number item) {
    return item;
  }

  @override
  visitPair(datum.Pair item) {
    var closure = item.car.accept(this);
    //apply the primitive forms
    if (closure is datum.Primitive) {
      return closure.primitive(item.cdr, peek(), this);
    }
    if (closure is! datum.Closure) {
      throw ArgumentError(
          "The first argument of an application should be a closure");
    }
    return apply(closure, item.cdr);
  }

  @override
  visitPrimitive(datum.Primitive item) {
    return item;
  }

  @override
  visitProperList(datum.ProperList item) {
    //this should not occur
    throw UnimplementedError();
  }

  @override
  visitString(datum.String item) {
    return item;
  }

  @override
  visitSymbol(datum.Symbol item) {
    return peek()[item];
  }

  @override
  visitQuote(datum.Quote item) {
    return item.datum;
  }

  apply(datum.Closure closure, arguments) {
    var numberOfDirectArguments = closure.isVariadic
        ? closure.formals.length - 1
        : closure.formals.length;
    //create a frame
    var frame = closure.environment.create();
    int i = 0;
    var args = arguments;
    for (args; args != datum.Null.instance; args = args.cdr) {
      if (!closure.isVariadic && i >= closure.formals.length) {
        throw ArgumentError(
            "Too many arguments: expected ${closure.formals.length} but given more than $i arguments");
      }
      if (closure.isVariadic && i == numberOfDirectArguments) {
        break;
      }
      var actual = args.car.accept(this);
      datum.Symbol formal;
      if (closure.formals[i] is datum.Symbol) {
        //the argument is a mandatory argument
        formal = closure.formals[i] as datum.Symbol;
      } else {
        //the argument is an optional argument, its car is a Symbol
        formal = (closure.formals[i] as datum.Pair).car as datum.Symbol;
      }
      frame.define(formal, actual);
      i++;
    }
    if (i < closure.numberOfMandatoryArguments) {
      throw ArgumentError(
          "Not enough arguments: expected ${closure.numberOfMandatoryArguments} but given only $i arguments");
    }
    for (; i < numberOfDirectArguments; i++) {
      datum.Symbol formal =
          (closure.formals[i] as datum.Pair).car as datum.Symbol;
      var defaultValue = (closure.formals[i] as datum.Pair).cdr!.accept(this);
      frame.define(formal, defaultValue);
    }

    if (closure.isVariadic) {
      datum.Symbol formal = closure.formals[i] as datum.Symbol;
      datum.Datum actual = evalList(args);
      frame.define(formal, actual);
    }

    var body = closure.code;
    push(frame);
    return body.accept(this);
  }

  evalList(exp) {
    if (exp == datum.Null.instance) {
      return exp;
    }
    return datum.Pair(exp.car.accept(this), evalList(exp.cdr));
  }
}

eval(expression, Environment environment) {
  return expression.accept(Evaluator(environment));
}

evalList(arguments, environment) {
  throw UnimplementedError("EvalList not implemented yet");
}

xapply(closure, arguments, env) {
  throw UnimplementedError("Top apply not implemented yet");
}

/*
//lambda application - function call
apply(closure, arguments, env) {
  if (closure is datum.Primitive) {
    return closure.primitive(env, arguments);
  }
  //if the closure is a Pair with the car 'closure
  if (closure is datum.Closure) {
    var body = closure.code;
    var frame = closure.environment.clone();

    //pair up -- set the formals to the actuals and create the frame
    Iterable<datum.Symbol> sym = frame.symbols;
    var symI = sym.iterator;
    var args = arguments;
    while (symI.moveNext() && args != datum.Null.instance) {
      frame[symI.current] = eval(args.car, env);
      args = args.tail;
    }
    //eval the body in the frame context
    return eval(body, frame);
  }
  throw ArgumentError('apply invoked with non-closure target');
}

evalList(args, env) {
  if (args == datum.Null.instance) {
    return args;
  }
  return datum.Pair(eval(args.car, env), evalList(args.cdr, env));
}
*/
