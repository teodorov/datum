import 'dart:convert';
import 'dart:io';
import 'package:datum_cli/src/domains/primitives.dart';
import 'package:datum_cli/src/evaluation/reader.dart';
import 'package:datum_cli/src/evaluation/evaluator.dart';
import 'package:datum_cli/src/evaluation/printer.dart';

void main(List<String> arguments) {
  print("Welcome to the datum REPL. Press 'q' to quit");
  do {
    stdout.write("datum> ");
    var exp = stdin.readLineSync(encoding: utf8);
    if (exp == null || exp == "") continue;
    if (exp == 'q') break;
    var reader = DatumReader().parseString;
    var environment = PrimitiveEnvironment(null).create();
    print(printer(eval(reader(exp), environment)));
  } while (true);
}
