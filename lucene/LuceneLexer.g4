lexer grammar LuceneLexer;

// https://github.com/apache/lucene/blob/main/lucene/queryparser/src/java/org/apache/lucene/queryparser/flexible/standard/parser/StandardSyntaxParser.jj

// <AND:           ("AND" | "&&") >
AND : 'AND' | '&&';

// <OR:            ("OR" | "||") >
OR : 'OR' | '||';

// <NOT:           ("NOT" | "!") >
NOT : 'NOT' | '!';

// <FN_PREFIX:     ("fn:") > : Function
FN_PREFIX : 'fn:' -> mode(F_MODE);

// <PLUS:          "+" >
PLUS : '+';

// <MINUS:         "-" >
MINUS : '-';

// <LPAREN:        "(" >
LPAREN : '(';

// <RPAREN:        ")" >
RPAREN : ')';

// <OP_COLON:      ":" >
OP_COLON : ':';

// <OP_EQUAL:      "=" >
OP_EQUAL : '=';

// <OP_LESSTHAN:   "<"  >
OP_LESSTHAN : '<';

// <OP_LESSTHANEQ: "<=" >
OP_LESSTHANEQ : '<=';

// <OP_MORETHAN:   ">"  >
OP_MORETHAN : '>';

// <OP_MORETHANEQ: ">=" >
OP_MORETHANEQ : '>=';

// <CARAT:         "^" >
CARAT : '^';

// <TILDE:         "~" >
TILDE : '~';

// <QUOTED:        "\"" (<_QUOTED_CHAR>)* "\"">
QUOTED : '"' QUOTED_CHAR* '"';

// <NUMBER:        (<_NUM_CHAR>)+ ( "." (<_NUM_CHAR>)+ )? >
NUMBER : NUM_CHAR+ ( '.' NUM_CHAR+ )?;

// <TERM:          <_TERM_START_CHAR> (<_TERM_CHAR>)* >
TERM : TERM_START_CHAR TERM_CHAR*;

// <REGEXPTERM:    "/" (~[ "/" ] | "\\/" )* "/" >
REGEXPTERM : '/' ( ~'/' | '\\/' )* '/';

// <RANGEIN_START: "[" > : Range
RANGEIN_START : '[' -> mode(R_MODE);

// <RANGEEX_START: "{" > : Range
RANGEEX_START : '{' -> mode(R_MODE);

// <DEFAULT, Range, Function> SKIP : { < <_WHITESPACE> > }
DEFAULT_SKIP : WHITESPACE -> skip;

// Fallthrough rule
UNKNOWN : .;

// <#_WHITESPACE: ( " " | "\t" | "\n" | "\r" | "\u3000") >
fragment WHITESPACE : [ \t\n\r\u3000];

// <#_QUOTED_CHAR: ( ~[ "\"", "\\" ] | <_ESCAPED_CHAR> ) >
fragment QUOTED_CHAR : ~["\\] | ESCAPED_CHAR;

// <#_ESCAPED_CHAR: "\\" ~[] >
fragment ESCAPED_CHAR : '\\' .;

// <#_NUM_CHAR:   ["0"-"9"] >
fragment NUM_CHAR : [0-9];

// <#_TERM_START_CHAR: ( ~[ " ", "\t", "\n", "\r", "\u3000", "+", "-", "!", "(", ")", ":", "^", "@",
//                          "<", ">", "=", "[", "]", "\"", "{", "}", "~", "\\", "/"]
//                       | <_ESCAPED_CHAR> ) >
fragment TERM_START_CHAR
 : ~[ \t\n\r\u3000+\-!():^@<>=[\]"{}~\\/]
 | ESCAPED_CHAR
 ;

// <#_TERM_CHAR: ( <_TERM_START_CHAR> | <_ESCAPED_CHAR> | "-" | "+" ) >
fragment TERM_CHAR : ( TERM_START_CHAR | ESCAPED_CHAR | [\-+] );

// Function mode
mode F_MODE;

 // <DEFAULT, Range, Function> SKIP : { < <_WHITESPACE> > }
 F_SKIP : WHITESPACE -> skip;

 // <LPAREN:        "(" > : DEFAULT
 F_LPAREN : '(' -> type(LPAREN), mode(DEFAULT_MODE);

 // <ATLEAST:       ("atleast" | "atLeast") >
 ATLEAST : 'atleast' | 'atLeast';

 // <AFTER:         ("after") >
 AFTER : 'after';

 // <BEFORE:        ("before") >
 BEFORE : 'before';

 // <CONTAINED_BY:  ("containedBy" | "containedby") >
 CONTAINED_BY : 'containedBy' | 'containedby';

 // <CONTAINING:    ("containing") >
 CONTAINING : 'containing';

 // <EXTEND:        ("extend") >
 EXTEND : 'extend';

 // <FN_OR:         ("or") >
 FN_OR : 'or';

 // <FUZZYTERM:     ("fuzzyterm" | "fuzzyTerm") >
 FUZZYTERM : 'fuzzyterm' | 'fuzzyTerm';

 // <MAXGAPS:       ("maxgaps" | "maxGaps") >
 MAXGAPS : 'maxgaps' | 'maxGaps';

 // <MAXWIDTH:      ("maxwidth" | "maxWidth") >
 MAXWIDTH : 'maxwidth' | 'maxWidth';

 // <NON_OVERLAPPING:  ("nonOverlapping" | "nonoverlapping") >
 NON_OVERLAPPING : 'nonOverlapping' | 'nonoverlapping';

 // <NOT_CONTAINED_BY: ("notContainedBy" | "notcontainedby") >
 NOT_CONTAINED_BY : 'notContainedBy' | 'notcontainedby';

 // <NOT_CONTAINING:   ("notContaining" | "notcontaining") >
 NOT_CONTAINING : 'notContaining' | 'notcontaining';

 // <NOT_WITHIN:    ("notWithin" | "notwithin") >
 NOT_WITHIN : 'notWithin' | 'notwithin';

 // <ORDERED:       ("ordered") >
 ORDERED : 'ordered';

 // <OVERLAPPING:   ("overlapping") >
 OVERLAPPING : 'overlapping';

 // <PHRASE:        ("phrase") >
 PHRASE : 'phrase';

 // <UNORDERED:     ("unordered") >
 UNORDERED : 'unordered';

 // <UNORDERED_NO_OVERLAPS: ("unorderedNoOverlaps" | "unorderednooverlaps") >
 UNORDERED_NO_OVERLAPS : 'unorderedNoOverlaps' | 'unorderednooverlaps';

 // <WILDCARD:      ("wildcard") >
 WILDCARD : 'wildcard';

 // <WITHIN:        ("within") >
 WITHIN : 'within';

// Range mode
mode R_MODE;

 // <DEFAULT, Range, Function> SKIP : { < <_WHITESPACE> > }
 R_SKIP : WHITESPACE -> skip;

 // <RANGE_TO:     "TO">
 RANGE_TO : 'TO';

 // <RANGEIN_END:  "]"> : DEFAULT
 RANGEIN_END : ']' -> mode(DEFAULT_MODE);

 // <RANGEEX_END:  "}"> : DEFAULT
 RANGEEX_END : '}' -> mode(DEFAULT_MODE);

 // <RANGE_QUOTED: "\"" (~["\""] | "\\\"")+ "\"">
 RANGE_QUOTED : '"' ( ~'"' | '\\"' )+ '"';

 // <RANGE_GOOP:   (~[ " ", "]", "}" ])+ >
 RANGE_GOOP : ~[ \]}]+;
