import 'package:datum/src/model/datum_model.dart' as datum;
import 'package:datum/src/evaluation/cesk/closure.dart';

String printer(datum.Datum e) {
  return e.toString();
}

class DatumPrinter extends datum.DatumVisitor {
  @override
  visitBoolean(datum.Boolean item) {
    return item.literal;
  }

  @override
  visitCharacter(datum.Character item) {
    return '#\\${item.literal}';
  }

  @override
  visitCommented(datum.Commented item) {
    return '#; ${item.datum.accept(this)}';
  }

  @override
  visitDatum(datum.Datum item) {
    throw UnimplementedError();
  }

  @override
  visitDefinition(datum.Definition item) {
    return '[${item.name.accept(this)}]= (${item.datum.accept(this)})';
  }

  @override
  visitNull(datum.Null item) {
    return '()';
  }

  @override
  visitPair(datum.Pair item) {
    String head = item.head is datum.Pair
        ? '(${item.head.accept(this)})'
        : item.head.accept(this);

    return item.tail == datum.Null.instance
        ? head
        : '$head ${item.tail.accept(this)}';
  }

  @override
  visitDottedPair(datum.DottedPair item) {
    String prefix = item.prefix
        .map((e) => e.accept(this))
        .fold("", (previousValue, element) => '$previousValue $element');
    return '($prefix . ${item.tail!.accept(this)})';
  }

  @override
  visitLiteral(datum.Literal item) {
    throw UnimplementedError();
  }

  @override
  visitNumber(datum.Number item) {
    return item.literal;
  }

  @override
  visitProperList(datum.ProperList item) {
    var contents = item.items.map((e) => e.accept(this)).fold(
        '',
        (previousValue, element) =>
            previousValue == '' ? element : '$previousValue $element');
    return '($contents)';
  }

  @override
  visitString(datum.String item) {
    return '"${item.literal}"';
  }

  @override
  visitSymbol(datum.Symbol item) {
    return item.literal;
  }

  @override
  visitPrimitive(datum.Primitive item) {
    return item.primitive;
  }

  @override
  visitKlosure(Klosure item) {
    printElement(e) {
      return e is datum.Pair ? '(${e.accept(this)})' : '${e.accept(this)}';
    }

    var formals = item.formals.fold(
        '',
        (previousValue, element) => previousValue == ''
            ? printElement(element)
            : '$previousValue ${printElement(element)}');
    return '(klosure ρ [formals]=${item.isVariadic && item.formals.length == 1 ? formals : '($formals)'} [code]=${item.code.accept(this)} [numberOfMandatoryArguments]=${item.numberOfMandatoryArguments} [isVariadic]=${item.isVariadic})';
  }

  @override
  visitQuote(datum.Quote item) {
    return "'${item.datum.accept(this)}";
  }
}
