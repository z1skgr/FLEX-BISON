%{
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include "teac_parser.tab.h"
#include "cgen.h"

int line_num = 1;

%}

IDENT [a-zA-Z_][0-9a-zA-Z_]*
DIGIT  [0-9]
NUMBER  {DIGIT}{DIGIT}*
DECIMAL ("."{NUMBER})|({NUMBER}("."{NUMBER}?)?)
REAL    {DECIMAL}([eE][+-]?{NUMBER})?

ESCHAR  ("\\n")|("\\t")|("\\r")|("\\\\")|("\\\"")
STRING_SQ  ("\'")(({ESCHAR})|([^\\\'\"]))*("\'")
STRING_DQ  ("\"")(({ESCHAR})|([^\\\'\"]))*("\"")
STRING  ({STRING_SQ})|({STRING_DQ})

%x comment

%%

int    				{ fprintf(stderr,"Line %d: Found token KEYWORD_INT: %s\n", line_num, yytext);	return TK_INT;}
real  				{ fprintf(stderr,"Line %d: Found token KEYWORD_REAL: %s\n", line_num, yytext);	return TK_REAL;}
bool  				{ fprintf(stderr,"Line %d: Found token KEYWORD_BOOL: %s\n", line_num, yytext);	return TK_BOOL;}
string  		 	{ fprintf(stderr,"Line %d: Found token KEYWORD_STRING: %s\n", line_num, yytext);	return TK_STRING;}
true				{ fprintf(stderr,"Line %d: Found token KEYWORD_TRUE: %s\n", line_num, yytext);	return KW_TRUE;}

false				{ fprintf(stderr,"Line %d: Found token KEYWORD_FALSE: %s\n", line_num, yytext);	return KW_FALSE;}
if      			{ fprintf(stderr,"Line %d: Found token KEYWORD_IF: %s\n", line_num, yytext);		return KW_IF;}
then				{ fprintf(stderr,"Line %d: Found token KEYWORD_THEN: %s\n", line_num, yytext);	return KW_THEN;}
else   				{ fprintf(stderr,"Line %d: Found token KEYWORD_ELSE: %s\n", line_num, yytext);	return KW_ELSE;}
fi  				{ fprintf(stderr,"Line %d: Found token KEYWORD_FI: %s\n", line_num, yytext);		return KW_FI;}

while  				{ fprintf(stderr,"Line %d: Found token KEYWORD_WHILE: %s\n", line_num, yytext);	return KW_WHILE;}
loop  				{ fprintf(stderr,"Line %d: Found token KEYWORD_LOOP: %s\n", line_num, yytext);	return KW_LOOP;}
pool  				{ fprintf(stderr,"Line %d: Found token KEYWORD_POOL: %s\n", line_num, yytext);	return KW_POOL;}
const  		 		{ fprintf(stderr,"Line %d: Found token KEYWORD_CONST: %s\n", line_num, yytext);	return KW_CONST;}
let  		 		{ fprintf(stderr,"Line %d: Found token KEYWORD_LET: %s\n", line_num, yytext);	return KW_LET;}

return  			{ fprintf(stderr,"Line %d: Found token KEYWORD_RETURN: %s\n", line_num, yytext);	return KW_RETURN;}
not  				{ fprintf(stderr,"Line %d: Found token KEYWORD_NOT: %s\n", line_num, yytext);		return KW_NOT;}
and  				{ fprintf(stderr,"Line %d: Found token KEYWORD_AND: %s\n", line_num, yytext);		return KW_AND;}
or  				{ fprintf(stderr,"Line %d: Found token KEYWORD_OR: %s\n", line_num, yytext);		return KW_OR;}
start 				{ fprintf(stderr,"Line %d: Found token KEYWORD_START: %s\n", line_num, yytext);	return KW_START;}



"+" 		{ fprintf(stderr,"Line %d: Found token OPERATION_PLUS: %s\n", line_num, yytext); return '+';   }
"-"			{ fprintf(stderr,"Line %d: Found token OPERATION_MINUS: %s\n", line_num, yytext);  return '-'; }
"*"			{ fprintf(stderr,"Line %d: Found token OPERATION_MULTI: %s\n", line_num, yytext); return '*';  }
"/"			{ fprintf(stderr,"Line %d: Found token OPERATION_DIVIDE: %s\n", line_num, yytext);  return '/'; }
"%"			{ fprintf(stderr,"Line %d: Found token OPERATION_MODULO: %s\n", line_num, yytext);  return '%'; }

"="			{ fprintf(stderr,"Line %d: Found token OPERATION_EQUAL: %s\n", line_num, yytext);  return '=';}
"!="		{ fprintf(stderr,"Line %d: Found token OPERATION_NOTEQUAL: %s\n", line_num, yytext); return OP_NOTEQUAL;}
"<"			{ fprintf(stderr,"Line %d: Found token OPERATION_LESS: %s\n", line_num, yytext);   return '<';}
"<="		{ fprintf(stderr,"Line %d: Found token OPERATION_LESSEQUAL: %s\n", line_num, yytext);   return OP_LESSEQUAL;}

"&&"		{ fprintf(stderr,"Line %d: Found token OPERATION_AND: %s\n", line_num, yytext);  return OP_AND; }
"||"	    { fprintf(stderr,"Line %d: Found token OPERATION_OR: %s\n", line_num, yytext);  return OP_OR; }
"!"			{ fprintf(stderr,"Line %d: Found token OPERATION_NOT: %s\n", line_num, yytext);   return OP_NOT; }


";"			{ fprintf(stderr,"Line %d: Found token DELIMETER_SEMI: %s\n", line_num, yytext);  return ';'; }
"("			{ fprintf(stderr,"Line %d: Found token DELIMETER_LBRACKET: %s\n", line_num, yytext);    return '(';}
")"			{ fprintf(stderr,"Line %d: Found token DELIMETER_RBRACKET: %s\n", line_num, yytext);    return ')';}
","			{ fprintf(stderr,"Line %d: Found token DELIMETER_COMMA: %s\n", line_num, yytext); return ',';}
"["			{ fprintf(stderr,"Line %d: Found token DELIMETER_LSQBRACKET: %s\n", line_num, yytext);return '[';}
"]"			{ fprintf(stderr,"Line %d: Found token DELIMETER_RSQBRACKET: %s\n", line_num, yytext);  return ']';}
"<-"		{ fprintf(stderr,"Line %d: Found token DELIMETER_ASSIGN: %s\n", line_num, yytext);  return TK_ASSGN ;}
":"			{ fprintf(stderr,"Line %d: Found token DELIMETER_COLON: %s\n", line_num, yytext);  return ':'; }

"{"			{ fprintf(stderr,"Line %d: Found token DELIMETER_LCURLY_BRACKET: %s\n", line_num, yytext);  return '{' ;}
"}"			{ fprintf(stderr,"Line %d: Found token DELIMETER_RCURLY_BRACKET: %s\n", line_num, yytext);  return '}' ;}
"=>"        { fprintf(stderr,"Line %d: Found token DELIMETER_ARROW: %s\n", line_num, yytext);  return DEL_ARROW ;}

{IDENT}  	{ fprintf(stderr,"Line %d: Found the IDENTIFIER: %s\n",line_num, yytext);yylval.crepr = strdup(yytext); return IDENT; }
{NUMBER}	{ fprintf(stderr,"Line %d: Found the NUMBER: %s\n",line_num, yytext);yylval.crepr = strdup(yytext); return POSINT; }
{REAL}		{ fprintf(stderr,"Line %d: Found the REAL: %s\n",line_num, yytext);yylval.crepr = strdup(yytext); return REAL; }
{STRING}	{ fprintf(stderr,"Line %d: Found the STRING: %s\n",line_num, yytext);yylval.crepr = strdup(yytext); return STRING; }



"--"[^\n]*  	/* eat line comments */

"(*"					BEGIN(comment);
<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*)\n]*   /* eat up '*'s not followed by ')'s */
<comment>\n             ++line_num;
<comment>"*"+")"        BEGIN(INITIAL);


[ \r\t]				/* skip whitespace */
\n 						++line_num;
<<EOF>> 			return EOF;

.             { yyerror("Lexical Error in Line %d: unrecognized literal '%s'", line_num, yytext); }


%%

