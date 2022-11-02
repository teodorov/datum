// Generated from /Users/ciprian/Playfield/repositories/dart-lambda_spec/datum_cli/lib/src/grammar/Datum.g4 by ANTLR 4.9.2
import org.antlr.v4.runtime.Lexer;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.Token;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.*;
import org.antlr.v4.runtime.dfa.DFA;
import org.antlr.v4.runtime.misc.*;

@SuppressWarnings({"all", "warnings", "unchecked", "unused", "cast"})
public class DatumLexer extends Lexer {
	static { RuntimeMetaData.checkVersion("4.9.2", RuntimeMetaData.VERSION); }

	protected static final DFA[] _decisionToDFA;
	protected static final PredictionContextCache _sharedContextCache =
		new PredictionContextCache();
	public static final int
		T__0=1, T__1=2, BOOL=3, TRUE=4, FALSE=5, LPAREN=6, RPAREN=7, LSQUARE=8, 
		RSQUARE=9, SEMICOLON=10, DASHSEMI=11, DOT=12, NUMBER=13, STRING=14, SYMBOL=15, 
		INITIAL=16, SUBSEQUENT=17, LETTER=18, SPECIAL_INITIAL=19, SPECIAL_SUBSEQUENT=20, 
		EXPLICIT_SIGN=21, DASH=22, EQUALS=23, NATURAL=24, DIGIT=25, LINE_COMMENT=26, 
		BLOCK_COMMENT=27, WS=28;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "T__1", "BOOL", "TRUE", "FALSE", "LPAREN", "RPAREN", "LSQUARE", 
			"RSQUARE", "SEMICOLON", "DASHSEMI", "DOT", "NUMBER", "STRING", "SYMBOL", 
			"INITIAL", "SUBSEQUENT", "LETTER", "SPECIAL_INITIAL", "SPECIAL_SUBSEQUENT", 
			"EXPLICIT_SIGN", "DASH", "EQUALS", "NATURAL", "DIGIT", "LINE_COMMENT", 
			"BLOCK_COMMENT", "WS"
		};
	}
	public static final String[] ruleNames = makeRuleNames();

	private static String[] makeLiteralNames() {
		return new String[] {
			null, "'''", "'#\\'", null, "'true'", "'false'", "'('", "')'", "'['", 
			"']='", "';'", "'#;'", "'.'", null, null, null, null, null, null, null, 
			null, null, "'#'", "'='"
		};
	}
	private static final String[] _LITERAL_NAMES = makeLiteralNames();
	private static String[] makeSymbolicNames() {
		return new String[] {
			null, null, null, "BOOL", "TRUE", "FALSE", "LPAREN", "RPAREN", "LSQUARE", 
			"RSQUARE", "SEMICOLON", "DASHSEMI", "DOT", "NUMBER", "STRING", "SYMBOL", 
			"INITIAL", "SUBSEQUENT", "LETTER", "SPECIAL_INITIAL", "SPECIAL_SUBSEQUENT", 
			"EXPLICIT_SIGN", "DASH", "EQUALS", "NATURAL", "DIGIT", "LINE_COMMENT", 
			"BLOCK_COMMENT", "WS"
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


	public DatumLexer(CharStream input) {
		super(input);
		_interp = new LexerATNSimulator(this,_ATN,_decisionToDFA,_sharedContextCache);
	}

	@Override
	public String getGrammarFileName() { return "Datum.g4"; }

	@Override
	public String[] getRuleNames() { return ruleNames; }

	@Override
	public String getSerializedATN() { return _serializedATN; }

	@Override
	public String[] getChannelNames() { return channelNames; }

	@Override
	public String[] getModeNames() { return modeNames; }

	@Override
	public ATN getATN() { return _ATN; }

	public static final String _serializedATN =
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\36\u00c3\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\4\33\t\33\4\34\t\34\4\35\t\35\3\2\3\2\3\3\3\3\3\3\3\4"+
		"\3\4\5\4C\n\4\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\6\3\6\3\6\3\6\3\7\3\7\3\b"+
		"\3\b\3\t\3\t\3\n\3\n\3\n\3\13\3\13\3\f\3\f\3\f\3\r\3\r\3\16\5\16a\n\16"+
		"\3\16\3\16\3\16\3\16\5\16g\n\16\3\17\3\17\3\17\3\17\7\17m\n\17\f\17\16"+
		"\17p\13\17\3\17\3\17\3\20\3\20\7\20v\n\20\f\20\16\20y\13\20\3\20\3\20"+
		"\7\20}\n\20\f\20\16\20\u0080\13\20\3\20\5\20\u0083\n\20\3\21\3\21\5\21"+
		"\u0087\n\21\3\22\3\22\3\22\5\22\u008c\n\22\3\23\3\23\3\24\3\24\3\25\3"+
		"\25\3\25\5\25\u0095\n\25\3\26\3\26\3\27\3\27\3\30\3\30\3\31\6\31\u009e"+
		"\n\31\r\31\16\31\u009f\3\32\3\32\3\33\3\33\7\33\u00a6\n\33\f\33\16\33"+
		"\u00a9\13\33\3\33\3\33\3\33\3\33\3\34\3\34\3\34\3\34\7\34\u00b3\n\34\f"+
		"\34\16\34\u00b6\13\34\3\34\3\34\3\34\3\34\3\34\3\35\6\35\u00be\n\35\r"+
		"\35\16\35\u00bf\3\35\3\35\5~\u00a7\u00b4\2\36\3\3\5\4\7\5\t\6\13\7\r\b"+
		"\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35\20\37\21!\22#\23%\24\'\25)\26"+
		"+\27-\30/\31\61\32\63\33\65\34\67\359\36\3\2\b\3\2$$\t\2##&(,\61<<>B`"+
		"a\u0080\u0080\4\2C\\c|\4\2--//\3\2\62;\5\2\13\f\17\17\"\"\2\u00d3\2\3"+
		"\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2\13\3\2\2\2\2\r\3\2\2\2"+
		"\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3\2\2\2\2\27\3\2\2\2\2\31"+
		"\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2\2\2!\3\2\2\2\2#\3\2\2\2"+
		"\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2\2-\3\2\2\2\2/\3\2\2\2\2"+
		"\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2\2\67\3\2\2\2\29\3\2\2\2\3;\3\2\2"+
		"\2\5=\3\2\2\2\7B\3\2\2\2\tD\3\2\2\2\13I\3\2\2\2\rO\3\2\2\2\17Q\3\2\2\2"+
		"\21S\3\2\2\2\23U\3\2\2\2\25X\3\2\2\2\27Z\3\2\2\2\31]\3\2\2\2\33`\3\2\2"+
		"\2\35h\3\2\2\2\37\u0082\3\2\2\2!\u0086\3\2\2\2#\u008b\3\2\2\2%\u008d\3"+
		"\2\2\2\'\u008f\3\2\2\2)\u0094\3\2\2\2+\u0096\3\2\2\2-\u0098\3\2\2\2/\u009a"+
		"\3\2\2\2\61\u009d\3\2\2\2\63\u00a1\3\2\2\2\65\u00a3\3\2\2\2\67\u00ae\3"+
		"\2\2\29\u00bd\3\2\2\2;<\7)\2\2<\4\3\2\2\2=>\7%\2\2>?\7^\2\2?\6\3\2\2\2"+
		"@C\5\t\5\2AC\5\13\6\2B@\3\2\2\2BA\3\2\2\2C\b\3\2\2\2DE\7v\2\2EF\7t\2\2"+
		"FG\7w\2\2GH\7g\2\2H\n\3\2\2\2IJ\7h\2\2JK\7c\2\2KL\7n\2\2LM\7u\2\2MN\7"+
		"g\2\2N\f\3\2\2\2OP\7*\2\2P\16\3\2\2\2QR\7+\2\2R\20\3\2\2\2ST\7]\2\2T\22"+
		"\3\2\2\2UV\7_\2\2VW\7?\2\2W\24\3\2\2\2XY\7=\2\2Y\26\3\2\2\2Z[\7%\2\2["+
		"\\\7=\2\2\\\30\3\2\2\2]^\7\60\2\2^\32\3\2\2\2_a\5+\26\2`_\3\2\2\2`a\3"+
		"\2\2\2ab\3\2\2\2bf\5\61\31\2cd\5\31\r\2de\5\61\31\2eg\3\2\2\2fc\3\2\2"+
		"\2fg\3\2\2\2g\34\3\2\2\2hn\7$\2\2ij\7^\2\2jm\7$\2\2km\n\2\2\2li\3\2\2"+
		"\2lk\3\2\2\2mp\3\2\2\2nl\3\2\2\2no\3\2\2\2oq\3\2\2\2pn\3\2\2\2qr\7$\2"+
		"\2r\36\3\2\2\2sw\5!\21\2tv\5#\22\2ut\3\2\2\2vy\3\2\2\2wu\3\2\2\2wx\3\2"+
		"\2\2x\u0083\3\2\2\2yw\3\2\2\2z~\7~\2\2{}\13\2\2\2|{\3\2\2\2}\u0080\3\2"+
		"\2\2~\177\3\2\2\2~|\3\2\2\2\177\u0081\3\2\2\2\u0080~\3\2\2\2\u0081\u0083"+
		"\7~\2\2\u0082s\3\2\2\2\u0082z\3\2\2\2\u0083 \3\2\2\2\u0084\u0087\5%\23"+
		"\2\u0085\u0087\t\3\2\2\u0086\u0084\3\2\2\2\u0086\u0085\3\2\2\2\u0087\""+
		"\3\2\2\2\u0088\u008c\5!\21\2\u0089\u008c\5\63\32\2\u008a\u008c\5)\25\2"+
		"\u008b\u0088\3\2\2\2\u008b\u0089\3\2\2\2\u008b\u008a\3\2\2\2\u008c$\3"+
		"\2\2\2\u008d\u008e\t\4\2\2\u008e&\3\2\2\2\u008f\u0090\t\3\2\2\u0090(\3"+
		"\2\2\2\u0091\u0095\5+\26\2\u0092\u0095\5\31\r\2\u0093\u0095\7B\2\2\u0094"+
		"\u0091\3\2\2\2\u0094\u0092\3\2\2\2\u0094\u0093\3\2\2\2\u0095*\3\2\2\2"+
		"\u0096\u0097\t\5\2\2\u0097,\3\2\2\2\u0098\u0099\7%\2\2\u0099.\3\2\2\2"+
		"\u009a\u009b\7?\2\2\u009b\60\3\2\2\2\u009c\u009e\5\63\32\2\u009d\u009c"+
		"\3\2\2\2\u009e\u009f\3\2\2\2\u009f\u009d\3\2\2\2\u009f\u00a0\3\2\2\2\u00a0"+
		"\62\3\2\2\2\u00a1\u00a2\t\6\2\2\u00a2\64\3\2\2\2\u00a3\u00a7\7=\2\2\u00a4"+
		"\u00a6\13\2\2\2\u00a5\u00a4\3\2\2\2\u00a6\u00a9\3\2\2\2\u00a7\u00a8\3"+
		"\2\2\2\u00a7\u00a5\3\2\2\2\u00a8\u00aa\3\2\2\2\u00a9\u00a7\3\2\2\2\u00aa"+
		"\u00ab\7\f\2\2\u00ab\u00ac\3\2\2\2\u00ac\u00ad\b\33\2\2\u00ad\66\3\2\2"+
		"\2\u00ae\u00af\7%\2\2\u00af\u00b0\7=\2\2\u00b0\u00b4\3\2\2\2\u00b1\u00b3"+
		"\13\2\2\2\u00b2\u00b1\3\2\2\2\u00b3\u00b6\3\2\2\2\u00b4\u00b5\3\2\2\2"+
		"\u00b4\u00b2\3\2\2\2\u00b5\u00b7\3\2\2\2\u00b6\u00b4\3\2\2\2\u00b7\u00b8"+
		"\7=\2\2\u00b8\u00b9\7%\2\2\u00b9\u00ba\3\2\2\2\u00ba\u00bb\b\34\2\2\u00bb"+
		"8\3\2\2\2\u00bc\u00be\t\7\2\2\u00bd\u00bc\3\2\2\2\u00be\u00bf\3\2\2\2"+
		"\u00bf\u00bd\3\2\2\2\u00bf\u00c0\3\2\2\2\u00c0\u00c1\3\2\2\2\u00c1\u00c2"+
		"\b\35\2\2\u00c2:\3\2\2\2\22\2B`flnw~\u0082\u0086\u008b\u0094\u009f\u00a7"+
		"\u00b4\u00bf\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}