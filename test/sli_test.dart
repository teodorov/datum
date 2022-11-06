import 'package:datum/src/evaluation/sli/datum_sli.dart';
import 'package:test/test.dart';

void main() {
  rep(String expression) => print(eval(read(expression)));

  test('null', () {
    expect(rep("()"), '()');
  });

  test('number', () {
    expect(rep('2'), '2');
  });

  test('boolean', () {
    expect(rep('true'), 'true');
    expect(rep('false'), 'false');
  });

  test('character', () {
    expect(rep('#\\c'), '#\\c');
  });

  test('string', () {
    expect(rep('"toto"'), '"toto"');
  });

  test('symbol', () {
    try {
      expect(rep('x'), 'x');
    } catch (e) {
      expect(e, isArgumentError);
      expect((e as ArgumentError).message,
          "x is not defined in the lexical scope");
    }
  });

  test('if value', () {
    expect(rep('(if true 3 4)'), '3');
    expect(rep('(if false 3 4)'), '4');
  });

  test('lambda', () {
    expect(rep('(lambda (x) x)'),
        '(klosure ρ [formals]=(x) [code]=x [numberOfMandatoryArguments]=1 [isVariadic]=false)');
  });

  test('lambda', () {
    expect(rep('(lambda x x)'),
        '(klosure ρ [formals]=x [code]=x [numberOfMandatoryArguments]=0 [isVariadic]=true)');
  });

  test('lambda mandatory and optional', () {
    String closure = rep('(lambda (z t (x 1)) x)');
    expect(closure,
        '(klosure ρ [formals]=(z t (x 1)) [code]=x [numberOfMandatoryArguments]=2 [isVariadic]=false)');
  });

  test('lambda mandatory, optional variadic', () {
    String closure = rep('(lambda (z t (x 1) . y) x)');
    expect(closure,
        '(klosure ρ [formals]=(z t (x 1) y) [code]=x [numberOfMandatoryArguments]=2 [isVariadic]=true)');
  });

  test('lambda mandatory after optional', () {
    try {
      rep('(lambda ((x 1) y) x)');
    } catch (e) {
      expect(e, isArgumentError);
      expect((e as ArgumentError).message,
          'lambda: mandatory arguments not allowed after an optional argument');
    }
  });

  test('lambda argument should be a symbol', () {
    try {
      rep('(lambda (12) x)');
    } catch (e) {
      expect(e, isArgumentError);
      expect((e as ArgumentError).message,
          'lambda formal argument should be a symbol');
    }
  });

  test('lambda rest-only should be a symbol', () {
    try {
      rep('(lambda 2 x)');
    } catch (e) {
      expect(e, isArgumentError);
      expect((e as ArgumentError).message,
          'lambda formal argument should be a symbol');
    }
  });

  test('first argument of apply should be a closure', () {
    try {
      rep('(2 3)');
    } catch (e) {
      expect(e, isArgumentError);
      expect((e as ArgumentError).message,
          "The first argument of an application should be a closure");
    }
  });

  test('apply no arg', () {
    expect(rep('( (lambda () 2) )'), '2');
  });

  test('apply id', () {
    expect(rep('( (lambda (x) x) 2)'), '2');
  });

  test('apply not enough mandatory arguments', () {
    try {
      rep('((lambda (x y) (+ x y)) 2)');
    } catch (e) {
      expect(e, isArgumentError);
      expect((e as ArgumentError).message,
          "Not enough arguments: expected 2 but given only 1 arguments");
    }
  });

  test('apply too many mandatory arguments', () {
    try {
      rep('((lambda (x y) (+ x y)) 2 3 4)');
    } catch (e) {
      expect(e, isArgumentError);
      expect((e as ArgumentError).message,
          "Too many arguments: expected 2 but given more than 3 arguments");
    }
  });

  test('apply snd', () {
    expect(rep('( (lambda (x y) y) 2 3)'), '3');
  });

  test('apply snd optional default', () {
    expect(rep('( (lambda (x (y 3)) y) 2)'), '3');
  });

  test('apply snd optional given', () {
    expect(rep('( (lambda (x (y 3)) y) 2 4)'), '4');
  });

  test('apply only optional default x', () {
    expect(rep('((lambda ((x 2) (y 3)) x))'), '2');
  });

  test('apply only optional default y', () {
    expect(rep('((lambda ((x 2) (y 3)) y))'), '3');
  });

  test('apply optional mandatory missing', () {
    try {
      rep('((lambda (x (y 1)) (+ x y)))');
    } catch (e) {
      expect(e, isArgumentError);
      expect((e as ArgumentError).message,
          "Not enough arguments: expected 1 but given only 0 arguments");
    }
  });

  test('apply variadic id', () {
    expect(rep('((lambda x x) 1 2 3)'), '(1 2 3)');
  });

  test('apply variadic mandatory rest missing', () {
    expect(rep("((lambda (x . y) y) 2)"), '()');
  });

  test('apply variadic mandatory rest present', () {
    expect(rep("((lambda (x . y) y) 0 1 2 3)"), '(1 2 3)');
  });

  test('apply variadic optional rest 23', () {
    expect(rep("((lambda (x (y 3) . z) z) 0 1 2 3)"), '(2 3)');
  });

  test('apply variadic optional no rest', () {
    expect(rep("((lambda (x (y 3) . z) z) 0 1)"), '()');
  });

  test("quote '", () {
    expect(rep("'(1 2 3)"), "(1 2 3)");
  });

  test('quote quote', () {
    expect(rep("(quote (1 2 3))"), "(1 2 3)");
  });

  test('set!', () {
    expect(rep("( (lambda (x) (begin (set! x 2) x )) 1)"), "2");
  });

  test('set!', () {
    expect(rep("( (lambda (x) (sequence (set! x 2) x )) 1)"), "2");
  });
}
