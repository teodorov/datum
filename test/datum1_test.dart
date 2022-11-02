import 'dart:math';

import 'package:datum/src/evaluation/reader.dart';
import 'package:datum/src/evaluation/printer.dart';
import 'package:datum/src/domains/primitives1.dart';
import 'package:datum/src/evaluation/evaluator1.dart';
import 'package:test/test.dart';
import 'package:datum/src/model/datum_model.dart' as datum;

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
    expect(datum.toString(), '[titi]= (+ 3 2)');
  });

  test('symbol', () {
    expect(reader('symbol').toString(), 'symbol');
    var exp = reader('(symbol1 symbol1)');
    var s1 = exp.car;
    var s2 = exp.cdr.car;
    assert(s1 == s2);
  });

  test('boolean', () {
    identical(reader('true'), datum.Boolean.dTrue);
    expect(reader('true').toString(), 'true');
    expect(reader('(true)').toString(), '(true)');
    identical(reader('false'), datum.Boolean.dFalse);
    expect(reader('false').toString(), 'false');
    expect(reader('(false)').toString(), '(false)');
  });

  test('character', () {
    expect(reader('#\\c').toString(), '#\\c');
  });

  test('number', () {
    expect(reader('23').toString(), '23');
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

  var environment = PrimitiveEnvironment(null).create();
  test('eval add', () {
    var exp = reader('(+ 1 2)');
    var result = eval(exp, environment);
    expect(result.value, 3);
    exp = reader('(+ 1 2 3 4)');
    expect(eval(exp, environment).value, 10);
  });

  re(exp) {
    var reader = DatumReader().parseString;
    return eval(reader(exp), environment);
  }

  test('lambda no arguments', () {
    var closure = re('(lambda () (+ x y))');
    expect(closure.environment, environment);
    expect(closure.formals.length, 0);
    expect(closure.numberOfMandatoryArguments, 0);
    expect(closure.isVariadic, false);
    expect(printer(closure.code), '(+ x y)');
  });
  test('lambda one argument', () {
    var closure = re('(lambda (x) (+ x y))');
    expect(closure.environment, environment);
    expect(closure.formals.length, 1);
    expect(closure.numberOfMandatoryArguments, 1);
    for (var formal in closure.formals) {
      expect(formal, isA<datum.Symbol>());
    }
    expect(closure.isVariadic, false);
    expect(printer(closure.code), '(+ x y)');
  });

  test('lambda two arguments', () {
    var closure = re('(lambda (x y) (+ x y))');
    expect(closure, isA<datum.Closure>());
    expect(closure.environment, environment);
    expect(closure.formals.length, 2);
    expect(closure.numberOfMandatoryArguments, 2);
    for (var formal in closure.formals) {
      expect(formal, isA<datum.Symbol>());
    }
    expect(closure.isVariadic, false);
    expect(printer(closure.code), '(+ x y)');
  });

  test('lambda variadic rest-only', () {
    var closure = re('(lambda x x)');
    expect(closure.environment, environment);
    expect(closure.formals.length, 1);
    expect(closure.numberOfMandatoryArguments, 0);
    for (var formal in closure.formals) {
      expect(formal, isA<datum.Symbol>());
    }
    expect(closure.isVariadic, true);
    expect(printer(closure.code), 'x');
  });

  test('lambda variadic two', () {
    datum.Closure closure = re('(lambda (x . y) x)');
    expect(closure.environment, environment);
    expect(closure.formals.length, 2);
    expect(closure.numberOfMandatoryArguments, 1);
    for (var formal in closure.formals) {
      expect(formal, isA<datum.Symbol>());
    }
    expect(closure.isVariadic, true);
    expect(printer(closure.code), 'x');
  });

  test('lambda variadic three', () {
    datum.Closure closure = re('(lambda (x y . z) x)');
    expect(closure.environment, environment);
    expect(closure.formals.length, 3);
    expect(closure.numberOfMandatoryArguments, 2);
    for (var formal in closure.formals) {
      expect(formal, isA<datum.Symbol>());
    }
    expect(closure.isVariadic, true);
    expect(printer(closure.code), 'x');
  });

  test('lambda only optional', () {
    datum.Closure closure = re('(lambda ((x 1)) x)');
    expect(closure.environment, environment);
    expect(closure.formals.length, 1);
    expect(closure.numberOfMandatoryArguments, 0);
    expect(closure.formals[0], isA<datum.Pair>());
    expect(closure.isVariadic, false);
    expect(printer(closure.code), 'x');
  });

  test('lambda two optional', () {
    datum.Closure closure = re('(lambda ((x 1) (y (+ 2 3))) x)');
    expect(closure.environment, environment);
    expect(closure.formals.length, 2);
    expect(closure.numberOfMandatoryArguments, 0);
    expect(closure.formals[0], isA<datum.Pair>());
    expect(closure.formals[1], isA<datum.Pair>());
    expect(closure.isVariadic, false);
    expect(printer(closure.code), 'x');
  });

  test('lambda mandatory and optional', () {
    datum.Closure closure = re('(lambda (z t (x 1)) x)');
    expect(closure.environment, environment);
    expect(closure.formals.length, 3);
    expect(closure.numberOfMandatoryArguments, 2);
    expect(closure.formals[2], isA<datum.Pair>());
    expect(closure.isVariadic, false);
    expect(printer(closure.code), 'x');
  });

  test('lambda mandatory, optional variadic', () {
    datum.Closure closure = re('(lambda (z t (x 1) . y) x)');
    expect(closure.environment, environment);
    expect(closure.formals.length, 4);
    expect(closure.numberOfMandatoryArguments, 2);
    expect(closure.formals[2], isA<datum.Pair>());
    expect(closure.isVariadic, true);
    expect(printer(closure.code), 'x');
  });

  test('lambda mandatory after optional', () {
    try {
      re('(lambda ((x 1) y) x)');
    } catch (e) {
      expect(e, isArgumentError);
    }
  });

  test('lambda argument should be a symbol', () {
    try {
      re('(lambda (12) x)');
    } catch (e) {
      expect(e, isArgumentError);
    }
  });

  test('lambda rest-only should be a symbol', () {
    try {
      re('(lambda 2 x)');
    } catch (e) {
      expect(e, isArgumentError);
    }
  });

  test('first argument of apply should be a closure', () {
    try {
      re('(2 3)');
    } catch (e) {
      expect(e, isArgumentError);
    }
  });

  test('eval lambda application', () {
    var exp = reader('((lambda (x y) (+ x y)) 2 3)');
    var res = eval(exp, environment);
    expect(res.value, 5);
  });

  test("eval define", () {
    var exp = reader('((define (false? a) (= a false)) true)');
    var res = eval(exp, environment.create());
    expect(res, datum.Boolean.dFalse);

    exp = reader('((define (false? a) (= a false)) (false? true))');
    res = evalList(exp, environment.create());
    expect(res.cdr.car, datum.Boolean.dFalse);

    exp = reader('(define two 2)');
    res = eval(exp, environment);
    expect(res.value, 2);
  });

  test('eval define 1', () {
    var exp = reader('''(
      (define reverse-subtract 
        (lambda (x y) (- y x)))
      (reverse-subtract 7 10)
    )''');
    var res = evalList(exp, environment).cdr.car;
    expect(printer(res), '3');
  });

  test('eval print', () {
    var exp = reader('(print "hello world from datum!")');
    identical(eval(exp, environment), datum.Null.instance);
  });

  test('eval let', () {
    var exp = reader('''(
      let ((x 2) (y 3))
        (* x y)
    )''');
    var res = eval(exp, environment);
    expect(printer(res), '6');
  });

  rep(exp) {
    return printer(re(exp));
  }

  test('eval sequence', () {
    var res = rep('''(sequence 
      (define x 5)
      (+ x 1)
    )''');
    expect(res, '6');
  });

  test('eval set', () {
    var res = rep('''(sequence 
      (define x 5)
      (set! x (+ x 1))
      x
    )''');
    expect(res, '6');
  });

  test('eval eval 0', () {
    var res = rep(''' (eval (quote (+ 1 2))) ''');
    expect(res, '3');
  });

  test('eval apply', () {
    var res = rep(''' (apply + (quote (1 2 3))) ''');
    expect(res, '6');
  });

  test('eval letrec is-even', () {
    var res = rep(''' 
    (letrec ((is-even? (lambda (n)
                       (if (= 0 n) 
                            true
                           (is-odd? (- n 1)))))
           (is-odd? (lambda (n)
                      (if (= 0 n) 
                            false
                           (is-even? (- n 1))))))
    (is-odd? 3))
    ''');
    expect(res, 'true');
  });

  test('letrec x<--y', () {
    var res = rep(''' 
    (letrec ((x 1) (y (+ x 1))) (cons x y))
    ''');
    expect(res, '(1 2)');
  });

  test('letrec y --> x', () {
    expect(rep('''
    (letrec ((y (+ x 1)) (x 1)) (cons x y))
    '''), throwsA(isNoSuchMethodError));
  });

  test('null?', () {
    expect(rep('(null? ())'), 'true');
    expect(rep('(null? (quote ()))'), 'true');
    expect(rep("(null? true)"), 'false');
    expect(rep('(null? 2)'), 'false');
    expect(rep('(null? (+ 1 2))'), 'false');
  });

  test('boolean?', () {
    expect(rep('(boolean? true)'), 'true');
    expect(rep('(boolean? false)'), 'true');
    expect(rep('(boolean? 2)'), 'false');
    expect(rep('(boolean? (+ 1 2))'), 'false');
    expect(rep('(boolean? (quote ()))'), 'false');
  });

  test('char?', () {
    expect(rep('(char? #\\c)'), 'true');
    expect(rep('(char? 23)'), 'false');
    expect(rep('(char? true)'), 'false');
  });
  test('number?', () {
    expect(rep('(number? 23)'), 'true');
    expect(rep('(number? 23.02)'), 'true');
    expect(rep('(number? (quote a))'), 'false');
    expect(rep('(number? "23")'), 'false');
    expect(rep('(number? true)'), 'false');
  });
  test('symbol?', () {
    expect(rep('(symbol? (quote foo))'), 'true');
    expect(rep('(symbol? (car (quote (a b))))'), 'true');
    expect(rep('(symbol? (quote nil))'), 'true');
    expect(rep('(symbol? (quote |toxo|))'), 'true');
    expect(rep('(symbol? (quote ()))'), 'false');
    expect(rep('(symbol? true)'), 'false');
  });
  test('string?', () {
    expect(rep('(string? "ab")'), 'true');
    expect(rep('(string? (quote ab))'), 'false');
    expect(rep('(string? true)'), 'false');
    expect(rep('(string? #\\v)'), 'false');
  });
  test('pair?', () {
    expect(rep('(pair? (quote (a . b)))'), 'true');
    expect(rep('(pair? (quote (a b c)))'), 'true');
    expect(rep('(pair? (quote ()))'), 'false');
    expect(rep('(pair? 23)'), 'false');
  });
  test('procedure?', () {
    expect(rep('(procedure? car)'), 'true');
    expect(rep('(procedure? (lambda (x) (* x x)))'), 'true');
    expect(rep('(procedure? (quote car))'), 'false');
    expect(rep('(procedure? 23)'), 'false');
  });

  test('factorial', () {
    expect(rep('''
    (sequence
    (define (factorial n)
      (if (<= n 1) 
        1
        (* n (factorial (- n 1)))
      )
    )
    (factorial 20)
    )
'''), "2432902008176640000");
  });

  test('fibonacci', () {
    expect(rep('''
(sequence
(define (fib n)
  (if (= n 0)
      0
      (if (= n 1)
          1
          (+ (fib (- n 1))
             (fib (- n 2))))))
(fib 10))
'''), "55");
  });

  test('prim', () {
    print(environment.parent.toString());
  });
}
