import 'dart:core' as core;

import 'package:datum_cli/src/domains/Environment.dart';

abstract class DatumVisitor {
  visitDatum(Datum datum);
  visitNull(Null datum);
  visitPair(Pair datum);
  visitDottedPair(DottedPair datum);
  visitProperList(ProperList datum);
  visitDefinition(Definition datum);
  visitCommented(Commented datum);
  visitLiteral(Literal datum);
  visitBoolean(Boolean datum);
  visitNumber(Number datum);
  visitCharacter(Character datum);
  visitString(String datum);
  visitSymbol(Symbol datum);
  visitPrimitive(Symbol datum);
  visitClosure(Closure datum);
  visitEnvironment(Environment datum);
}

abstract class Datum {
  accept(visitor) {
    return visitor.visitDatum(this);
  }

  @core.override
  core.String toString() {
    return '(${accept(DatumPrinter())})';
  }
}

//function value
class Closure extends Datum {
  Closure(this.code, this.environment);
  final Environment environment;
  final Datum code;

  @core.override
  accept(visitor) {
    return visitor.visitClosure(this);
  }
}

class Pair extends Datum {
  Pair(this.car, this.cdr);
  Datum car;
  Datum? cdr;

  get head => car;
  get tail => cdr;

  @core.override
  core.bool operator ==(other) =>
      (other is Pair) && (car == other.car) && (cdr == other.cdr);

  @core.override
  core.int get hashCode => 31 * car.hashCode + cdr.hashCode;

  @core.override
  accept(visitor) {
    return visitor.visitPair(this);
  }
}

class Null extends Datum {
  Null._intern();
  static final instance = Null._intern();

  @core.override
  accept(visitor) {
    return visitor.visitNull(this);
  }
}

//unused -- only Pair used now
class DottedPair extends Datum {
  DottedPair(this.prefix, this.tail);
  core.List<Datum> prefix;
  Datum? tail;
  @core.override
  accept(visitor) {
    return visitor.visitDottedPair(this);
  }
}

//unused -- only Pair used now
class ProperList extends Datum {
  ProperList(this.items);
  core.List<Datum> items;
  @core.override
  accept(visitor) {
    return visitor.visitProperList(this);
  }
}

class Definition extends Datum {
  Definition(this.name, this.datum);
  Symbol name;
  Datum datum;
  @core.override
  accept(visitor) {
    return visitor.visitDefinition(this);
  }
}

class Commented extends Datum {
  Commented(this.datum);
  Datum datum;

  @core.override
  accept(visitor) {
    return visitor.visitCommented(this);
  }
}

abstract class Literal extends Datum {
  Literal(this.literal);
  core.String literal;

  @core.override
  accept(visitor) {
    return visitor.visitLiteral(this);
  }
}

class Boolean extends Literal {
  Boolean._intern(super.literal);

  static final dTrue = Boolean._intern('true');
  static final dFalse = Boolean._intern('false');

  @core.override
  accept(visitor) {
    return visitor.visitBoolean(this);
  }
}

class Number extends Literal {
  Number(super.literal) {
    value = core.num.parse(literal);
  }
  factory Number.fromDart(value) {
    return Number(value.toString());
  }
  late final core.num value;

  @core.override
  accept(visitor) {
    return visitor.visitNumber(this);
  }

  @core.override
  core.bool operator ==(other) => (other is Number) && (value == other.value);

  @core.override
  core.int get hashCode => value.hashCode;
}

class Character extends Literal {
  Character(super.literal);

  @core.override
  accept(visitor) {
    return visitor.visitCharacter(this);
  }
}

class String extends Literal {
  String(super.literal);
  @core.override
  accept(visitor) {
    return visitor.visitString(this);
  }
}

class Symbol extends Literal {
  Symbol._internal(super.literal);

  factory Symbol(core.String literal) {
    return _internMap.putIfAbsent(literal, () => Symbol._internal(literal));
  }

  static final core.Map<core.String, Symbol> _internMap = {};

  @core.override
  accept(visitor) {
    return visitor.visitSymbol(this);
  }
}

class Primitive extends Datum {
  Primitive._internal(this.name, this.primitive);

  factory Primitive(core.String name, primitive) {
    return Primitive._internal(Symbol(name), primitive);
  }
  final Symbol name;
  final core.dynamic primitive;

  static final core.Map<Symbol, core.dynamic> primitives = {};

  @core.override
  accept(visitor) {
    return visitor.visitPrimitive(this);
  }
}

class DatumPrinter extends DatumVisitor {
  @core.override
  visitBoolean(Boolean datum) {
    return datum.literal;
  }

  @core.override
  visitCharacter(Character datum) {
    return '(#\\${datum.literal})';
  }

  @core.override
  visitCommented(Commented datum) {
    return '#; ${datum.datum.accept(this)}';
  }

  @core.override
  visitDatum(Datum datum) {
    throw core.UnimplementedError();
  }

  @core.override
  visitDefinition(Definition datum) {
    return '[${datum.name.accept(this)}]= (${datum.datum.accept(this)})';
  }

  @core.override
  visitNull(Null datum) {
    return '()';
  }

  @core.override
  visitPair(Pair datum) {
    core.String head = datum.head is Pair
        ? '(${datum.head.accept(this)})'
        : datum.head.accept(this);

    return datum.tail == Null.instance
        ? head
        : '$head ${datum.tail.accept(this)}';
  }

  // @core.override
  // visitPair(Pair datum) {
  //   core.String head = datum.head.accept(this);
  //   core.String tail = datum.tail == null ? '()' : datum.tail.accept(this);

  //   return '($head . $tail)';
  // }

  @core.override
  visitDottedPair(DottedPair datum) {
    core.String prefix = datum.prefix
        .map((e) => e.accept(this))
        .fold("", (previousValue, element) => '$previousValue $element');
    return '($prefix . ${datum.tail!.accept(this)})';
  }

  @core.override
  visitLiteral(Literal datum) {
    throw core.UnimplementedError();
  }

  @core.override
  visitNumber(Number datum) {
    return datum.literal;
  }

  @core.override
  visitProperList(ProperList datum) {
    var contents = datum.items.map((e) => e.accept(this)).fold(
        '',
        (previousValue, element) =>
            previousValue == '' ? element : '$previousValue $element');
    return '($contents)';
  }

  @core.override
  visitString(String datum) {
    return '"${datum.literal}"';
  }

  @core.override
  visitSymbol(Symbol datum) {
    return datum.literal;
  }

  @core.override
  visitPrimitive(Symbol datum) {
    return datum.literal;
  }

  @core.override
  visitClosure(Closure datum) {
    return '(closure ${datum.code.accept(this)} ${datum.environment.accept(this)})';
  }

  @core.override
  visitEnvironment(Environment datum) {
    return '(environment (${datum.entries.fold('', (previousValue, element) => '$previousValue (${element.key} . ${element.value.accept(this)})')}))';
  }
}
