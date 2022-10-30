// ignore_for_file: file_names

import 'dart:collection';

import '../model/datum_ast.dart' as datum;

class Environment extends datum.Datum {
  // ignore: prefer_collection_literals
  Environment([this._parent]) : _bindings = LinkedHashMap();

  final Environment? _parent;
  final Map<datum.Symbol, datum.Datum> _bindings;

  Environment create() => Environment(this);

  //lookup
  datum.Datum? operator [](datum.Symbol symbol) {
    if (_bindings.containsKey(symbol)) {
      return _bindings[symbol]!;
    }
    if (_parent != null) {
      return _parent![symbol];
    }
    throw ArgumentError('$symbol is not defined in the lexical scope');
  }

  //update existing binding
  void operator []=(datum.Symbol symbol, datum.Datum value) {
    if (_bindings.containsKey(symbol)) {
      _bindings[symbol] = value;
      return;
    }
    if (_parent != null) {
      _parent![symbol] = value;
    }
    throw ArgumentError('$symbol is not defined in the lexical scope');
  }

  //define a new binding
  datum.Datum define(datum.Symbol symbol, datum.Datum value) =>
      _bindings[symbol] = value;

  datum.Datum definePrimitive(datum.Primitive primitive) =>
      _bindings[primitive.name] = primitive;

  Iterable<MapEntry<datum.Symbol, datum.Datum>> get entries =>
      _bindings.entries;
  Iterable<datum.Symbol> get symbols => _bindings.keys;
  Environment? get parent => _parent;

  clone() {
    Environment env = Environment(parent);
    for (var element in entries) {
      env.define(element.key, element.value);
    }
    return env;
  }

  @override
  accept(visitor) {
    return visitor.visitEnvironment(this);
  }
}

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
    return applyPrimitive(closure.primitive, arguments, env);
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

applyPrimitive(closure, arguments, env) {
  return closure(env, arguments);
}

evalList(args, env) {
  if (args == datum.Null.instance) {
    return args;
  }
  return datum.Pair(eval(args.car, env), evalList(args.cdr, env));
}

String printer(datum.Datum e) {
  return e.toString();
}
