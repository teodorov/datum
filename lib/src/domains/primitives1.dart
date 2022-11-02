import 'package:datum/src/model/datum_model.dart' as datum;
import 'environment.dart';
import 'package:datum/src/evaluation/evaluator1.dart';

class PrimitiveEnvironment extends Environment {
  PrimitiveEnvironment(super.parent) {
    //basic functions
    definePrimitive(datum.Primitive('define', _define));
    definePrimitive(datum.Primitive('lambda', _lambda));
    definePrimitive(datum.Primitive('quote', _quote));
    definePrimitive(datum.Primitive('if', _if));

    definePrimitive(datum.Primitive('set!', _set)); //assignment

    definePrimitive(datum.Primitive('eval', _eval));
    definePrimitive(datum.Primitive('apply', _apply));

    definePrimitive(datum.Primitive('print', _print));

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

    //primitive predicates
    definePrimitive(datum.Primitive('null?', _isNull));
    definePrimitive(datum.Primitive('boolean?', _isBoolean));
    definePrimitive(datum.Primitive('char?', _isChar));
    definePrimitive(datum.Primitive('number?', _isNumber));
    definePrimitive(datum.Primitive('symbol?', _isSymbol));
    definePrimitive(datum.Primitive('string?', _isString));
    definePrimitive(datum.Primitive('pair?', _isPair));
    definePrimitive(datum.Primitive('procedure?', _isProcedure));
  }
  static _notSupportedError(args, Environment e) {
    throw ArgumentError('${args.toString()} not supported yet!');
  }

  static _define(args, Environment e) {
    if (args.car is datum.Symbol) {
      return e.define(args.car, eval(args.cdr.car, e));
    }
    if (args.car is datum.Pair) {
      final datum.Pair head = args.car;
      if (head.car is datum.Symbol) {
        return e.define(head.car as datum.Symbol,
            _lambda(datum.Pair(head.cdr!, args.cdr), e));
      }
    }
    throw ArgumentError('define invoked with invalid arguments');
  }

  static _lambda(args, Environment e) {
    int numberOfMandatoryArguments = 0;
    if (args.car is datum.Symbol) {
      return datum.Closure(
          args.cdr.car, [args.car], numberOfMandatoryArguments, e, true);
    }
    if (args.car is! datum.Null && args.car is! datum.Pair) {
      throw ArgumentError('lambda formal argument should be a symbol');
    }
    List<datum.Datum> formals = [];
    bool hasOptionals = false;
    for (var arg = args.car; arg != datum.Null.instance; arg = arg.cdr) {
      if (arg is datum.Symbol) {
        //the last element of a dotted pair (x y . arg)
        formals.add(arg);
        return datum.Closure(
            args.cdr.car, formals, numberOfMandatoryArguments, e, true);
      }

      var argument = arg.car;
      if (argument is datum.Pair) {
        hasOptionals = true;
        if (argument.car is! datum.Symbol) {
          throw ArgumentError('lambda formal argument should be a symbol');
        }
        formals.add(datum.Pair(argument.car, argument.cdr));
        continue;
      }
      if (hasOptionals) {
        throw ArgumentError(
            'lambda: mandatory arguments not allowed after an optional argument');
      }
      if (argument is! datum.Symbol) {
        throw ArgumentError('lambda formal argument should be a symbol');
      }
      formals.add(argument);
      numberOfMandatoryArguments++;
    }

    var body = args.cdr.car;
    return datum.Closure(body, formals, numberOfMandatoryArguments, e, false);
  }

  static _quote(args, Environment e) {
    return args.car;
  }

  static _eval(args, Environment e) {
    return eval(eval(args.car, e), e);
  }

  static _apply(args, Environment e) {
    var closure = eval(args.car, e);
    var arguments = eval(args.cdr.car, e);
    return xapply(closure, arguments, e);
  }

  static _let(args, Environment e) {
    Environment scope = e.create();
    var body = args.cdr.car;
    for (var bindings = args.car;
        bindings != datum.Null.instance;
        bindings = bindings.cdr) {
      var symbol = bindings.car.car;
      if (symbol is! datum.Symbol) {
        throw ArgumentError('a symbol is required as lhs of a let binding');
      }
      var value = eval(bindings.car.cdr.car, e);
      scope.define(symbol, value);
    }
    return eval(body, scope);
  }

  /// https://www.cs.tufts.edu/comp/150VM/modules/archive/kent-dybvig/letrec.pdf
  /// https://legacy.cs.indiana.edu/~dyb/pubs/letrec-reloaded.pdf
  static _letrec(args, Environment e) {
    Environment scope = e.create();
    for (var bindings = args.car;
        bindings != datum.Null.instance;
        bindings = bindings.cdr) {
      var symbol = bindings.car.car;
      if (symbol is! datum.Symbol) {
        throw ArgumentError('a symbol is required as lhs of a letrec binding');
      }
      scope.define(symbol, datum.Null.instance);
    }

    for (var bindings = args.car;
        bindings != datum.Null.instance;
        bindings = bindings.cdr) {
      var symbol = bindings.car.car;
      var value = eval(bindings.car.cdr.car, scope);
      scope[symbol] = value;
    }

    return eval(args.cdr.car, scope);
  }

  static _set(args, Environment e) {
    return e[args.car] = eval(args.cdr.car, e);
  }

  static _print(args, Environment e) {
    String data = '';
    while (args != datum.Null.instance) {
      data += eval(args.car, e).literal;
      args = args.tail;
    }
    print(data);
    return datum.Null.instance;
  }

  static _cond(args, Environment e) {
    if (args == datum.Null.instance) {
      return datum.Null.instance;
    }
    //(else (exp ()))
    if (args.car.car == datum.Symbol('else')) {
      return eval(args.car.cdr.car, e);
    }
    //((condition ()) (exp ())) --> condition is false
    // fall through to the next case
    if (eval(args.car.car, e) == datum.Boolean.dFalse) {
      return eval(args.cdr, e);
    }
    //((condition ()) (exp ())) --> condition is true
    return eval(args.car.cdr.car, e);
  }

  static _if(args, Environment e) {
    final condition = eval(args.head, e);
    if (condition is! datum.Boolean) {
      throw ArgumentError('if call with non-boolean condition');
    }
    if (args.tail == datum.Null.instance) return datum.Null.instance;
    if (condition == datum.Boolean.dTrue) {
      return eval(args.tail.head, e);
    }
    if (args.tail.tail == datum.Null.instance) return datum.Null.instance;
    return eval(args.tail.tail.head, e);
  }

  static _sequence(args, Environment e) {
    datum.Datum result = datum.Null.instance;
    for (var exp = args; exp != datum.Null.instance; exp = exp.cdr) {
      result = eval(exp.car, e);
    }
    return result;
  }

  static _and(args, Environment e) {
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

  static _or(args, Environment e) {
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

  static _not(args, Environment e) {
    var operand = eval(args.head, e);
    if (operand is! datum.Boolean) {
      throw ArgumentError("'not' defined only with boolean arguments");
    }
    return datum.Boolean.fromDart(operand != datum.Boolean.dTrue);
  }

  static _plus(args, Environment e) {
    var value = eval(args.head, e).value;
    for (args = args.tail; args != datum.Null.instance; args = args.tail) {
      value += eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _minus(args, Environment e) {
    var value = eval(args.head, e).value;
    if (args.tail == datum.Null) {
      return datum.Number.fromDart(-value);
    }
    for (args = args.tail; args != datum.Null.instance; args = args.tail) {
      value -= eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _multiply(args, Environment e) {
    var value = eval(args.head, e).value;
    for (args = args.tail; args != datum.Null.instance; args = args.tail) {
      value *= eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _divide(args, Environment e) {
    var value = eval(args.head, e).value;
    for (args = args.tail; args != datum.Null.instance; args = args.tail) {
      value /= eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _modulo(args, Environment e) {
    var value = eval(args.head, e).value;
    for (args = args.tail; args != datum.Null.instance; args = args.tail) {
      value %= eval(args.head, e).value;
    }
    return datum.Number.fromDart(value);
  }

  static _lessThan(args, Environment e) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return datum.Boolean.fromDart(lhs.compareTo(rhs) < 0);
  }

  static _lessThanOrEqual(args, Environment e) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return datum.Boolean.fromDart(lhs.compareTo(rhs) <= 0);
  }

  static _equal(args, Environment e) {
    final lhs = eval(args.car, e);
    final rhs = eval(args.cdr.car, e);
    return datum.Boolean.fromDart(lhs == rhs);
  }

  static _notEqual(args, Environment e) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return datum.Boolean.fromDart(lhs != rhs);
  }

  static _greaterThan(args, Environment e) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return datum.Boolean.fromDart(lhs.compareTo(rhs) > 0);
  }

  static _greaterThanOrEqual(args, Environment e) {
    final lhs = eval(args.car, e).value;
    final rhs = eval(args.cdr.car, e).value;
    return datum.Boolean.fromDart(lhs.compareTo(rhs) >= 0);
  }

  static _cons(args, Environment e) {
    final head = eval(args.head, e);
    final tail = eval(args.tail.head, e);
    return datum.Pair(head, tail);
  }

  static _car(args, Environment e) {
    final cons = eval(args.head, e);
    return cons is datum.Pair ? cons.head : datum.Null.instance;
  }

  static _carSet(args, Environment e) {
    final cons = eval(args.head, e);
    if (cons is datum.Pair) {
      cons.car = eval(args.tail.head, e);
    }
    return cons;
  }

  static _cdr(args, Environment e) {
    final cons = eval(args.head, e);
    return cons is datum.Pair ? cons.tail : datum.Null.instance;
  }

  static _cdrSet(args, Environment e) {
    final cons = eval(args.head, e);
    if (cons is datum.Pair) {
      cons.cdr = eval(args.tail.head, e);
    }
    return cons;
  }

  static _isNull(args, Environment e) {
    var operand = eval(args.car, e);
    return datum.Boolean.fromDart(operand == datum.Null.instance);
  }

  static _isBoolean(args, Environment e) {
    var operand = eval(args.car, e);
    return datum.Boolean.fromDart(operand is datum.Boolean);
  }

  static _isChar(args, Environment e) {
    var operand = eval(args.car, e);
    return datum.Boolean.fromDart(operand is datum.Character);
  }

  static _isNumber(args, Environment e) {
    var operand = eval(args.car, e);
    return datum.Boolean.fromDart(operand is datum.Number);
  }

  static _isSymbol(args, Environment e) {
    var operand = eval(args.car, e);
    return datum.Boolean.fromDart(operand is datum.Symbol);
  }

  static _isString(args, Environment e) {
    var operand = eval(args.car, e);
    return datum.Boolean.fromDart(operand is datum.String);
  }

  static _isPair(args, Environment e) {
    var operand = eval(args.car, e);
    return datum.Boolean.fromDart(operand is datum.Pair);
  }

  static _isProcedure(args, Environment e) {
    var operand = eval(args.car, e);
    return datum.Boolean.fromDart(
        operand is datum.Closure || operand is datum.Primitive);
  }
}
