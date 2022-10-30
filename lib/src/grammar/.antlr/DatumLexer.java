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
		T__0=1, BOOL=2, TRUE=3, FALSE=4, LPAREN=5, RPAREN=6, LSQUARE=7, RSQUARE=8, 
		SEMICOLON=9, DASHSEMI=10, DOT=11, NUMBER=12, STRING=13, SYMBOL=14, INITIAL=15, 
		SUBSEQUENT=16, LETTER=17, SPECIAL_INITIAL=18, SPECIAL_SUBSEQUENT=19, EXPLICIT_SIGN=20, 
		DASH=21, EQUALS=22, NATURAL=23, DIGIT=24, LINE_COMMENT=25, BLOCK_COMMENT=26, 
		WS=27;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"T__0", "BOOL", "TRUE", "FALSE", "LPAREN", "RPAREN", "LSQUARE", "RSQUARE", 
			"SEMICOLON", "DASHSEMI", "DOT", "NUMBER", "STRING", "SYMBOL", "INITIAL", 
			"SUBSEQUENT", "LETTER", "SPECIAL_INITIAL", "SPECIAL_SUBSEQUENT", "EXPLICIT_SIGN", 
			"DASH", "EQUALS", "NATURAL", "DIGIT", "LINE_COMMENT", "BLOCK_COMMENT", 
			"WS"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\35\u00bf\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\4\33\t\33\4\34\t\34\3\2\3\2\3\2\3\3\3\3\5\3?\n\3\3\4\3"+
		"\4\3\4\3\4\3\4\3\5\3\5\3\5\3\5\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\t\3\t"+
		"\3\t\3\n\3\n\3\13\3\13\3\13\3\f\3\f\3\r\5\r]\n\r\3\r\3\r\3\r\3\r\5\rc"+
		"\n\r\3\16\3\16\3\16\3\16\7\16i\n\16\f\16\16\16l\13\16\3\16\3\16\3\17\3"+
		"\17\7\17r\n\17\f\17\16\17u\13\17\3\17\3\17\7\17y\n\17\f\17\16\17|\13\17"+
		"\3\17\5\17\177\n\17\3\20\3\20\5\20\u0083\n\20\3\21\3\21\3\21\5\21\u0088"+
		"\n\21\3\22\3\22\3\23\3\23\3\24\3\24\3\24\5\24\u0091\n\24\3\25\3\25\3\26"+
		"\3\26\3\27\3\27\3\30\6\30\u009a\n\30\r\30\16\30\u009b\3\31\3\31\3\32\3"+
		"\32\7\32\u00a2\n\32\f\32\16\32\u00a5\13\32\3\32\3\32\3\32\3\32\3\33\3"+
		"\33\3\33\3\33\7\33\u00af\n\33\f\33\16\33\u00b2\13\33\3\33\3\33\3\33\3"+
		"\33\3\33\3\34\6\34\u00ba\n\34\r\34\16\34\u00bb\3\34\3\34\5z\u00a3\u00b0"+
		"\2\35\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35"+
		"\20\37\21!\22#\23%\24\'\25)\26+\27-\30/\31\61\32\63\33\65\34\67\35\3\2"+
		"\b\3\2$$\t\2##&(,\61<<>B`a\u0080\u0080\4\2C\\c|\4\2--//\3\2\62;\5\2\13"+
		"\f\17\17\"\"\2\u00cf\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2"+
		"\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3"+
		"\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2"+
		"\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2"+
		"\2-\3\2\2\2\2/\3\2\2\2\2\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2\2\67\3\2"+
		"\2\2\39\3\2\2\2\5>\3\2\2\2\7@\3\2\2\2\tE\3\2\2\2\13K\3\2\2\2\rM\3\2\2"+
		"\2\17O\3\2\2\2\21Q\3\2\2\2\23T\3\2\2\2\25V\3\2\2\2\27Y\3\2\2\2\31\\\3"+
		"\2\2\2\33d\3\2\2\2\35~\3\2\2\2\37\u0082\3\2\2\2!\u0087\3\2\2\2#\u0089"+
		"\3\2\2\2%\u008b\3\2\2\2\'\u0090\3\2\2\2)\u0092\3\2\2\2+\u0094\3\2\2\2"+
		"-\u0096\3\2\2\2/\u0099\3\2\2\2\61\u009d\3\2\2\2\63\u009f\3\2\2\2\65\u00aa"+
		"\3\2\2\2\67\u00b9\3\2\2\29:\7%\2\2:;\7^\2\2;\4\3\2\2\2<?\5\7\4\2=?\5\t"+
		"\5\2><\3\2\2\2>=\3\2\2\2?\6\3\2\2\2@A\7v\2\2AB\7t\2\2BC\7w\2\2CD\7g\2"+
		"\2D\b\3\2\2\2EF\7h\2\2FG\7c\2\2GH\7n\2\2HI\7u\2\2IJ\7g\2\2J\n\3\2\2\2"+
		"KL\7*\2\2L\f\3\2\2\2MN\7+\2\2N\16\3\2\2\2OP\7]\2\2P\20\3\2\2\2QR\7_\2"+
		"\2RS\7?\2\2S\22\3\2\2\2TU\7=\2\2U\24\3\2\2\2VW\7%\2\2WX\7=\2\2X\26\3\2"+
		"\2\2YZ\7\60\2\2Z\30\3\2\2\2[]\5)\25\2\\[\3\2\2\2\\]\3\2\2\2]^\3\2\2\2"+
		"^b\5/\30\2_`\5\27\f\2`a\5/\30\2ac\3\2\2\2b_\3\2\2\2bc\3\2\2\2c\32\3\2"+
		"\2\2dj\7$\2\2ef\7^\2\2fi\7$\2\2gi\n\2\2\2he\3\2\2\2hg\3\2\2\2il\3\2\2"+
		"\2jh\3\2\2\2jk\3\2\2\2km\3\2\2\2lj\3\2\2\2mn\7$\2\2n\34\3\2\2\2os\5\37"+
		"\20\2pr\5!\21\2qp\3\2\2\2ru\3\2\2\2sq\3\2\2\2st\3\2\2\2t\177\3\2\2\2u"+
		"s\3\2\2\2vz\7~\2\2wy\13\2\2\2xw\3\2\2\2y|\3\2\2\2z{\3\2\2\2zx\3\2\2\2"+
		"{}\3\2\2\2|z\3\2\2\2}\177\7~\2\2~o\3\2\2\2~v\3\2\2\2\177\36\3\2\2\2\u0080"+
		"\u0083\5#\22\2\u0081\u0083\t\3\2\2\u0082\u0080\3\2\2\2\u0082\u0081\3\2"+
		"\2\2\u0083 \3\2\2\2\u0084\u0088\5\37\20\2\u0085\u0088\5\61\31\2\u0086"+
		"\u0088\5\'\24\2\u0087\u0084\3\2\2\2\u0087\u0085\3\2\2\2\u0087\u0086\3"+
		"\2\2\2\u0088\"\3\2\2\2\u0089\u008a\t\4\2\2\u008a$\3\2\2\2\u008b\u008c"+
		"\t\3\2\2\u008c&\3\2\2\2\u008d\u0091\5)\25\2\u008e\u0091\5\27\f\2\u008f"+
		"\u0091\7B\2\2\u0090\u008d\3\2\2\2\u0090\u008e\3\2\2\2\u0090\u008f\3\2"+
		"\2\2\u0091(\3\2\2\2\u0092\u0093\t\5\2\2\u0093*\3\2\2\2\u0094\u0095\7%"+
		"\2\2\u0095,\3\2\2\2\u0096\u0097\7?\2\2\u0097.\3\2\2\2\u0098\u009a\5\61"+
		"\31\2\u0099\u0098\3\2\2\2\u009a\u009b\3\2\2\2\u009b\u0099\3\2\2\2\u009b"+
		"\u009c\3\2\2\2\u009c\60\3\2\2\2\u009d\u009e\t\6\2\2\u009e\62\3\2\2\2\u009f"+
		"\u00a3\7=\2\2\u00a0\u00a2\13\2\2\2\u00a1\u00a0\3\2\2\2\u00a2\u00a5\3\2"+
		"\2\2\u00a3\u00a4\3\2\2\2\u00a3\u00a1\3\2\2\2\u00a4\u00a6\3\2\2\2\u00a5"+
		"\u00a3\3\2\2\2\u00a6\u00a7\7\f\2\2\u00a7\u00a8\3\2\2\2\u00a8\u00a9\b\32"+
		"\2\2\u00a9\64\3\2\2\2\u00aa\u00ab\7%\2\2\u00ab\u00ac\7=\2\2\u00ac\u00b0"+
		"\3\2\2\2\u00ad\u00af\13\2\2\2\u00ae\u00ad\3\2\2\2\u00af\u00b2\3\2\2\2"+
		"\u00b0\u00b1\3\2\2\2\u00b0\u00ae\3\2\2\2\u00b1\u00b3\3\2\2\2\u00b2\u00b0"+
		"\3\2\2\2\u00b3\u00b4\7=\2\2\u00b4\u00b5\7%\2\2\u00b5\u00b6\3\2\2\2\u00b6"+
		"\u00b7\b\33\2\2\u00b7\66\3\2\2\2\u00b8\u00ba\t\7\2\2\u00b9\u00b8\3\2\2"+
		"\2\u00ba\u00bb\3\2\2\2\u00bb\u00b9\3\2\2\2\u00bb\u00bc\3\2\2\2\u00bc\u00bd"+
		"\3\2\2\2\u00bd\u00be\b\34\2\2\u00be8\3\2\2\2\22\2>\\bhjsz~\u0082\u0087"+
		"\u0090\u009b\u00a3\u00b0\u00bb\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}