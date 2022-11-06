import 'dart:convert';
import 'dart:io';
import 'package:datum/src/evaluation/cesk/evaluator.dart' as datum;

void main(List<String> arguments) {
  print("Welcome to the datum REPL. Press 'q' to quit");
  do {
    stdout.write("datum> ");
    var exp = stdin.readLineSync(encoding: utf8);
    if (exp == null || exp == "") continue;
    if (exp == 'q') break;
    print(datum.print(datum.eval(datum.read(exp))));
  } while (true);
}
