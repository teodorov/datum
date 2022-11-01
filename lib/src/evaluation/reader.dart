import 'package:antlr4/antlr4.dart';
import 'package:datum/src/grammar/DatumBaseListener.dart';
import 'package:datum/src/grammar/DatumLexer.dart';
import 'package:datum/src/grammar/DatumParser.dart';
import 'package:datum/src/model/datum_model.dart' as datum;

class DatumReader extends Antlr4DatumReader {
  @override
  parse(InputStream inputStream) {
    var tree = super.parse(inputStream);
    var walker = ANTLR4Tree2Datum();
    ParseTreeWalker.DEFAULT.walk(walker, tree);
    return walker.map[tree]!;
  }
}

class Antlr4DatumReader {
  Antlr4DatumReader() {
    DatumLexer.checkVersion();
    DatumParser.checkVersion();
  }

  DatumLexer? lexer;
  DatumParser? parser;

  parseString(String input) {
    return parse(InputStream.fromString(input));
  }

  parse(InputStream inputStream) {
    lexer = DatumLexer(inputStream);
    final tokens = CommonTokenStream(lexer!);
    parser = DatumParser(tokens);
    parser!.addErrorListener(DiagnosticErrorListener());
    parser!.buildParseTree = true;
    return parser!.datum();
  }

  String printTree(ParserRuleContext tree) {
    return tree.toStringTree(parser: parser!);
  }

  String antlr4tree(String input) {
    return printTree(parseString(input));
  }
}

class ANTLR4Tree2Datum extends DatumBaseListener {
  Map<ParserRuleContext, datum.Datum> map = {};
  @override
  void exitBoolean(BooleanContext ctx) {
    if (ctx.text == "true") {
      map[ctx] = datum.Boolean.dTrue;
      return;
    }
    map[ctx] = datum.Boolean.dFalse;
  }

  @override
  void exitNumber(NumberContext ctx) {
    map[ctx] = datum.Number(ctx.text);
  }

  @override
  void exitCharacter(CharacterContext ctx) {
    map[ctx] = datum.Character(ctx.character!.text!);
  }

  @override
  void exitString(StringContext ctx) {
    map[ctx] = datum.String(ctx.text);
  }

  @override
  void exitSymbol(SymbolContext ctx) {
    map[ctx] = datum.Symbol(ctx.text);
  }

  @override
  void exitLeaf(LeafContext ctx) {
    map[ctx] = map[ctx.children![0]]!;
  }

  @override
  void exitDottedPair(DottedPairContext ctx) {
    List<datum.Datum> items = ctx.datums().map((e) => map[e]!).toList();
    datum.Datum last = items.removeLast();
    datum.Datum pair = items.reversed.fold(last, (p, e) => datum.Pair(e, p));
    map[ctx] = pair;
  }

  @override
  void exitList(ListContext ctx) {
    List<datum.Datum> items = ctx.datums().map((e) => map[e]!).toList();
    datum.Datum pair =
        items.reversed.fold(datum.Null.instance, (p, e) => datum.Pair(e, p));
    map[ctx] = pair;
  }

  @override
  void exitComposite(CompositeContext ctx) {
    map[ctx] = map[ctx.children![0]]!;
  }

  @override
  void exitLabel(LabelContext ctx) {
    map[ctx] = datum.Symbol(ctx.SYMBOL()!.text!);
  }

  @override
  void exitDefinition(DefinitionContext ctx) {
    map[ctx] =
        datum.Definition(map[ctx.label()]! as datum.Symbol, map[ctx.datum()]!);
  }

  @override
  void exitCommented(CommentedContext ctx) {
    map[ctx] = datum.Commented(map[ctx.datum()]!);
  }
}
