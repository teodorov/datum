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
		T__0=1, BOOL=2, TRUE=3, FALSE=4, LPAREN=5, RPAREN=6, LSQUARE=7, RSQUARE=8, 
		SEMICOLON=9, DASHSEMI=10, DOT=11, NUMBER=12, STRING=13, SYMBOL=14, INITIAL=15, 
		SUBSEQUENT=16, LETTER=17, SPECIAL_INITIAL=18, SPECIAL_SUBSEQUENT=19, EXPLICIT_SIGN=20, 
		DASH=21, EQUALS=22, NATURAL=23, DIGIT=24, LINE_COMMENT=25, BLOCK_COMMENT=26, 
		WS=27;
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
			null, "'#\\'", null, "'true'", "'false'", "'('", "')'", "'['", "']='", 
			"';'", "'#;'", "'.'", null, null, null, null, null, null, null, null, 
			null, "'#'", "'='"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, "BOOL", "TRUE", "FALSE", "LPAREN", "RPAREN", "LSQUARE", "RSQUARE", 
			"SEMICOLON", "DASHSEMI", "DOT", "NUMBER", "STRING", "SYMBOL", "INITIAL", 
			"SUBSEQUENT", "LETTER", "SPECIAL_INITIAL", "SPECIAL_SUBSEQUENT", "EXPLICIT_SIGN", 
			"DASH", "EQUALS", "NATURAL", "DIGIT", "LINE_COMMENT", "BLOCK_COMMENT", 
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
			case T__0:
			case BOOL:
			case NUMBER:
			case STRING:
			case SYMBOL:
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
		public Token character;
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
			setState(23);
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
			case T__0:
				_localctx = new CharacterContext(_localctx);
				enterOuterAlt(_localctx, 3);
				{
				setState(19);
				match(T__0);
				{
				setState(20);
				((CharacterContext)_localctx).character = matchWildcard();
				}
				}
				break;
			case STRING:
				_localctx = new StringContext(_localctx);
				enterOuterAlt(_localctx, 4);
				{
				setState(21);
				match(STRING);
				}
				break;
			case SYMBOL:
				_localctx = new SymbolContext(_localctx);
				enterOuterAlt(_localctx, 5);
				{
				setState(22);
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
			setState(43);
			_errHandler.sync(this);
			switch ( getInterpreter().adaptivePredict(_input,4,_ctx) ) {
			case 1:
				_localctx = new DottedPairContext(_localctx);
				enterOuterAlt(_localctx, 1);
				{
				setState(25);
				match(LPAREN);
				setState(27); 
				_errHandler.sync(this);
				_la = _input.LA(1);
				do {
					{
					{
					setState(26);
					datum();
					}
					}
					setState(29); 
					_errHandler.sync(this);
					_la = _input.LA(1);
				} while ( (((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << BOOL) | (1L << LPAREN) | (1L << LSQUARE) | (1L << DASHSEMI) | (1L << NUMBER) | (1L << STRING) | (1L << SYMBOL))) != 0) );
				setState(31);
				match(DOT);
				setState(32);
				datum();
				setState(33);
				match(RPAREN);
				}
				break;
			case 2:
				_localctx = new ListContext(_localctx);
				enterOuterAlt(_localctx, 2);
				{
				setState(35);
				match(LPAREN);
				setState(39);
				_errHandler.sync(this);
				_la = _input.LA(1);
				while ((((_la) & ~0x3f) == 0 && ((1L << _la) & ((1L << T__0) | (1L << BOOL) | (1L << LPAREN) | (1L << LSQUARE) | (1L << DASHSEMI) | (1L << NUMBER) | (1L << STRING) | (1L << SYMBOL))) != 0)) {
					{
					{
					setState(36);
					datum();
					}
					}
					setState(41);
					_errHandler.sync(this);
					_la = _input.LA(1);
				}
				setState(42);
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
			setState(45);
			match(LSQUARE);
			setState(46);
			match(SYMBOL);
			setState(47);
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\3\35\64\4\2\t\2\4\3"+
		"\t\3\4\4\t\4\4\5\t\5\3\2\3\2\3\2\3\2\3\2\3\2\3\2\5\2\22\n\2\3\3\3\3\3"+
		"\3\3\3\3\3\3\3\5\3\32\n\3\3\4\3\4\6\4\36\n\4\r\4\16\4\37\3\4\3\4\3\4\3"+
		"\4\3\4\3\4\7\4(\n\4\f\4\16\4+\13\4\3\4\5\4.\n\4\3\5\3\5\3\5\3\5\3\5\2"+
		"\2\6\2\4\6\b\2\2\29\2\21\3\2\2\2\4\31\3\2\2\2\6-\3\2\2\2\b/\3\2\2\2\n"+
		"\22\5\4\3\2\13\22\5\6\4\2\f\r\5\b\5\2\r\16\5\2\2\2\16\22\3\2\2\2\17\20"+
		"\7\f\2\2\20\22\5\2\2\2\21\n\3\2\2\2\21\13\3\2\2\2\21\f\3\2\2\2\21\17\3"+
		"\2\2\2\22\3\3\2\2\2\23\32\7\4\2\2\24\32\7\16\2\2\25\26\7\3\2\2\26\32\13"+
		"\2\2\2\27\32\7\17\2\2\30\32\7\20\2\2\31\23\3\2\2\2\31\24\3\2\2\2\31\25"+
		"\3\2\2\2\31\27\3\2\2\2\31\30\3\2\2\2\32\5\3\2\2\2\33\35\7\7\2\2\34\36"+
		"\5\2\2\2\35\34\3\2\2\2\36\37\3\2\2\2\37\35\3\2\2\2\37 \3\2\2\2 !\3\2\2"+
		"\2!\"\7\r\2\2\"#\5\2\2\2#$\7\b\2\2$.\3\2\2\2%)\7\7\2\2&(\5\2\2\2\'&\3"+
		"\2\2\2(+\3\2\2\2)\'\3\2\2\2)*\3\2\2\2*,\3\2\2\2+)\3\2\2\2,.\7\b\2\2-\33"+
		"\3\2\2\2-%\3\2\2\2.\7\3\2\2\2/\60\7\t\2\2\60\61\7\20\2\2\61\62\7\n\2\2"+
		"\62\t\3\2\2\2\7\21\31\37)-";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}