import 'package:datum/src/domains/environment.dart';
import 'package:datum/src/model/datum_model.dart' as datum;

eval(exp, Environment env) {
  //symbols are looked-up and replaced by their value
  if (exp is datum.Symbol) {
    return env[exp];
  }
  if (exp is datum.Pair) {
    var closure = eval(exp.car, env);
    return apply(closure, exp.cdr, env);
  }
  return exp;
}

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
