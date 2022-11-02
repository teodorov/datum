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
  static const int TOKEN_T__0 = 1, TOKEN_T__1 = 2, TOKEN_BOOL = 3, TOKEN_TRUE = 4, 
                   TOKEN_FALSE = 5, TOKEN_LPAREN = 6, TOKEN_RPAREN = 7, 
                   TOKEN_LSQUARE = 8, TOKEN_RSQUARE = 9, TOKEN_SEMICOLON = 10, 
                   TOKEN_DASHSEMI = 11, TOKEN_DOT = 12, TOKEN_NUMBER = 13, 
                   TOKEN_STRING = 14, TOKEN_SYMBOL = 15, TOKEN_INITIAL = 16, 
                   TOKEN_SUBSEQUENT = 17, TOKEN_LETTER = 18, TOKEN_SPECIAL_INITIAL = 19, 
                   TOKEN_SPECIAL_SUBSEQUENT = 20, TOKEN_EXPLICIT_SIGN = 21, 
                   TOKEN_DASH = 22, TOKEN_EQUALS = 23, TOKEN_NATURAL = 24, 
                   TOKEN_DIGIT = 25, TOKEN_LINE_COMMENT = 26, TOKEN_BLOCK_COMMENT = 27, 
                   TOKEN_WS = 28;

  @override
  final List<String> ruleNames = [
    'datum', 'leaf_datum', 'composite_datum', 'label'
  ];

  static final List<String?> _LITERAL_NAMES = [
      null, "'''", "'#\\'", null, "'true'", "'false'", "'('", "')'", "'['", 
      "']='", "';'", "'#;'", "'.'", null, null, null, null, null, null, 
      null, null, null, "'#'", "'='"
  ];
  static final List<String?> _SYMBOLIC_NAMES = [
      null, null, null, "BOOL", "TRUE", "FALSE", "LPAREN", "RPAREN", "LSQUARE", 
      "RSQUARE", "SEMICOLON", "DASHSEMI", "DOT", "NUMBER", "STRING", "SYMBOL", 
      "INITIAL", "SUBSEQUENT", "LETTER", "SPECIAL_INITIAL", "SPECIAL_SUBSEQUENT", 
      "EXPLICIT_SIGN", "DASH", "EQUALS", "NATURAL", "DIGIT", "LINE_COMMENT", 
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
      state = 17;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_T__1:
      case TOKEN_BOOL:
      case TOKEN_NUMBER:
      case TOKEN_STRING:
      case TOKEN_SYMBOL:
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
      case TOKEN_T__0:
        _localctx = QuoteContext(_localctx);
        enterOuterAlt(_localctx, 4);
        state = 13;
        match(TOKEN_T__0);
        state = 14;
        datum();
        break;
      case TOKEN_DASHSEMI:
        _localctx = CommentedContext(_localctx);
        enterOuterAlt(_localctx, 5);
        state = 15;
        match(TOKEN_DASHSEMI);
        state = 16;
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
      state = 25;
      errorHandler.sync(this);
      switch (tokenStream.LA(1)!) {
      case TOKEN_BOOL:
        _localctx = BooleanContext(_localctx);
        enterOuterAlt(_localctx, 1);
        state = 19;
        match(TOKEN_BOOL);
        break;
      case TOKEN_NUMBER:
        _localctx = NumberContext(_localctx);
        enterOuterAlt(_localctx, 2);
        state = 20;
        match(TOKEN_NUMBER);
        break;
      case TOKEN_T__1:
        _localctx = CharacterContext(_localctx);
        enterOuterAlt(_localctx, 3);
        state = 21;
        match(TOKEN_T__1);

        state = 22;
        _localctx.character = matchWildcard();
        break;
      case TOKEN_STRING:
        _localctx = StringContext(_localctx);
        enterOuterAlt(_localctx, 4);
        state = 23;
        match(TOKEN_STRING);
        break;
      case TOKEN_SYMBOL:
        _localctx = SymbolContext(_localctx);
        enterOuterAlt(_localctx, 5);
        state = 24;
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
      state = 45;
      errorHandler.sync(this);
      switch (interpreter!.adaptivePredict(tokenStream, 4, context)) {
      case 1:
        _localctx = DottedPairContext(_localctx);
        enterOuterAlt(_localctx, 1);
        state = 27;
        match(TOKEN_LPAREN);
        state = 29; 
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        do {
          state = 28;
          datum();
          state = 31; 
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        } while (((_la) & ~0x3f) == 0 && ((1 << _la) & 59726) != 0);
        state = 33;
        match(TOKEN_DOT);
        state = 34;
        datum();
        state = 35;
        match(TOKEN_RPAREN);
        break;
      case 2:
        _localctx = ListContext(_localctx);
        enterOuterAlt(_localctx, 2);
        state = 37;
        match(TOKEN_LPAREN);
        state = 41;
        errorHandler.sync(this);
        _la = tokenStream.LA(1)!;
        while (((_la) & ~0x3f) == 0 && ((1 << _la) & 59726) != 0) {
          state = 38;
          datum();
          state = 43;
          errorHandler.sync(this);
          _la = tokenStream.LA(1)!;
        }
        state = 44;
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
      state = 47;
      match(TOKEN_LSQUARE);
      state = 48;
      match(TOKEN_SYMBOL);
      state = 49;
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
      4,1,28,52,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,1,0,1,0,1,0,1,0,1,0,1,0,
      1,0,1,0,1,0,3,0,18,8,0,1,1,1,1,1,1,1,1,1,1,1,1,3,1,26,8,1,1,2,1,2,
      4,2,30,8,2,11,2,12,2,31,1,2,1,2,1,2,1,2,1,2,1,2,5,2,40,8,2,10,2,12,
      2,43,9,2,1,2,3,2,46,8,2,1,3,1,3,1,3,1,3,1,3,0,0,4,0,2,4,6,0,0,58,0,
      17,1,0,0,0,2,25,1,0,0,0,4,45,1,0,0,0,6,47,1,0,0,0,8,18,3,2,1,0,9,18,
      3,4,2,0,10,11,3,6,3,0,11,12,3,0,0,0,12,18,1,0,0,0,13,14,5,1,0,0,14,
      18,3,0,0,0,15,16,5,11,0,0,16,18,3,0,0,0,17,8,1,0,0,0,17,9,1,0,0,0,
      17,10,1,0,0,0,17,13,1,0,0,0,17,15,1,0,0,0,18,1,1,0,0,0,19,26,5,3,0,
      0,20,26,5,13,0,0,21,22,5,2,0,0,22,26,9,0,0,0,23,26,5,14,0,0,24,26,
      5,15,0,0,25,19,1,0,0,0,25,20,1,0,0,0,25,21,1,0,0,0,25,23,1,0,0,0,25,
      24,1,0,0,0,26,3,1,0,0,0,27,29,5,6,0,0,28,30,3,0,0,0,29,28,1,0,0,0,
      30,31,1,0,0,0,31,29,1,0,0,0,31,32,1,0,0,0,32,33,1,0,0,0,33,34,5,12,
      0,0,34,35,3,0,0,0,35,36,5,7,0,0,36,46,1,0,0,0,37,41,5,6,0,0,38,40,
      3,0,0,0,39,38,1,0,0,0,40,43,1,0,0,0,41,39,1,0,0,0,41,42,1,0,0,0,42,
      44,1,0,0,0,43,41,1,0,0,0,44,46,5,7,0,0,45,27,1,0,0,0,45,37,1,0,0,0,
      46,5,1,0,0,0,47,48,5,8,0,0,48,49,5,15,0,0,49,50,5,9,0,0,50,7,1,0,0,
      0,5,17,25,31,41,45
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

class QuoteContext extends DatumContext {
  DatumContext? datum() => getRuleContext<DatumContext>(0);
  QuoteContext(DatumContext ctx) { copyFrom(ctx); }
  @override
  void enterRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.enterQuote(this);
  }
  @override
  void exitRule(ParseTreeListener listener) {
    if (listener is DatumListener) listener.exitQuote(this);
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
  Token? character;
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