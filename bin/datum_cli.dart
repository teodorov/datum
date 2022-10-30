import 'package:datum_cli/datum_cli.dart';

void main(List<String> arguments) {
  Antlr4DatumReader dr = Antlr4DatumReader();
  print('Hello world: ${dr.antlr4tree('(+ 3 2)')}!');
}
