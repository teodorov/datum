import 'package:datum_cli/datum_cli.dart';

void main(List<String> arguments) {
  DatumReader dr = DatumReader();
  print('Hello world: ${dr.antlr4tree('(+ 3 2)')}!');
}
