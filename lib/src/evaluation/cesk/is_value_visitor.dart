import 'package:datum/src/model/datum_model.dart' as datum;

import 'closure.dart';

isValue(datum.Datum item) {
  return item.accept(IsValueVisitor());
}

class IsValueVisitor extends datum.DatumVisitor {
  IsValueVisitor.private();

  factory IsValueVisitor() => _instance;

  static final IsValueVisitor _instance = IsValueVisitor.private();
  @override
  visitBoolean(datum.Boolean item) {
    return true;
  }

  @override
  visitCharacter(datum.Character item) {
    return true;
  }

  @override
  visitKlosure(Klosure item) {
    return true;
  }

  @override
  visitCommented(datum.Commented item) {
    return false;
  }

  @override
  visitDatum(datum.Datum item) {
    return false;
  }

  @override
  visitDefinition(datum.Definition item) {
    return false;
  }

  @override
  visitDottedPair(datum.DottedPair item) {
    return false;
  }

  @override
  visitLiteral(datum.Literal item) {
    return true;
  }

  @override
  visitNull(datum.Null item) {
    return true;
  }

  @override
  visitNumber(datum.Number item) {
    return true;
  }

  @override
  visitPair(datum.Pair item) {
    return false;
  }

  @override
  visitPrimitive(datum.Primitive item) {
    return false;
  }

  @override
  visitProperList(datum.ProperList item) {
    return false;
  }

  @override
  visitQuote(datum.Quote item) {
    return false;
  }

  @override
  visitString(datum.String item) {
    return true;
  }

  @override
  visitSymbol(datum.Symbol item) {
    return false;
  }
}
