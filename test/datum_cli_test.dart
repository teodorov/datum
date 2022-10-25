import 'package:datum_cli/datum_cli.dart';
import 'package:datum_cli/src/domains/Environment.dart';
import 'package:test/test.dart';
import 'package:datum_cli/src/model/datum_ast.dart' as datum;

void main() {
  var rpl = Antlr4DatumReader().antlr4tree;
  test('plus_nat', () {
    expect(rpl('(+ 3 2)'),
        '(datum (composite_datum ( (datum (leaf_datum +)) (datum (leaf_datum 3)) (datum (leaf_datum 2)) )))');
  });

  test('boolean_literals', () {
    expect(rpl('true'), '(datum (leaf_datum true))');
    expect(rpl('false'), '(datum (leaf_datum false))');
    expect(rpl('(false)'),
        '(datum (composite_datum ( (datum (leaf_datum false)) )))');
  });

  var reader = DatumReader().parseString;

  test('simp parse datum', () {
    var datum = reader("(+ 3 2)");
    expect(datum.toString(), '(+ 3 2)');
  });

  test('simp parse definition', () {
    var datum = reader("[titi]= (+ 3 2)");
    expect(datum.toString(), '([titi]= (+ 3 2))');
  });

  test('symbol', () {
    expect(reader('symbol').toString(), '(symbol)');
    var exp = reader('(symbol1 symbol1)');
    var s1 = exp.car;
    var s2 = exp.cdr.car;
    assert(s1 == s2);
  });

  test('boolean', () {
    identical(reader('true'), datum.Boolean.dTrue);
    expect(reader('true').toString(), '(true)');
    expect(reader('(true)').toString(), '(true)');
    identical(reader('false'), datum.Boolean.dFalse);
    expect(reader('false').toString(), '(false)');
    expect(reader('(false)').toString(), '(false)');
  });

  test('number', () {
    expect(reader('23').toString(), '(23)');
    expect(reader('23').value, 23);
    expect(reader('23.43').value, 23.43);
    expect(reader('+23.43').value, 23.43);
    expect(reader('-23.43').value, -23.43);
  });

  test('pair', () {
    expect(reader('(a (b c) . b)').toString(), '(a (b c) b)');
    expect(reader('(fa 3)').toString(), '(fa 3)');
    expect(reader('(fa . 3)').toString(), '(fa 3)');
    expect(reader('(2 fa . 3)').toString(), '(2 fa 3)');
    expect(reader('(2 fa 3)').toString(), '(2 fa 3)');
    expect(reader('(2 . (fa . (3 . ())))').toString(), '(2 fa 3)');
    expect(reader('((2 x) fa 3)').toString(), '((2 x) fa 3)');
    expect(reader('((() ()) fa 3)').toString(), '((() ()) fa 3)');
  });

  test('primitive', () {
    var a = datum.Symbol('a');
    var b = datum.Primitive('a', 23);
    expect(a, isNot(equals(b)));

    var c = datum.Symbol('a');
    identical(a, c);
    var d = datum.Primitive('a', 24);
    expect(b, isNot(equals(d)));
    identical(b.name, d.name);
  });

  var primitives = PrimitiveEnvironment(null);
  test('eval add', () {
    var exp = reader('(+ 1 2)');
    var result = eval(exp, primitives);
    expect(result.value, 3);
    exp = reader('(+ 1 2 3 4)');
    expect(eval(exp, primitives).value, 10);
  });

  test('eval lambda', () {
    var exp = reader('(lambda ((quote x) (quote y)) (+ x y))');
    var closure = eval(exp, primitives);
    expect(closure, isA<datum.Closure>());
    expect(closure.environment.symbols.length, 2);

    exp = reader('(lambda () (+ x y))');
    closure = eval(exp, primitives);
    expect(closure.environment.symbols.length, 0);

    exp = reader('(lambda ((quote x)) (+ x y))');
    closure = eval(exp, primitives);
    expect(closure.environment.symbols.length, 1);
  });

  test('eval lambda application', () {
    var exp = reader('((lambda ((quote x) (quote y)) (+ x y)) 2 3)');
    var res = eval(exp, primitives);
    expect(res.value, 5);
  });
}
