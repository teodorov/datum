import 'dart:collection';

import '../model/datum_ast.dart' as datum;

class Environment extends datum.Datum {
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
      frame[symI.current] = args.car;
      args = args.tail;
    }
    return eval(body, frame);
  }
  return closure;
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

class PrimitiveEnvironment extends Environment {
  PrimitiveEnvironment(super.parent) {
    //basic functions
    definePrimitive(datum.Primitive('define', _notSupportedError));
    definePrimitive(datum.Primitive('lambda', _lambda));
    definePrimitive(datum.Primitive('quote', _quote));
    definePrimitive(datum.Primitive('eval', _notSupportedError));
    definePrimitive(datum.Primitive('apply', _notSupportedError));
    definePrimitive(datum.Primitive('let', _notSupportedError));
    definePrimitive(datum.Primitive('set!', _notSupportedError)); //assignment
    definePrimitive(datum.Primitive('print', _notSupportedError));

    //control structures
    definePrimitive(datum.Primitive('if', _if));
    definePrimitive(datum.Primitive('while', _notSupportedError));

    //boolean operators
    definePrimitive(datum.Primitive('and', _and));
    definePrimitive(datum.Primitive('or', _or));
    definePrimitive(datum.Primitive('not', _not));

    //arithmetic operators
    definePrimitive(datum.Primitive('+', _plus));
    definePrimitive(datum.Primitive('-', _minus));
    definePrimitive(datum.Primitive('*', _multiply));
    definePrimitive(datum.Primitive('/', _divide));
    definePrimitive(datum.Primitive('%', _modulo));

    //equality and order operators
    definePrimitive(datum.Primitive('<', _lessThan));
    definePrimitive(datum.Primitive('<=', _lessThanOrEqual));
    definePrimitive(datum.Primitive('=', _equal));
    definePrimitive(datum.Primitive('!=', _notEqual));
    definePrimitive(datum.Primitive('>', _greaterThan));
    definePrimitive(datum.Primitive('>=', _greaterThanOrEqual));

    //list operations
    definePrimitive(datum.Primitive('cons', _cons));
    definePrimitive(datum.Primitive('car', _car));
    definePrimitive(datum.Primitive('car!', _carSet));
    definePrimitive(datum.Primitive('cdr', _cdr));
    definePrimitive(datum.Primitive('cdr!', _cdrSet));
  }
  static _notSupportedError(Environment e, args) {
    throw ArgumentError('${args.toString()} not supported yet!');
  }

  static _define(Environment e, args) {
    return datum.Null.instance;
  }

  static _lambda(Environment e, args) {
    var fe = Environment(e);
    var body = args.cdr;
    for (args = args.car; args != datum.Null.instance; args = args.tail) {
      var symbol = eval(args.car, e);
      fe.define(symbol, datum.Null.instance);
    }

    return datum.Closure(body, fe);
  }

  static _quote(Environment e, args) {
    return args.car;
  }

  static _if(Environment e, args) {
    final condition = eval(args.head, e);
    if (condition is! datum.Boolean) {
      throw ArgumentError('if call with non-boolean condition');
    }
    if (args.tail == null) return datum.Null.instance;
    if (condition == datum.Boolean.dTrue) {
      return eval(args.tail.head, e);
    }
    if (args.tail.tail == null) return datum.Null.instance;
    return eval(args.tail.tail.head, e);
  }

  static _and(Environment e, args) {
    while (args != null) {
      var operand = eval(args.head, e);
      if (operand is! datum.Boolean) {
        throw ArgumentError("'and' defined only with boolean arguments");
      }
      if (operand == datum.Boolean.dFalse) {
        return datum.Boolean.dFalse;
      }
      args = args.tail;
    }
    return datum.Boolean.dTrue;
  }

  static _or(Environment e, args) {
    while (args != null) {
      var operand = eval(args.head, e);
      if (operand is! datum.Boolean) {
        throw ArgumentError("'or' defined only with boolean arguments");
      }
      if (operand == datum.Boolean.dTrue) {
        return datum.Boolean.dTrue;
      }
      args = args.tail;
    }
    return datum.Boolean.dFalse;
  }

  static _not(Environment e, args) {
    var operand = eval(args.head, e);
    if (operand is! datum.Boolean) {
      throw ArgumentError("'not' defined only with boolean arguments");
    }
    return operand == datum.Boolean.dTrue
        ? datum.Boolean.dFalse
        : datum.Boolean.dTrue;
  }

  static _plus(Environment e, args) {
    var value = eval(args.head, e).value;
    for (args = args.tail; args != datum.Null.instance; args = args.tail) {
      value += eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _minus(Environment e, args) {
    var value = eval(args.head, e).value;
    if (args.tail == datum.Null) {
      return datum.Number.fromDart(-value);
    }
    for (args = args.tail; args != null; args = args.tail) {
      value -= eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _multiply(Environment e, args) {
    var value = eval(args.head, e).value;
    for (args = args.tail; args != null; args = args.tail) {
      value *= eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _divide(Environment e, args) {
    var value = eval(args.head, e).value;
    for (args = args.tail; args != null; args = args.tail) {
      value /= eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _modulo(Environment e, args) {
    var value = eval(args.head, e).value;
    for (args = args.tail; args != null; args = args.tail) {
      value %= eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _lessThan(Environment e, args) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return lhs.compareTo(rhs) < 0;
  }

  static _lessThanOrEqual(Environment e, args) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return lhs.compareTo(rhs) <= 0;
  }

  static _equal(Environment e, args) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return lhs == rhs;
  }

  static _notEqual(Environment e, args) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return lhs != rhs;
  }

  static _greaterThan(Environment e, args) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return lhs.compareTo(rhs) > 0;
  }

  static _greaterThanOrEqual(Environment e, args) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return lhs.compareTo(rhs) >= 0;
  }

  static _cons(Environment e, args) {
    final head = eval(args.head, e);
    final tail = eval(args.tail.head, e);
    return datum.Pair(head, tail);
  }

  static _car(Environment e, args) {
    final cons = eval(args.head, e);
    return cons is datum.Pair ? cons.head : datum.Null.instance;
  }

  static _carSet(Environment e, args) {
    final cons = eval(args.head, e);
    if (cons is datum.Pair) {
      cons.car = eval(args.tail.head, e);
    }
    return cons;
  }

  static _cdr(Environment e, args) {
    final cons = eval(args.head, e);
    return cons is datum.Pair ? cons.tail : datum.Null.instance;
  }

  static _cdrSet(Environment e, args) {
    final cons = eval(args.head, e);
    if (cons is datum.Pair) {
      cons.cdr = eval(args.tail.head, e);
    }
    return cons;
  }
}
