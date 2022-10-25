// Generated from /Users/ciprian/Playfield/repositories/dart-lambda_spec/datum_cli/lib/src/grammar/Datum.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.misc.*;
import org.antlr.v4.runtime.tree.*;
import java.util.List;
import java.util.Iterator;
import java.util.ArrayList;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class DatumParser extends Parser {
	static { RuntimeMetaData.checkVersion("4.9.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		BOOL=1, TRUE=2, FALSE=3, LPAREN=4, RPAREN=5, LSQUARE=6, RSQUARE=7, SEMICOLON=8, 
		DASHSEMI=9, DOT=10, NUMBER=11, STRING=12, SYMBOL=13, INITIAL=14, SUBSEQUENT=15, 
		LETTER=16, SPECIAL_INITIAL=17, SPECIAL_SUBSEQUENT=18, EXPLICIT_SIGN=19, 
		DASH=20, EQUALS=21, CHARACTER=22, NATURAL=23, DIGIT=24, LINE_COMMENT=25, 
		BLOCK_COMMENT=26, WS=27;
	public static final int
		RULE_datum = 0, RULE_leaf_datum = 1, RULE_composite_datum = 2, RULE_label = 3;
	private static String[] makeRuleNames() {
		return new String[] {
			"datum", "leaf_datum", "composite_datum", "label"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, null, "'true'", "'false'", "'('", "')'", "'['", "']='", "';'", 
			"'#;'", "'.'", null, null, null, null, null, null, null, null, null, 
			"'#'", "'='"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, "BOOL", "TRUE", "FALSE", "LPAREN", "RPAREN", "LSQUARE", "RSQUARE", 
			"SEMICOLON", "DASHSEMI", "DOT", "NUMBER", "STRING", "SYMBOL", "INITIAL", 
			"SUBSEQUENT", "LETTER", "SPECIAL_INITIAL", "SPECIAL_SUBSEQUENT", "EXPLICIT_SIGN", 
			"DASH", "EQUALS", "CHARACTER", "NATURAL", "DIGIT", "LINE_COMMENT", "BLOCK_COMMENT", 
			"WS"
		};
	}
	private static final String[] _SYMBOLIC_NAMES = makeSymbolicNames();
	public static final Vocabulary VOCABULARY = new VocabularyImpl(_LITERAL_NAMES, _SYMBOLIC_NAMES);

	/**
	 * @deprecated Use {@link #VOCABULARY} instead.
	 */
	@Deprecated
	public static final String[] tokenNames;
	static {
		tokenNames = new String[_SYMBOLIC_NAMES.length];
		for (int i = 0; i < tokenNames.length; i++) {
			tokenNames[i] = VOCABULARY.getLiteralName(i);
			if (tokenNames[i] == null) {
				tokenNames[i] = VOCABULARY.getSymbolicName(i);
			}

			if (tokenNames[i] == null) {
				tokenNames[i] = "<INVALID>";
			}
		}
	}

	@Override
	@Deprecated
	public String[] getTokenNames() {
		return tokenNames;
	}

	@Override

	public Vocabulary getVocabulary() {
		return VOCABULARY;
	}

	@Override
	public String getGrammarFileName() { return "Datum.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public ATN getATN() { return _ATN; }

	public DatumParser(TokenStream input) {
		super(input);
		_interp = new ParserATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	public static class DatumContext extends ParserRuleContext {
		public DatumContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_datum; }
	 
		public DatumContext() { }
		public void copyFrom(DatumContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class CompositeContext extends DatumContext {
		public Composite_datumContext composite_datum() {
			return getRuleContext(Composite_datumContext.class,0);
		}
		public CompositeContext(DatumContext ctx) { copyFrom(ctx); }
	}
	public static class DefinitionContext extends DatumContext {
		public LabelContext label() {
			return getRuleContext(LabelContext.class,0);
		}
		public DatumContext datum() {
			return getRuleContext(DatumContext.class,0);
		}
		public DefinitionContext(DatumContext ctx) { copyFrom(ctx); }
	}
	public static class LeafContext extends DatumContext {
		public Leaf_datumContext leaf_datum() {
			return getRuleContext(Leaf_datumContext.class,0);
		}
		public LeafContext(DatumContext ctx) { copyFrom(ctx); }
	}
	public static class CommentedContext extends DatumContext {
		public TerminalNode DASHSEMI() { return getToken(DatumParser.DASHSEMI, 0); }
		public DatumContext datum() {
			return getRuleContext(DatumContext.class,0);
		}
		public CommentedContext(DatumContext ctx) { copyFrom(ctx); }
	}

	public final DatumContext datum() throws RecognitionException {
		DatumContext _localctx = new DatumContext(_ctx, getState());
		enterRule(_localctx, 0, RULE_datum);
		try {
			setState(15);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case BOOL:
			case NUMBER:
			case STRING:
			case SYMBOL:
			case CHARACTER:
				_localctx = new LeafContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(8);
				leaf_datum();
				}
				break;
			case LPAREN:
				_localctx = new CompositeContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(9);
				composite_datum();
				}
				break;
			case LSQUARE:
				_localctx = new DefinitionContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(10);
				label();
				setState(11);
				datum();
				}
				break;
			case DASHSEMI:
				_localctx = new CommentedContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(13);
				match(DASHSEMI);
				setState(14);
				datum();
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Leaf_datumContext extends ParserRuleContext {
		public Leaf_datumContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_leaf_datum; }
	 
		public Leaf_datumContext() { }
		public void copyFrom(Leaf_datumContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class NumberContext extends Leaf_datumContext {
		public TerminalNode NUMBER() { return getToken(DatumParser.NUMBER, 0); }
		public NumberContext(Leaf_datumContext ctx) { copyFrom(ctx); }
	}
	public static class CharacterContext extends Leaf_datumContext {
		public TerminalNode CHARACTER() { return getToken(DatumParser.CHARACTER, 0); }
		public CharacterContext(Leaf_datumContext ctx) { copyFrom(ctx); }
	}
	public static class SymbolContext extends Leaf_datumContext {
		public TerminalNode SYMBOL() { return getToken(DatumParser.SYMBOL, 0); }
		public SymbolContext(Leaf_datumContext ctx) { copyFrom(ctx); }
	}
	public static class StringContext extends Leaf_datumContext {
		public TerminalNode STRING() { return getToken(DatumParser.STRING, 0); }
		public StringContext(Leaf_datumContext ctx) { copyFrom(ctx); }
	}
	public static class BooleanContext extends Leaf_datumContext {
		public TerminalNode BOOL() { return getToken(DatumParser.BOOL, 0); }
		public BooleanContext(Leaf_datumContext ctx) { copyFrom(ctx); }
	}

	public final Leaf_datumContext leaf_datum() throws RecognitionException {
		Leaf_datumContext _localctx = new Leaf_datumContext(_ctx, getState());
		enterRule(_localctx, 2, RULE_leaf_datum);
		try {
			setState(22);
			_errHandler.sync(this);
			switch (_input.LA(1)) {
			case BOOL:
				_localctx = new BooleanContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(17);
				match(BOOL);
				}
				break;
			case NUMBER:
				_localctx = new NumberContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(18);
				match(NUMBER);
				}
				break;
			case CHARACTER:
				_localctx = new CharacterContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(19);
				match(CHARACTER);
				}
				break;
			case STRING:
				_localctx = new StringContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(20);
				match(STRING);
				}
				break;
			case SYMBOL:
				_localctx = new SymbolContext(_localctx);
				enterOuterAlt(_localctx, 5);
				{
				setState(21);
				match(SYMBOL);
				}
				break;
			default:
				throw new NoViableAltException(this);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class Composite_datumContext extends ParserRuleContext {
		public Composite_datumContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_composite_datum; }
	 
		public Composite_datumContext() { }
		public void copyFrom(Composite_datumContext ctx) {
			super.copyFrom(ctx);
		}
	}
	public static class ListContext extends Composite_datumContext {
		public TerminalNode LPAREN() { return getToken(DatumParser.LPAREN, 0); }
		public TerminalNode RPAREN() { return getToken(DatumParser.RPAREN, 0); }
		public List<DatumContext> datum() {
			return getRuleContexts(DatumContext.class);
		}
		public DatumContext datum(int i) {
			return getRuleContext(DatumContext.class,i);
		}
		public ListContext(Composite_datumContext ctx) { copyFrom(ctx); }
	}
	public static class DottedPairContext extends Composite_datumContext {
		public TerminalNode LPAREN() { return getToken(DatumParser.LPAREN, 0); }
		public TerminalNode DOT() { return getToken(DatumParser.DOT, 0); }
		public List<DatumContext> datum() {
			return getRuleContexts(DatumContext.class);
		}
		public DatumContext datum(int i) {
			return getRuleContext(DatumContext.class,i);
		}
		public TerminalNode RPAREN() { return getToken(DatumParser.RPAREN, 0); }
		public DottedPairContext(Composite_datumContext ctx) { copyFrom(ctx); }
	}

	public final Composite_datumContext composite_datum() throws RecognitionException {
		Composite_datumContext _localctx = new Composite_datumContext(_ctx, getState());
		enterRule(_localctx, 4, RULE_composite_datum);
		int _la;
		try {
			setState(42);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
			case 1:
				_localctx = new DottedPairContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(24);
				match(LPAREN);
				setState(26); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(25);
					datum();
					}
					}
					setState(28); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BOOL) | (1L << LPAREN) | (1L << LSQUARE) | (1L << DASHSEMI) | (1L << NUMBER) | (1L << STRING) | (1L << SYMBOL) | (1L << CHARACTER))) != 0) );
				setState(30);
				match(DOT);
				setState(31);
				datum();
				setState(32);
				match(RPAREN);
				}
				break;
			case 2:
				_localctx = new ListContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(34);
				match(LPAREN);
				setState(38);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << BOOL) | (1L << LPAREN) | (1L << LSQUARE) | (1L << DASHSEMI) | (1L << NUMBER) | (1L << STRING) | (1L << SYMBOL) | (1L << CHARACTER))) != 0)) {
					{
					{
					setState(35);
					datum();
					}
					}
					setState(40);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(41);
				match(RPAREN);
				}
				break;
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static class LabelContext extends ParserRuleContext {
		public TerminalNode LSQUARE() { return getToken(DatumParser.LSQUARE, 0); }
		public TerminalNode SYMBOL() { return getToken(DatumParser.SYMBOL, 0); }
		public TerminalNode RSQUARE() { return getToken(DatumParser.RSQUARE, 0); }
		public LabelContext(ParserRuleContext parent, int invokingState) {
			super(parent, invokingState);
		}
		@Override public int getRuleIndex() { return RULE_label; }
	}

	public final LabelContext label() throws RecognitionException {
		LabelContext _localctx = new LabelContext(_ctx, getState());
		enterRule(_localctx, 6, RULE_label);
		try {
			enterOuterAlt(_localctx, 1);
			{
			setState(44);
			match(LSQUARE);
			setState(45);
			match(SYMBOL);
			setState(46);
			match(RSQUARE);
			}
		}
		catch (RecognitionException re) {
			_localctx.exception = re;
			_errHandler.reportError(this, re);
			_errHandler.recover(this, re);
		}
		finally {
			exitRule();
		}
		return _localctx;
	}

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\35\63\4\2\t\2\4\3"+
		"\t\3\4\4\t\4\4\5\t\5\3\2\3\2\3\2\3\2\3\2\3\2\3\2\5\2\22\n\2\3\3\3\3\3"+
		"\3\3\3\3\3\5\3\31\n\3\3\4\3\4\6\4\35\n\4\r\4\16\4\36\3\4\3\4\3\4\3\4\3"+
		"\4\3\4\7\4\'\n\4\f\4\16\4*\13\4\3\4\5\4-\n\4\3\5\3\5\3\5\3\5\3\5\2\2\6"+
		"\2\4\6\b\2\2\28\2\21\3\2\2\2\4\30\3\2\2\2\6,\3\2\2\2\b.\3\2\2\2\n\22\5"+
		"\4\3\2\13\22\5\6\4\2\f\r\5\b\5\2\r\16\5\2\2\2\16\22\3\2\2\2\17\20\7\13"+
		"\2\2\20\22\5\2\2\2\21\n\3\2\2\2\21\13\3\2\2\2\21\f\3\2\2\2\21\17\3\2\2"+
		"\2\22\3\3\2\2\2\23\31\7\3\2\2\24\31\7\r\2\2\25\31\7\30\2\2\26\31\7\16"+
		"\2\2\27\31\7\17\2\2\30\23\3\2\2\2\30\24\3\2\2\2\30\25\3\2\2\2\30\26\3"+
		"\2\2\2\30\27\3\2\2\2\31\5\3\2\2\2\32\34\7\6\2\2\33\35\5\2\2\2\34\33\3"+
		"\2\2\2\35\36\3\2\2\2\36\34\3\2\2\2\36\37\3\2\2\2\37 \3\2\2\2 !\7\f\2\2"+
		"!\"\5\2\2\2\"#\7\7\2\2#-\3\2\2\2$(\7\6\2\2%\'\5\2\2\2&%\3\2\2\2\'*\3\2"+
		"\2\2(&\3\2\2\2()\3\2\2\2)+\3\2\2\2*(\3\2\2\2+-\7\7\2\2,\32\3\2\2\2,$\3"+
		"\2\2\2-\7\3\2\2\2./\7\b\2\2/\60\7\17\2\2\60\61\7\t\2\2\61\t\3\2\2\2\7"+
		"\21\30\36(,";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}