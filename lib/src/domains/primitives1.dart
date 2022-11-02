import 'package:datum/src/model/datum_model.dart' as datum;
import 'environment.dart';

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

    definePrimitive(datum.Primitive('sequence', _sequence));
    definePrimitive(datum.Primitive('let', _let));
    definePrimitive(datum.Primitive('letrec', _letrec));
    definePrimitive(datum.Primitive('cond', _cond));
  }
  static _notSupportedError(args, interpreter) {
    throw ArgumentError('${args.toString()} not supported yet!');
  }

  static _define(args, interpreter) {
    var e = interpreter.peek();
    if (args.car is datum.Symbol) {
      var value = args.cdr.car.accept(interpreter);
      e.define(args.car, value);
      return datum.Null.instance;
    }
    if (args.car is datum.Pair) {
      final datum.Pair head = args.car;
      if (head.car is datum.Symbol) {
        e.define(head.car as datum.Symbol,
            _lambda(datum.Pair(head.cdr!, args.cdr), interpreter));
        return datum.Null.instance;
      }
    }
    throw ArgumentError('define invoked with invalid arguments');
  }

  static _lambda(args, interpreter) {
    int numberOfMandatoryArguments = 0;
    if (args.car is datum.Symbol) {
      return datum.Closure(args.cdr.car, [args.car], numberOfMandatoryArguments,
          interpreter.peek(), true);
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
        return datum.Closure(args.cdr.car, formals, numberOfMandatoryArguments,
            interpreter.peek(), true);
      }

      var argument = arg.car;
      if (argument is datum.Pair) {
        hasOptionals = true;
        if (argument.car is! datum.Symbol) {
          throw ArgumentError('lambda formal argument should be a symbol');
        }
        formals
            .add(datum.Pair(argument.car, (argument.cdr! as datum.Pair).car));
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
    return datum.Closure(
        body, formals, numberOfMandatoryArguments, interpreter.peek(), false);
  }

  static _quote(args, interpreter) {
    return args.car;
  }

  static _eval(args, interpreter) {
    return args.car.accept(interpreter).accept(interpreter);
  }

  static _apply(args, interpreter) {
    var closure = args.car.accept(interpreter);
    var arguments = args.cdr.car.accept(interpreter);
    return datum.Pair(closure, arguments).accept(interpreter);
  }

  static _let(args, interpreter) {
    Environment scope = interpreter.peek().create();
    var body = args.cdr.car;
    for (var bindings = args.car;
        bindings != datum.Null.instance;
        bindings = bindings.cdr) {
      var symbol = bindings.car.car;
      if (symbol is! datum.Symbol) {
        throw ArgumentError('a symbol is required as lhs of a let binding');
      }
      var value = bindings.car.cdr.car.accept(interpreter);
      scope.define(symbol, value);
    }
    interpreter.push(scope);
    var result = body.accept(interpreter);
    interpreter.pop();
    return result;
  }

  /// https://www.cs.tufts.edu/comp/150VM/modules/archive/kent-dybvig/letrec.pdf
  /// https://legacy.cs.indiana.edu/~dyb/pubs/letrec-reloaded.pdf
  static _letrec(args, interpreter) {
    Environment scope = interpreter.peek().create();
    for (var bindings = args.car;
        bindings != datum.Null.instance;
        bindings = bindings.cdr) {
      var symbol = bindings.car.car;
      if (symbol is! datum.Symbol) {
        throw ArgumentError('a symbol is required as lhs of a letrec binding');
      }
      scope.define(symbol, datum.Null.instance);
    }

    interpreter.push(scope);
    for (var bindings = args.car;
        bindings != datum.Null.instance;
        bindings = bindings.cdr) {
      var symbol = bindings.car.car;
      var value = bindings.car.cdr.car.accept(interpreter);
      scope[symbol] = value;
    }
    var value = args.cdr.car.accept(interpreter);
    interpreter.pop();
    return value;
  }

  static _set(args, interpreter) {
    return interpreter.peek()[args.car] = args.cdr.car.accept(interpreter);
  }

  static _print(args, interpreter) {
    String data = '';
    while (args != datum.Null.instance) {
      data += args.car.accept(interpreter).toString();
      args = args.tail;
    }
    print(data);
    return datum.Null.instance;
  }

  static _cond(args, interpreter) {
    if (args == datum.Null.instance) {
      return datum.Null.instance;
    }
    //(else (exp ()))
    if (args.car.car == datum.Symbol('else')) {
      return args.car.cdr.car.accept(interpreter);
    }
    //((condition ()) (exp ())) --> condition is false
    // fall through to the next case
    if (args.car.car.accept(interpreter) == datum.Boolean.dFalse) {
      return args.cdr.accept(interpreter);
    }
    //((condition ()) (exp ())) --> condition is true
    return args.car.cdr.car.accept(interpreter);
  }

  static _if(args, interpreter) {
    final condition = args.car.accept(interpreter);
    if (condition is! datum.Boolean) {
      throw ArgumentError('if call with non-boolean condition');
    }
    if (args.tail == datum.Null.instance) return datum.Null.instance;
    if (condition == datum.Boolean.dTrue) {
      return args.cdr.car.accept(interpreter);
    }
    if (args.tail.tail == datum.Null.instance) return datum.Null.instance;
    return args.cdr.cdr.car.accept(interpreter);
  }

  static _sequence(args, interpreter) {
    datum.Datum result = datum.Null.instance;
    for (var exp = args; exp != datum.Null.instance; exp = exp.cdr) {
      result = exp.car.accept(interpreter);
    }
    return result;
  }

  static _and(args, interpreter) {
    while (args != null) {
      var operand = args.car.accept(interpreter);
      if (operand is! datum.Boolean) {
        throw ArgumentError("'and' defined only with boolean arguments");
      }
      if (operand == datum.Boolean.dFalse) {
        return datum.Boolean.dFalse;
      }
      args = args.cdr;
    }
    return datum.Boolean.dTrue;
  }

  static _or(args, interpreter) {
    while (args != null) {
      var operand = args.car.accept(interpreter);
      if (operand is! datum.Boolean) {
        throw ArgumentError("'or' defined only with boolean arguments");
      }
      if (operand == datum.Boolean.dTrue) {
        return datum.Boolean.dTrue;
      }
      args = args.cdr;
    }
    return datum.Boolean.dFalse;
  }

  static _not(args, interpreter) {
    var operand = args.car.accept(interpreter);
    if (operand is! datum.Boolean) {
      throw ArgumentError("'not' defined only with boolean arguments");
    }
    return datum.Boolean.fromDart(operand != datum.Boolean.dTrue);
  }

  static _plus(args, interpreter) {
    var value = args.car.accept(interpreter).value;
    for (args = args.cdr; args != datum.Null.instance; args = args.cdr) {
      value += args.car.accept(interpreter).value;
    }
    return datum.Number.fromDart(value);
  }

  static _minus(args, interpreter) {
    var value = args.car.accept(interpreter).value;
    if (args.tail == datum.Null) {
      return datum.Number.fromDart(-value);
    }
    for (args = args.cdr; args != datum.Null.instance; args = args.cdr) {
      value -= args.car.accept(interpreter).value;
    }
    return datum.Number.fromDart(value);
  }

  static _multiply(args, interpreter) {
    var value = args.car.accept(interpreter).value;
    for (args = args.cdr; args != datum.Null.instance; args = args.cdr) {
      value *= args.car.accept(interpreter).value;
    }
    return datum.Number.fromDart(value);
  }

  static _divide(args, interpreter) {
    var value = args.car.accept(interpreter).value;
    for (args = args.cdr; args != datum.Null.instance; args = args.cdr) {
      value /= args.car.accept(interpreter).value;
    }
    return datum.Number.fromDart(value);
  }

  static _modulo(args, interpreter) {
    var value = args.car.accept(interpreter).value;
    for (args = args.cdr; args != datum.Null.instance; args = args.cdr) {
      value %= args.car.accept(interpreter).value;
    }
    return datum.Number.fromDart(value);
  }

  static _lessThan(args, interpreter) {
    final lhs = args.car.accept(interpreter).value;
    final rhs = args.cdr.car.accept(interpreter).value;
    return datum.Boolean.fromDart(lhs.compareTo(rhs) < 0);
  }

  static _lessThanOrEqual(args, interpreter) {
    final lhs = args.car.accept(interpreter).value;
    final rhs = args.cdr.car.accept(interpreter).value;
    return datum.Boolean.fromDart(lhs.compareTo(rhs) <= 0);
  }

  static _equal(args, interpreter) {
    final lhs = args.car.accept(interpreter);
    final rhs = args.cdr.car.accept(interpreter);
    return datum.Boolean.fromDart(lhs == rhs);
  }

  static _notEqual(args, interpreter) {
    final lhs = args.car.accept(interpreter).value;
    final rhs = args.cdr.car.accept(interpreter).value;
    return datum.Boolean.fromDart(lhs != rhs);
  }

  static _greaterThan(args, interpreter) {
    final lhs = args.car.accept(interpreter).value;
    final rhs = args.cdr.car.accept(interpreter).value;
    return datum.Boolean.fromDart(lhs.compareTo(rhs) > 0);
  }

  static _greaterThanOrEqual(args, interpreter) {
    final lhs = args.car.accept(interpreter).value;
    final rhs = args.cdr.car.accept(interpreter).value;
    return datum.Boolean.fromDart(lhs.compareTo(rhs) >= 0);
  }

  static _cons(args, interpreter) {
    final head = args.car.accept(interpreter);
    final tail = args.cdr.car.accept(interpreter);
    return datum.Pair(head, tail);
  }

  static _car(args, interpreter) {
    final cons = args.car.accept(interpreter);
    return cons is datum.Pair ? cons.car : datum.Null.instance;
  }

  static _carSet(args, interpreter) {
    final cons = args.car.accept(interpreter);
    if (cons is datum.Pair) {
      cons.car = args.cdr.car.accept(interpreter);
    }
    return cons;
  }

  static _cdr(args, interpreter) {
    final cons = args.car.accept(interpreter);
    return cons is datum.Pair ? cons.cdr : datum.Null.instance;
  }

  static _cdrSet(args, interpreter) {
    final cons = args.car.accept(interpreter);
    if (cons is datum.Pair) {
      cons.cdr = args.cdr.car.accept(interpreter);
    }
    return cons;
  }

  static _isNull(args, interpreter) {
    var operand = args.car.accept(interpreter);
    return datum.Boolean.fromDart(operand == datum.Null.instance);
  }

  static _isBoolean(args, interpreter) {
    var operand = args.car.accept(interpreter);
    return datum.Boolean.fromDart(operand is datum.Boolean);
  }

  static _isChar(args, interpreter) {
    var operand = args.car.accept(interpreter);
    return datum.Boolean.fromDart(operand is datum.Character);
  }

  static _isNumber(args, interpreter) {
    var operand = args.car.accept(interpreter);
    return datum.Boolean.fromDart(operand is datum.Number);
  }

  static _isSymbol(args, interpreter) {
    var operand = args.car.accept(interpreter);
    return datum.Boolean.fromDart(operand is datum.Symbol);
  }

  static _isString(args, interpreter) {
    var operand = args.car.accept(interpreter);
    return datum.Boolean.fromDart(operand is datum.String);
  }

  static _isPair(args, interpreter) {
    var operand = args.car.accept(interpreter);
    return datum.Boolean.fromDart(operand is datum.Pair);
  }

  static _isProcedure(args, interpreter) {
    var operand = args.car.accept(interpreter);
    return datum.Boolean.fromDart(
        operand is datum.Closure || operand is datum.Primitive);
  }
}
