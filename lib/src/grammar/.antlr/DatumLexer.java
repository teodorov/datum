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
		BOOL=1, TRUE=2, FALSE=3, LPAREN=4, RPAREN=5, LSQUARE=6, RSQUARE=7, SEMICOLON=8, 
		DASHSEMI=9, DOT=10, NUMBER=11, STRING=12, SYMBOL=13, INITIAL=14, SUBSEQUENT=15, 
		LETTER=16, SPECIAL_INITIAL=17, SPECIAL_SUBSEQUENT=18, EXPLICIT_SIGN=19, 
		DASH=20, EQUALS=21, CHARACTER=22, NATURAL=23, DIGIT=24, LINE_COMMENT=25, 
		BLOCK_COMMENT=26, WS=27;
	public static String[] channelNames = {
		"DEFAULT_TOKEN_CHANNEL", "HIDDEN"
	};

	public static String[] modeNames = {
		"DEFAULT_MODE"
	};

	private static String[] makeRuleNames() {
		return new String[] {
			"BOOL", "TRUE", "FALSE", "LPAREN", "RPAREN", "LSQUARE", "RSQUARE", "SEMICOLON", 
			"DASHSEMI", "DOT", "NUMBER", "STRING", "SYMBOL", "INITIAL", "SUBSEQUENT", 
			"LETTER", "SPECIAL_INITIAL", "SPECIAL_SUBSEQUENT", "EXPLICIT_SIGN", "DASH", 
			"EQUALS", "CHARACTER", "NATURAL", "DIGIT", "LINE_COMMENT", "BLOCK_COMMENT", 
			"WS"
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
		"\3\u608b\ua72a\u8133\ub9ed\u417c\u3be7\u7786\u5964\2\35\u00c1\b\1\4\2"+
		"\t\2\4\3\t\3\4\4\t\4\4\5\t\5\4\6\t\6\4\7\t\7\4\b\t\b\4\t\t\t\4\n\t\n\4"+
		"\13\t\13\4\f\t\f\4\r\t\r\4\16\t\16\4\17\t\17\4\20\t\20\4\21\t\21\4\22"+
		"\t\22\4\23\t\23\4\24\t\24\4\25\t\25\4\26\t\26\4\27\t\27\4\30\t\30\4\31"+
		"\t\31\4\32\t\32\4\33\t\33\4\34\t\34\3\2\3\2\5\2<\n\2\3\3\3\3\3\3\3\3\3"+
		"\3\3\4\3\4\3\4\3\4\3\4\3\4\3\5\3\5\3\6\3\6\3\7\3\7\3\b\3\b\3\b\3\t\3\t"+
		"\3\n\3\n\3\n\3\13\3\13\3\f\5\fZ\n\f\3\f\3\f\3\f\3\f\5\f`\n\f\3\r\3\r\3"+
		"\r\3\r\7\rf\n\r\f\r\16\ri\13\r\3\r\3\r\3\16\3\16\7\16o\n\16\f\16\16\16"+
		"r\13\16\3\16\3\16\7\16v\n\16\f\16\16\16y\13\16\3\16\5\16|\n\16\3\17\3"+
		"\17\5\17\u0080\n\17\3\20\3\20\3\20\5\20\u0085\n\20\3\21\3\21\3\22\3\22"+
		"\3\23\3\23\3\23\5\23\u008e\n\23\3\24\3\24\3\25\3\25\3\26\3\26\3\27\3\27"+
		"\3\27\3\27\3\27\3\30\6\30\u009c\n\30\r\30\16\30\u009d\3\31\3\31\3\32\3"+
		"\32\7\32\u00a4\n\32\f\32\16\32\u00a7\13\32\3\32\3\32\3\32\3\32\3\33\3"+
		"\33\3\33\3\33\7\33\u00b1\n\33\f\33\16\33\u00b4\13\33\3\33\3\33\3\33\3"+
		"\33\3\33\3\34\6\34\u00bc\n\34\r\34\16\34\u00bd\3\34\3\34\5w\u00a5\u00b2"+
		"\2\35\3\3\5\4\7\5\t\6\13\7\r\b\17\t\21\n\23\13\25\f\27\r\31\16\33\17\35"+
		"\20\37\21!\22#\23%\24\'\25)\26+\27-\30/\31\61\32\63\33\65\34\67\35\3\2"+
		"\b\3\2$$\t\2##&(,\61<<>B`a\u0080\u0080\4\2C\\c|\4\2--//\3\2\62;\5\2\13"+
		"\f\17\17\"\"\2\u00d1\2\3\3\2\2\2\2\5\3\2\2\2\2\7\3\2\2\2\2\t\3\2\2\2\2"+
		"\13\3\2\2\2\2\r\3\2\2\2\2\17\3\2\2\2\2\21\3\2\2\2\2\23\3\2\2\2\2\25\3"+
		"\2\2\2\2\27\3\2\2\2\2\31\3\2\2\2\2\33\3\2\2\2\2\35\3\2\2\2\2\37\3\2\2"+
		"\2\2!\3\2\2\2\2#\3\2\2\2\2%\3\2\2\2\2\'\3\2\2\2\2)\3\2\2\2\2+\3\2\2\2"+
		"\2-\3\2\2\2\2/\3\2\2\2\2\61\3\2\2\2\2\63\3\2\2\2\2\65\3\2\2\2\2\67\3\2"+
		"\2\2\3;\3\2\2\2\5=\3\2\2\2\7B\3\2\2\2\tH\3\2\2\2\13J\3\2\2\2\rL\3\2\2"+
		"\2\17N\3\2\2\2\21Q\3\2\2\2\23S\3\2\2\2\25V\3\2\2\2\27Y\3\2\2\2\31a\3\2"+
		"\2\2\33{\3\2\2\2\35\177\3\2\2\2\37\u0084\3\2\2\2!\u0086\3\2\2\2#\u0088"+
		"\3\2\2\2%\u008d\3\2\2\2\'\u008f\3\2\2\2)\u0091\3\2\2\2+\u0093\3\2\2\2"+
		"-\u0095\3\2\2\2/\u009b\3\2\2\2\61\u009f\3\2\2\2\63\u00a1\3\2\2\2\65\u00ac"+
		"\3\2\2\2\67\u00bb\3\2\2\29<\5\5\3\2:<\5\7\4\2;9\3\2\2\2;:\3\2\2\2<\4\3"+
		"\2\2\2=>\7v\2\2>?\7t\2\2?@\7w\2\2@A\7g\2\2A\6\3\2\2\2BC\7h\2\2CD\7c\2"+
		"\2DE\7n\2\2EF\7u\2\2FG\7g\2\2G\b\3\2\2\2HI\7*\2\2I\n\3\2\2\2JK\7+\2\2"+
		"K\f\3\2\2\2LM\7]\2\2M\16\3\2\2\2NO\7_\2\2OP\7?\2\2P\20\3\2\2\2QR\7=\2"+
		"\2R\22\3\2\2\2ST\7%\2\2TU\7=\2\2U\24\3\2\2\2VW\7\60\2\2W\26\3\2\2\2XZ"+
		"\5\'\24\2YX\3\2\2\2YZ\3\2\2\2Z[\3\2\2\2[_\5/\30\2\\]\5\25\13\2]^\5/\30"+
		"\2^`\3\2\2\2_\\\3\2\2\2_`\3\2\2\2`\30\3\2\2\2ag\7$\2\2bc\7^\2\2cf\7$\2"+
		"\2df\n\2\2\2eb\3\2\2\2ed\3\2\2\2fi\3\2\2\2ge\3\2\2\2gh\3\2\2\2hj\3\2\2"+
		"\2ig\3\2\2\2jk\7$\2\2k\32\3\2\2\2lp\5\35\17\2mo\5\37\20\2nm\3\2\2\2or"+
		"\3\2\2\2pn\3\2\2\2pq\3\2\2\2q|\3\2\2\2rp\3\2\2\2sw\7~\2\2tv\13\2\2\2u"+
		"t\3\2\2\2vy\3\2\2\2wx\3\2\2\2wu\3\2\2\2xz\3\2\2\2yw\3\2\2\2z|\7~\2\2{"+
		"l\3\2\2\2{s\3\2\2\2|\34\3\2\2\2}\u0080\5!\21\2~\u0080\t\3\2\2\177}\3\2"+
		"\2\2\177~\3\2\2\2\u0080\36\3\2\2\2\u0081\u0085\5\35\17\2\u0082\u0085\5"+
		"\61\31\2\u0083\u0085\5%\23\2\u0084\u0081\3\2\2\2\u0084\u0082\3\2\2\2\u0084"+
		"\u0083\3\2\2\2\u0085 \3\2\2\2\u0086\u0087\t\4\2\2\u0087\"\3\2\2\2\u0088"+
		"\u0089\t\3\2\2\u0089$\3\2\2\2\u008a\u008e\5\'\24\2\u008b\u008e\5\25\13"+
		"\2\u008c\u008e\7B\2\2\u008d\u008a\3\2\2\2\u008d\u008b\3\2\2\2\u008d\u008c"+
		"\3\2\2\2\u008e&\3\2\2\2\u008f\u0090\t\5\2\2\u0090(\3\2\2\2\u0091\u0092"+
		"\7%\2\2\u0092*\3\2\2\2\u0093\u0094\7?\2\2\u0094,\3\2\2\2\u0095\u0096\7"+
		"%\2\2\u0096\u0097\7^\2\2\u0097\u0098\3\2\2\2\u0098\u0099\13\2\2\2\u0099"+
		".\3\2\2\2\u009a\u009c\5\61\31\2\u009b\u009a\3\2\2\2\u009c\u009d\3\2\2"+
		"\2\u009d\u009b\3\2\2\2\u009d\u009e\3\2\2\2\u009e\60\3\2\2\2\u009f\u00a0"+
		"\t\6\2\2\u00a0\62\3\2\2\2\u00a1\u00a5\7=\2\2\u00a2\u00a4\13\2\2\2\u00a3"+
		"\u00a2\3\2\2\2\u00a4\u00a7\3\2\2\2\u00a5\u00a6\3\2\2\2\u00a5\u00a3\3\2"+
		"\2\2\u00a6\u00a8\3\2\2\2\u00a7\u00a5\3\2\2\2\u00a8\u00a9\7\f\2\2\u00a9"+
		"\u00aa\3\2\2\2\u00aa\u00ab\b\32\2\2\u00ab\64\3\2\2\2\u00ac\u00ad\7%\2"+
		"\2\u00ad\u00ae\7=\2\2\u00ae\u00b2\3\2\2\2\u00af\u00b1\13\2\2\2\u00b0\u00af"+
		"\3\2\2\2\u00b1\u00b4\3\2\2\2\u00b2\u00b3\3\2\2\2\u00b2\u00b0\3\2\2\2\u00b3"+
		"\u00b5\3\2\2\2\u00b4\u00b2\3\2\2\2\u00b5\u00b6\7=\2\2\u00b6\u00b7\7%\2"+
		"\2\u00b7\u00b8\3\2\2\2\u00b8\u00b9\b\33\2\2\u00b9\66\3\2\2\2\u00ba\u00bc"+
		"\t\7\2\2\u00bb\u00ba\3\2\2\2\u00bc\u00bd\3\2\2\2\u00bd\u00bb\3\2\2\2\u00bd"+
		"\u00be\3\2\2\2\u00be\u00bf\3\2\2\2\u00bf\u00c0\b\34\2\2\u00c08\3\2\2\2"+
		"\22\2;Y_egpw{\177\u0084\u008d\u009d\u00a5\u00b2\u00bd\3\b\2\2";
	public static final ATN _ATN =
		new ATNDeserializer().deserialize(_serializedATN.toCharArray());
	static {
		_decisionToDFA = new DFA[_ATN.getNumberOfDecisions()];
		for (int i = 0; i < _ATN.getNumberOfDecisions(); i++) {
			_decisionToDFA[i] = new DFA(_ATN.getDecisionState(i), i);
		}
	}
}