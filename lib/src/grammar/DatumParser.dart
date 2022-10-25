// Generated from Datum.g4 by ANTLR 4.11.1
// ignore_for_file: unused_import, unused_local_variable, prefer_single_quotes
import 'package:antlr4/antlr4.dart';

import 'DatumListener.dart';
import 'DatumBaseListener.dart';
const int RULE_datum = 0, RULE_leaf_datum = 1, RULE_composite_datum = 2, 
          RULE_label = 3;
class DatumParser extends Parser {
  static final checkVersion = () => RuntimeMetaData.checkVersion('4.11.1', RuntimeMetaData.VERSION);
  static const int TOKEN_EOF = IntStream.EOF;

  static final List<DFA> _decisionToDFA = List.generate(
      _ATN.numberOfDecisions, (i) => DFA(_ATN.getDecisionState(i), i));
  static final PredictionContextCache _sharedContextCache = PredictionContextCache();
  static const int TOKEN_BOOL = 1, TOKEN_TRUE = 2, TOKEN_FALSE = 3, TOKEN_LPAREN = 4, 
                   TOKEN_RPAREN = 5, TOKEN_LSQUARE = 6, TOKEN_RSQUARE = 7, 
                   TOKEN_SEMICOLON = 8, TOKEN_DASHSEMI = 9, TOKEN_DOT = 10, 
                   TOKEN_NUMBER = 11, TOKEN_STRING = 12, TOKEN_SYMBOL = 13, 
                   TOKEN_INITIAL = 14, TOKEN_SUBSEQUENT = 15, TOKEN_LETTER = 16, 
                   TOKEN_SPECIAL_INITIAL = 17, TOKEN_SPECIAL_SUBSEQUENT = 18, 
                   TOKEN_EXPLICIT_SIGN = 19, TOKEN_DASH = 20, TOKEN_EQUALS = 21, 
                   TOKEN_CHARACTER = 22, TOKEN_NATURAL = 23, TOKEN_DIGIT = 24, 
                   TOKEN_LINE_COMMENT = 25, TOKEN_BLOCK_COMMENT = 26, TOKEN_WS = 27;

  @override
  final List<String> ruleNames = [
    'datum', 'leaf_datum', 'composite_datum', 'label'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, null, "'true'", "'false'", "'('", "')'", "'['", "']='", "';'", 
      "'#;'", "'.'", null, null, null, null, null, null, null, null, null, 
      "'#'", "'='"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, "BOOL", "TRUE", "FALSE", "LPAREN", "RPAREN", "LSQUARE", "RSQUARE", 
      "SEMICOLON", "DASHSEMI", "DOT", "NUMBER", "STRING", "SYMBOL", "INITIAL", 
      "SUBSEQUENT", "LETTER", "SPECIAL_INITIAL", "SPECIAL_SUBSEQUENT", "EXPLICIT_SIGN", 
      "DASH", "EQUALS", "CHARACTER", "NATURAL", "DIGIT", "LINE_COMMENT", 
      "BLOCK_COMMENT", "WS"
  ];
  static final Vocabulary VOCABULARY = VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

  @override
  Vocabulary get vocabulary {
    return VOCABULARY;
  }

  @override
  String get grammarFileName => 'Datum.g4';

  @override
  List<int> get serializedATN => _serializedATN;

  @override
  ATN getATN() {
   return _ATN;
  }

  DatumParser(TokenStream input) : super(input) {
    interpreter = ParserATNSimulator(this, _ATN, _decisionToDFA, _sharedContextCache);
  }

  DatumContext datum() {
    dynamic _localctx = DatumContext(context, state);
    enterRule(_localctx, 0, RULE_datum);
    try {
      state = 15;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
      case TOKEN_NUMBER:
      case TOKEN_STRING:
      case TOKEN_SYMBOL:
      case TOKEN_CHARACTER:
        _localctx = LeafContext(_localctx);
        enterOuterAlt(_localctx, 1);
        state = 8;
        leaf_datum();
        break;
      case TOKEN_LPAREN:
        _localctx = CompositeContext(_localctx);
        enterOuterAlt(_localctx, 2);
        state = 9;
        composite_datum();
        break;
      case TOKEN_LSQUARE:
        _localctx = DefinitionContext(_localctx);
        enterOuterAlt(_localctx, 3);
        state = 10;
        label();
        state = 11;
        datum();
        break;
      case TOKEN_DASHSEMI:
        _localctx = CommentedContext(_localctx);
        enterOuterAlt(_localctx, 4);
        state = 13;
        match(TOKEN_DASHSEMI);
        state = 14;
        datum();
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Leaf_datumContext leaf_datum() {
    dynamic _localctx = Leaf_datumContext(context, state);
    enterRule(_localctx, 2, RULE_leaf_datum);
    try {
      state = 22;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
        _localctx = BooleanContext(_localctx);
        enterOuterAlt(_localctx, 1);
        state = 17;
        match(TOKEN_BOOL);
        break;
      case TOKEN_NUMBER:
        _localctx = NumberContext(_localctx);
        enterOuterAlt(_localctx, 2);
        state = 18;
        match(TOKEN_NUMBER);
        break;
      case TOKEN_CHARACTER:
        _localctx = CharacterContext(_localctx);
        enterOuterAlt(_localctx, 3);
        state = 19;
        match(TOKEN_CHARACTER);
        break;
      case TOKEN_STRING:
        _localctx = StringContext(_localctx);
        enterOuterAlt(_localctx, 4);
        state = 20;
        match(TOKEN_STRING);
        break;
      case TOKEN_SYMBOL:
        _localctx = SymbolContext(_localctx);
        enterOuterAlt(_localctx, 5);
        state = 21;
        match(TOKEN_SYMBOL);
        break;
      default:
        throw NoViableAltException(this);
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  Composite_datumContext composite_datum() {
    dynamic _localctx = Composite_datumContext(context, state);
    enterRule(_localctx, 4, RULE_composite_datum);
    int _la;
    try {
      state = 42;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 4, context)) {
      case 1:
        _localctx = DottedPairContext(_localctx);
        enterOuterAlt(_localctx, 1);
        state = 24;
        match(TOKEN_LPAREN);
        state = 26; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        do {
          state = 25;
          datum();
          state = 28; 
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        } while (((_la) & ~0x3f) == 0 && ((1 << _la) & 4209234) != 0);
        state = 30;
        match(TOKEN_DOT);
        state = 31;
        datum();
        state = 32;
        match(TOKEN_RPAREN);
        break;
      case 2:
        _localctx = ListContext(_localctx);
        enterOuterAlt(_localctx, 2);
        state = 34;
        match(TOKEN_LPAREN);
        state = 38;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (((_la) & ~0x3f) == 0 && ((1 << _la) & 4209234) != 0) {
          state = 35;
          datum();
          state = 40;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 41;
        match(TOKEN_RPAREN);
        break;
      }
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  LabelContext label() {
    dynamic _localctx = LabelContext(context, state);
    enterRule(_localctx, 6, RULE_label);
    try {
      enterOuterAlt(_localctx, 1);
      state = 44;
      match(TOKEN_LSQUARE);
      state = 45;
      match(TOKEN_SYMBOL);
      state = 46;
      match(TOKEN_RSQUARE);
    } on RecognitionException catch (re) {
      _localctx.exception = re;
      errorHandler.reportError(this, re);
      errorHandler.recover(this, re);
    } finally {
      exitRule();
    }
    return _localctx;
  }

  static const List<int> _serializedATN = [
      4,1,27,49,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,1,0,1,0,1,0,1,0,1,0,1,0,
      1,0,3,0,16,8,0,1,1,1,1,1,1,1,1,1,1,3,1,23,8,1,1,2,1,2,4,2,27,8,2,11,
      2,12,2,28,1,2,1,2,1,2,1,2,1,2,1,2,5,2,37,8,2,10,2,12,2,40,9,2,1,2,
      3,2,43,8,2,1,3,1,3,1,3,1,3,1,3,0,0,4,0,2,4,6,0,0,54,0,15,1,0,0,0,2,
      22,1,0,0,0,4,42,1,0,0,0,6,44,1,0,0,0,8,16,3,2,1,0,9,16,3,4,2,0,10,
      11,3,6,3,0,11,12,3,0,0,0,12,16,1,0,0,0,13,14,5,9,0,0,14,16,3,0,0,0,
      15,8,1,0,0,0,15,9,1,0,0,0,15,10,1,0,0,0,15,13,1,0,0,0,16,1,1,0,0,0,
      17,23,5,1,0,0,18,23,5,11,0,0,19,23,5,22,0,0,20,23,5,12,0,0,21,23,5,
      13,0,0,22,17,1,0,0,0,22,18,1,0,0,0,22,19,1,0,0,0,22,20,1,0,0,0,22,
      21,1,0,0,0,23,3,1,0,0,0,24,26,5,4,0,0,25,27,3,0,0,0,26,25,1,0,0,0,
      27,28,1,0,0,0,28,26,1,0,0,0,28,29,1,0,0,0,29,30,1,0,0,0,30,31,5,10,
      0,0,31,32,3,0,0,0,32,33,5,5,0,0,33,43,1,0,0,0,34,38,5,4,0,0,35,37,
      3,0,0,0,36,35,1,0,0,0,37,40,1,0,0,0,38,36,1,0,0,0,38,39,1,0,0,0,39,
      41,1,0,0,0,40,38,1,0,0,0,41,43,5,5,0,0,42,24,1,0,0,0,42,34,1,0,0,0,
      43,5,1,0,0,0,44,45,5,6,0,0,45,46,5,13,0,0,46,47,5,7,0,0,47,7,1,0,0,
      0,5,15,22,28,38,42
  ];

  static final ATN _ATN =
      ATNDeserializer().deserialize(_serializedATN);
}
class DatumContext extends ParserRuleContext {
  DatumContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_datum;
 
  @override
  void copyFrom(ParserRuleContext ctx) {
    super.copyFrom(ctx);
  }
}

class Leaf_datumContext extends ParserRuleContext {
  Leaf_datumContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_leaf_datum;
 
  @override
  void copyFrom(ParserRuleContext ctx) {
    super.copyFrom(ctx);
  }
}

class Composite_datumContext extends ParserRuleContext {
  Composite_datumContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_composite_datum;
 
  @override
  void copyFrom(ParserRuleContext ctx) {
    super.copyFrom(ctx);
  }
}

class LabelContext extends ParserRuleContext {
  TerminalNode? LSQUARE() => getToken(DatumParser.TOKEN_LSQUARE, 0);
  TerminalNode? SYMBOL() => getToken(DatumParser.TOKEN_SYMBOL, 0);
  TerminalNode? RSQUARE() => getToken(DatumParser.TOKEN_RSQUARE, 0);
  LabelContext([ParserRuleContext? parent, int? invokingState]) : super(parent, invokingState);
  @override
  int get ruleIndex => RULE_label;
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterLabel(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitLabel(this);
  }
}

class CompositeContext extends DatumContext {
  Composite_datumContext? composite_datum() => getRuleContext<Composite_datumContext>(0);
  CompositeContext(DatumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterComposite(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitComposite(this);
  }
}

class DefinitionContext extends DatumContext {
  LabelContext? label() => getRuleContext<LabelContext>(0);
  DatumContext? datum() => getRuleContext<DatumContext>(0);
  DefinitionContext(DatumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterDefinition(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitDefinition(this);
  }
}

class LeafContext extends DatumContext {
  Leaf_datumContext? leaf_datum() => getRuleContext<Leaf_datumContext>(0);
  LeafContext(DatumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterLeaf(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitLeaf(this);
  }
}

class CommentedContext extends DatumContext {
  TerminalNode? DASHSEMI() => getToken(DatumParser.TOKEN_DASHSEMI, 0);
  DatumContext? datum() => getRuleContext<DatumContext>(0);
  CommentedContext(DatumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterCommented(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitCommented(this);
  }
}class NumberContext extends Leaf_datumContext {
  TerminalNode? NUMBER() => getToken(DatumParser.TOKEN_NUMBER, 0);
  NumberContext(Leaf_datumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterNumber(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitNumber(this);
  }
}

class CharacterContext extends Leaf_datumContext {
  TerminalNode? CHARACTER() => getToken(DatumParser.TOKEN_CHARACTER, 0);
  CharacterContext(Leaf_datumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterCharacter(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitCharacter(this);
  }
}

class SymbolContext extends Leaf_datumContext {
  TerminalNode? SYMBOL() => getToken(DatumParser.TOKEN_SYMBOL, 0);
  SymbolContext(Leaf_datumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterSymbol(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitSymbol(this);
  }
}

class StringContext extends Leaf_datumContext {
  TerminalNode? STRING() => getToken(DatumParser.TOKEN_STRING, 0);
  StringContext(Leaf_datumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterString(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitString(this);
  }
}

class BooleanContext extends Leaf_datumContext {
  TerminalNode? BOOL() => getToken(DatumParser.TOKEN_BOOL, 0);
  BooleanContext(Leaf_datumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterBoolean(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitBoolean(this);
  }
}class ListContext extends Composite_datumContext {
  TerminalNode? LPAREN() => getToken(DatumParser.TOKEN_LPAREN, 0);
  TerminalNode? RPAREN() => getToken(DatumParser.TOKEN_RPAREN, 0);
  List<DatumContext> datums() => getRuleContexts<DatumContext>();
  DatumContext? datum(int i) => getRuleContext<DatumContext>(i);
  ListContext(Composite_datumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterList(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitList(this);
  }
}

class DottedPairContext extends Composite_datumContext {
  TerminalNode? LPAREN() => getToken(DatumParser.TOKEN_LPAREN, 0);
  TerminalNode? DOT() => getToken(DatumParser.TOKEN_DOT, 0);
  List<DatumContext> datums() => getRuleContexts<DatumContext>();
  DatumContext? datum(int i) => getRuleContext<DatumContext>(i);
  TerminalNode? RPAREN() => getToken(DatumParser.TOKEN_RPAREN, 0);
  DottedPairContext(Composite_datumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterDottedPair(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitDottedPair(this);
  }
}