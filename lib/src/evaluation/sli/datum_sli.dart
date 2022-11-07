import 'package:datum/src/evaluation/cesk/closure.dart';
import 'package:datum/src/evaluation/cesk/configuration.dart';
import 'package:datum/src/evaluation/cesk/is_value_visitor.dart';
import 'package:datum/src/evaluation/reader.dart';
import 'package:datum/src/evaluation/sli/datum_rules.dart';
import 'package:datum/src/evaluation/sli/rule.dart';
import 'package:datum/src/model/datum_model.dart' as datum;

read(String expression) => DatumReader().parseString(expression);
print(datum.Datum expression) => expression.toString();

class DatumSLI {
  DatumSLI(this.expression);
  datum.Datum expression;
  late DatumSTR semantics = DatumSTR(this);
}

class DatumSTR {
  DatumSTR(this.parent);
  DatumSLI parent;

  initial() {
    return [inject(parent.expression)];
  }

  actions(c) {
    return getActions(c);
  }

  execute(a, c) => [a.action.code(c)];
}

initial() {}

getActions(c) {
  var theRules = rules();
  if (isValue(c.control) ||
      (c.control is datum.Pair &&
          isValue(c.control.car) &&
          !isFunction(c.control.car))) {
    return theRules['kont'].where((r) =>
        (c.kontinuation.runtimeType == (r as KontinuationRule).frameType) &&
        r.guard.code(c) as bool); //.map((r) => r.action);
  }
  return theRules['eval']
      .where((r) => r.guard.code(c) as bool); //.map((r) => r.action);
}

Configuration inject(datum.Datum expression) =>
    Configuration(expression, Environment(), [], EndFrame());

datum.Datum eval(datum.Datum expression) {
  var initial = inject(expression);
  Configuration? source = initial;
  while (source != null) {
    var enabled = getActions(source);
    if (enabled.length > 1) {
      throw AssertionError('Non-determinism unexpected');
    }
    var target = enabled.first.action.code(source);
    if (target == source) {
      return target.control;
    }
    source = target;
  }
  //we got stuck
  return datum.Null.instance;
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
