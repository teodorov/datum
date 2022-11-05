import 'dart:core' as core;

import 'package:datum/src/domains/environment.dart';
import '../evaluation/printer.dart';
import '../cesk/closure.dart';

abstract class DatumVisitor {
  visitDatum(Datum item);
  visitNull(Null item);
  visitPair(Pair item);
  visitDottedPair(DottedPair item);
  visitProperList(ProperList item);
  visitDefinition(Definition item);
  visitCommented(Commented item);
  visitLiteral(Literal item);
  visitBoolean(Boolean item);
  visitNumber(Number item);
  visitCharacter(Character item);
  visitString(String item);
  visitSymbol(Symbol item);
  visitPrimitive(Primitive item);
  visitClosure(Closure item);
  visitKlosure(Klosure item) {
    return null;
  }

  visitEnvironment(Environment item);
  visitQuote(Quote item);
}

abstract class Datum {
  accept(visitor) {
    return visitor.visitDatum(this);
  }

  @core.override
  core.String toString() {
    if (this is Pair) {
      return '(${accept(DatumPrinter())})';
    }
    return '${accept(DatumPrinter())}';
  }
}

//function value
class Closure extends Datum {
  Closure(this.code, this.formals, this.numberOfMandatoryArguments,
      this.environment, this.isVariadic);

  final Environment environment;
  final Datum code;
  final core.List<Datum>
      formals; //Datum can be only Symbol and (optional argument) Pair where car is Symbol and cdr is initial expression
  final core.bool isVariadic;
  final core.int numberOfMandatoryArguments;

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

  // set setCdr(Datum datum) => cdr = datum;

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

  factory Boolean.fromDart(core.bool value) {
    return value ? dTrue : dFalse;
  }

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

class Quote extends Datum {
  Quote(this.datum);
  final Datum datum;

  @core.override
  accept(visitor) {
    return visitor.visitQuote(this);
  }
}
