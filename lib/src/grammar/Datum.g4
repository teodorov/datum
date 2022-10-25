grammar Datum;

datum
    : leaf_datum                #Leaf
    | composite_datum           #Composite
    | label datum               #Definition
    | '#;' datum                #Commented
    ;

leaf_datum
    : BOOL                      #Boolean
    | NUMBER                    #Number
    | CHARACTER                 #Character
    | STRING                    #String
    | SYMBOL                    #Symbol //an identifier
    ;

composite_datum
    : '(' datum+ DOT datum ')' #DottedPair
    | '(' datum* ')'           #List
    ;
label : '[' SYMBOL ']=' ;

BOOL        : TRUE | FALSE ;
TRUE : 'true';
FALSE: 'false';
LPAREN: '(';
RPAREN: ')';
LSQUARE: '[';
RSQUARE: ']=';

SEMICOLON: ';';
DASHSEMI: '#;';

DOT: '.';

NUMBER      : EXPLICIT_SIGN? NATURAL (DOT NATURAL)?;

STRING      : '"' ('\\"'| ~'"')* '"';
SYMBOL      : INITIAL SUBSEQUENT*
            | '|' .*? '|';

INITIAL     : LETTER
            | [!$%&*+-./:<=>?@^_~];
SUBSEQUENT  : INITIAL
            | DIGIT
            | SPECIAL_SUBSEQUENT
            ;

LETTER              : [a-zA-Z];
SPECIAL_INITIAL     : [!$%&*+-./:<=>?@^_~];
SPECIAL_SUBSEQUENT  : EXPLICIT_SIGN | DOT | '@';
EXPLICIT_SIGN       : '+' | '-';

DASH : '#';
EQUALS : '=';


CHARACTER   : '#\\' .;

NATURAL     : DIGIT+;

DIGIT       : [0-9];

LINE_COMMENT : ';' .*? '\n' -> skip ;
BLOCK_COMMENT : '#;' .*? ';#' ->skip ;
WS : [ \r\t\n]+ -> skip ;
//UNICODE_WS : [\p{White_Space}] -> skip;
