// Generated from Datum.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'DatumParser.dart';

/// This abstract class defines a complete listener for a parse tree produced by
/// [DatumParser].
abstract class DatumListener extends ParseTreeListener {
  /// Enter a parse tree produced by the [Leaf]
  /// labeled alternative in [file.parserName>.datum].
  /// [ctx] the parse tree
  void enterLeaf(LeafContext ctx);
  /// Exit a parse tree produced by the [Leaf]
  /// labeled alternative in [DatumParser.datum].
  /// [ctx] the parse tree
  void exitLeaf(LeafContext ctx);

  /// Enter a parse tree produced by the [Composite]
  /// labeled alternative in [file.parserName>.datum].
  /// [ctx] the parse tree
  void enterComposite(CompositeContext ctx);
  /// Exit a parse tree produced by the [Composite]
  /// labeled alternative in [DatumParser.datum].
  /// [ctx] the parse tree
  void exitComposite(CompositeContext ctx);

  /// Enter a parse tree produced by the [Definition]
  /// labeled alternative in [file.parserName>.datum].
  /// [ctx] the parse tree
  void enterDefinition(DefinitionContext ctx);
  /// Exit a parse tree produced by the [Definition]
  /// labeled alternative in [DatumParser.datum].
  /// [ctx] the parse tree
  void exitDefinition(DefinitionContext ctx);

  /// Enter a parse tree produced by the [Quote]
  /// labeled alternative in [file.parserName>.datum].
  /// [ctx] the parse tree
  void enterQuote(QuoteContext ctx);
  /// Exit a parse tree produced by the [Quote]
  /// labeled alternative in [DatumParser.datum].
  /// [ctx] the parse tree
  void exitQuote(QuoteContext ctx);

  /// Enter a parse tree produced by the [Commented]
  /// labeled alternative in [file.parserName>.datum].
  /// [ctx] the parse tree
  void enterCommented(CommentedContext ctx);
  /// Exit a parse tree produced by the [Commented]
  /// labeled alternative in [DatumParser.datum].
  /// [ctx] the parse tree
  void exitCommented(CommentedContext ctx);

  /// Enter a parse tree produced by the [Boolean]
  /// labeled alternative in [file.parserName>.leaf_datum].
  /// [ctx] the parse tree
  void enterBoolean(BooleanContext ctx);
  /// Exit a parse tree produced by the [Boolean]
  /// labeled alternative in [DatumParser.leaf_datum].
  /// [ctx] the parse tree
  void exitBoolean(BooleanContext ctx);

  /// Enter a parse tree produced by the [Number]
  /// labeled alternative in [file.parserName>.leaf_datum].
  /// [ctx] the parse tree
  void enterNumber(NumberContext ctx);
  /// Exit a parse tree produced by the [Number]
  /// labeled alternative in [DatumParser.leaf_datum].
  /// [ctx] the parse tree
  void exitNumber(NumberContext ctx);

  /// Enter a parse tree produced by the [Character]
  /// labeled alternative in [file.parserName>.leaf_datum].
  /// [ctx] the parse tree
  void enterCharacter(CharacterContext ctx);
  /// Exit a parse tree produced by the [Character]
  /// labeled alternative in [DatumParser.leaf_datum].
  /// [ctx] the parse tree
  void exitCharacter(CharacterContext ctx);

  /// Enter a parse tree produced by the [String]
  /// labeled alternative in [file.parserName>.leaf_datum].
  /// [ctx] the parse tree
  void enterString(StringContext ctx);
  /// Exit a parse tree produced by the [String]
  /// labeled alternative in [DatumParser.leaf_datum].
  /// [ctx] the parse tree
  void exitString(StringContext ctx);

  /// Enter a parse tree produced by the [Symbol]
  /// labeled alternative in [file.parserName>.leaf_datum].
  /// [ctx] the parse tree
  void enterSymbol(SymbolContext ctx);
  /// Exit a parse tree produced by the [Symbol]
  /// labeled alternative in [DatumParser.leaf_datum].
  /// [ctx] the parse tree
  void exitSymbol(SymbolContext ctx);

  /// Enter a parse tree produced by the [DottedPair]
  /// labeled alternative in [file.parserName>.composite_datum].
  /// [ctx] the parse tree
  void enterDottedPair(DottedPairContext ctx);
  /// Exit a parse tree produced by the [DottedPair]
  /// labeled alternative in [DatumParser.composite_datum].
  /// [ctx] the parse tree
  void exitDottedPair(DottedPairContext ctx);

  /// Enter a parse tree produced by the [List]
  /// labeled alternative in [file.parserName>.composite_datum].
  /// [ctx] the parse tree
  void enterList(ListContext ctx);
  /// Exit a parse tree produced by the [List]
  /// labeled alternative in [DatumParser.composite_datum].
  /// [ctx] the parse tree
  void exitList(ListContext ctx);

  /// Enter a parse tree produced by [DatumParser.label].
  /// [ctx] the parse tree
  void enterLabel(LabelContext ctx);
  /// Exit a parse tree produced by [DatumParser.label].
  /// [ctx] the parse tree
  void exitLabel(LabelContext ctx);
}