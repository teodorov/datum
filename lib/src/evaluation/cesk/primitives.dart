import 'package:datum/src/evaluation/cesk/configuration.dart';
import 'package:datum/src/model/datum_model.dart' as datum;
import 'closure.dart';

lambda2closure(args, environment) {
  int numberOfMandatoryArguments = 0;
  if (args.car is datum.Symbol) {
    return Klosure(args.cdr.car, [args.car], numberOfMandatoryArguments,
        environment, true);
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
      return Klosure(
          args.cdr.car, formals, numberOfMandatoryArguments, environment, true);
    }

    var argument = arg.car;
    if (argument is datum.Pair) {
      hasOptionals = true;
      if (argument.car is! datum.Symbol) {
        throw ArgumentError('lambda formal argument should be a symbol');
      }
      formals.add(datum.Pair(argument.car, (argument.cdr! as datum.Pair).car));
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
  return Klosure(body, formals, numberOfMandatoryArguments, environment, false);
}

define(e, s, datum.Primitive primitive) {
  e.define(primitive.name, s.length);
  s.add(primitive);
}

createPrimitiveEnvironment(e, List<datum.Datum> s) {
  define(e, s, datum.Primitive('<=', _lessThanOrEqual));
  define(e, s, datum.Primitive('-', _minus));
  define(e, s, datum.Primitive('*', _multiply));
}

_lessThanOrEqual(args) {
  final lhs = args[0].value;
  final rhs = args[1].value;
  return datum.Boolean.fromDart(lhs.compareTo(rhs) <= 0);
}

_minus(args) {
  var value = args[0].value;
  if (args.length == 1) {
    return datum.Number.fromDart(-value);
  }
  for (int idx = 1; idx < args.length; idx++) {
    value -= args[idx].value;
  }
  return datum.Number.fromDart(value);
}

_multiply(args) {
  var value = args[0].value;
  for (var idx = 1; idx < args.length; idx++) {
    value *= args[idx].value;
  }
  return datum.Number.fromDart(value);
}
