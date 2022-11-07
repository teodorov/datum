import 'dart:convert';
import 'dart:io';
// import 'package:datum/src/evaluation/cesk/evaluator.dart' as datum;
import 'package:datum/src/evaluation/cesk/configuration.dart';
import 'package:datum/src/evaluation/sli/datum_sli.dart' as datum;
import 'package:datum/src/evaluation/sli/rule.dart';

void main(List<String> arguments) {
  print("Welcome to the datum REPL. Press 'q' to quit");
  do {
    stdout.write("datum> ");
    var exp = stdin.readLineSync(encoding: utf8);
    if (exp == null || exp == "") continue;
    if (exp == 'q') break;
    if (exp == 'dbg') {
      debugLoop();
      continue;
    }
    print(datum.print(datum.eval(datum.read(exp))));
  } while (true);
}

debugLoop() {
  print("Welcome to the datum REPL debugger. Press 'q' to quit");

  datum.DatumSLI? sli;
  Configuration? current;
  List? options;
  List<Rule>? enabledActions;

  do {
    stdout.write("datum dbg> ");
    var exp = stdin.readLineSync(encoding: utf8);
    if (exp == null || exp == "") continue;
    if (exp == 'q') break;
    int idx = exp.indexOf(' ');
    String command;
    String arguments;
    if (idx == -1) {
      command = exp;
      arguments = '';
    } else {
      command = exp.substring(0, idx);
      arguments = exp.substring(idx);
    }

    switch (command) {
      case 'run':
        sli = datum.DatumSLI(datum.read(arguments));
        print(datum.print(sli.expression));
        break;
      case 'i':
      case 'initial':
        if (sli == null) {
          print("'run' an expression first");
          continue;
        }
        options = sli.semantics.initial().toList();
        print(options);
        break;
      case 'a':
      case 'actions':
        if (options == null) {
          print('get the "initial" configurations first');
          continue;
        }
        if (options.length == 1) {
          current = options[0];
        } else {
          current = options[num.parse(arguments) as int];
        }
        enabledActions = sli!.semantics.actions(current).toList();
        print(enabledActions);
        break;
      case 'e':
      case 'execute':
        if (enabledActions == null) {
          print('nothing to execute');
          continue;
        }
        if (enabledActions.length == 1) {
          options = sli!.semantics.execute(enabledActions[0], current).toList();
        } else {
          options = sli!.semantics
              .execute(enabledActions[num.parse(arguments) as int], current);
        }
        print(options);
        break;
      default:
    }
  } while (true);
}
