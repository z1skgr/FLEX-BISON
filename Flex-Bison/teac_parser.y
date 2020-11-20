%{
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>		
#include "cgen.h"
#include "teaclib.h"


extern int yylex(void);
extern int line_num;
extern char* yytext;
%}

%union
{
	char* crepr;
}



%token <crepr> IDENT
%token <crepr> POSINT 
%token <crepr> REAL 
%token <crepr> STRING

/*---------------------------------------------------------------------*/
%token TK_INT 
%token TK_REAL
%token TK_BOOL
%token TK_STRING
%token KW_TRUE

%token KW_FALSE
%token KW_IF
%token KW_ELSE
%token KW_FI
%token KW_THEN

%token KW_WHILE
%token KW_LOOP
%token KW_POOL
%token KW_CONST
%token KW_LET

%token KW_RETURN
%token KW_NOT
%token KW_AND
%token KW_OR
%token KW_START

%token OP_NOTEQUAL
%token OP_LESSEQUAL
%token OP_AND
%token OP_OR
%token OP_NOT
/*---------------------------------------------------------------------*/



%token TK_ASSGN
%token DEL_ARROW

%start program


%type <crepr> arg_list
%type <crepr> func_decl
%type <crepr> func_body
%type <crepr> func_list

%type <crepr> decl_list body decl
%type <crepr> const_decl_body const_decl_list const_decl_init const_decl_id
%type <crepr> type_spec
%type <crepr> expr

/*---------------------------------------------------------------------*/

%type <crepr> func_call
%type <crepr> argu_call

%type <crepr> command_list
%type <crepr> command

%type <crepr> return_statement
%type <crepr> logic_expression
%type <crepr> while_loop
%type <crepr> if_statement


/*---------------------------------------------------------------------*/

%left OP_AND OP_OR
%left KW_AND KW_OR
%left '=' '<' OP_LESSEQUAL OP_NOTEQUAL
%left '-' '+'
%left '*' '/' '%'

%right OP_NOT KW_NOT

%precedence KW_THEN
%precedence KW_ELSE

%define parse.error verbose
%debug

%%
/*-----------------------------------PROGRAM----------------------------------*/
program: decl_list func_list KW_CONST KW_START TK_ASSGN '(' ')' ':' TK_INT DEL_ARROW '{' body '}' { 
/* We have a successful parse! 
  Check for any errors and generate output. 
*/
	if(yyerror_count==0) {
    // include the teaclib.h file
	  puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n\n", $1);
	  printf("%s\n\n", $2);
	  printf("int main() {\t\n%s\n} \n", $12);
	}
}
| decl_list KW_CONST KW_START TK_ASSGN '(' ')' ':' TK_INT DEL_ARROW '{' body '}' { 
/* We have a successful parse! 
  Check for any errors and generate output. 
*/
	if(yyerror_count==0) {
    // include the teaclib.h file
	  puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n\n", $1);
	  printf("int main() {\t\n%s\n} \n", $11);
	}
}
| func_list KW_CONST KW_START TK_ASSGN '(' ')' ':' TK_INT DEL_ARROW '{' body '}' { 
/* We have a successful parse! 
  Check for any errors and generate output. 
*/
	if(yyerror_count==0) {
    // include the teaclib.h file
	  puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("%s\n\n", $1);
	  printf("int main() {\t\n%s\n} \n", $11);
	}
}
|
KW_CONST KW_START TK_ASSGN '(' ')' ':' TK_INT DEL_ARROW '{' body '}' { 
/* We have a successful parse! 
  Check for any errors and generate output. 
*/
	if(yyerror_count==0) {
    // include the teaclib.h file
	  puts(c_prologue); 
	  printf("/* program */ \n\n");
	  printf("int main() {\t\n%s\n} \n", $10);
	}
}



/*---------------------------------------------------------------------------*/
;
/*-------------------- DECLARATIONS---------------------------------------------*/
decl_list: decl_list decl { $$ = template("%s %s\n", $1, $2); }
| decl { $$ = $1; }
;

decl: KW_CONST const_decl_body { $$ = template("const %s", $2); }
| KW_LET const_decl_body { $$ = template("%s", $2); }
;

const_decl_body: const_decl_list ':' type_spec ';' {  $$ = template("%s %s;", $3, $1); }
| const_decl_list type_spec ';' {  $$ = template("%s* %s;", $2,$1); }
;

const_decl_list: const_decl_list ',' const_decl_init { $$ = template("%s,%s", $1, $3 );}
| const_decl_init { $$ = $1; }
;

const_decl_init: const_decl_id { $$ = $1; }
| const_decl_id TK_ASSGN expr { $$ = template("%s=%s", $1, $3); }
; 

const_decl_id: IDENT { $$ = $1; } 
| IDENT '['expr']' { $$ = template("%s[%s]", $1,$3); }
| IDENT'['']' {$$ = template("%s",$1);}
;
/*-----------------------------------------------------------------------------*/

/*---------------------------DATA TYPES-----------------------------------------*/
type_spec:  TK_INT { $$ = "int"; }
| TK_REAL { $$ = "double"; }
| TK_STRING { $$ = "char*"; }
| TK_BOOL { $$ = "int"; }
;

/*------------------------------------------------------------------------------*/
/*-------------------------FUNCTION---------------------------------------------*/
func_list: func_decl { $$ = template("%s\n\n",$1); }
| func_decl ';' { $$ = template("%s\n\n",$1); }
| func_list func_decl { $$ = template("%s\n%s\n",$1,$2); }
| func_list func_decl';' { $$ = template("%s\n%s\n",$1,$2); }
;

func_decl: KW_CONST const_decl_id TK_ASSGN '(' arg_list ')' ':' type_spec DEL_ARROW '{' func_body '}' {
	$$ = template("%s %s(%s) {\n  %s\n}",  $8,$2,$5,$11); }
|	KW_CONST const_decl_id TK_ASSGN '(' arg_list ')' ':' '['']' type_spec DEL_ARROW '{' func_body '}' {
	$$ = template("%s* %s(%s) {\n  %s\n}",  $10,$2,$5,$13); }
;

arg_list: %empty  { $$ = template(""); }
|   const_decl_id':' type_spec { $$ = template("%s %s", $3, $1); }
|   arg_list ',' const_decl_id':' type_spec { $$ = template("%s , %s %s", $1, $5,$3); }
;

func_body: body { $$ = template("%s", $1); };
| decl_list { $$ = template("%s", $1); }
| decl_list body { $$ = template("%s %s", $1,$2); }



argu_call: %empty  { $$ = template(""); }
|   expr { $$ = template("%s", $1); }
|   argu_call ','  expr { $$ = template("%s,%s",$1,$3); }

;
/*------------------------EXPRESSION-------------------------------------------*/
expr: POSINT { $$ = $1; }
| REAL { $$ = $1; }
| STRING { $$ = $1; }
| const_decl_id { $$ = $1; }
| func_call { $$ = $1; }
| '(' expr ')' { $$ = template("(%s)", $2); }
| expr '+' expr { $$ = template("%s + %s", $1, $3); }
| expr '-' expr { $$ = template("%s - %s", $1, $3); }
| expr '*' expr { $$ = template("%s * %s", $1, $3); }
| expr '/' expr { $$ = template("%s / %s", $1, $3); }
| expr '%' expr { $$ = template("%s %% %s", $1, $3); }
| KW_TRUE { $$ = template("1"); }
| KW_FALSE { $$ = template("0"); }
| KW_NOT expr  { $$ = template("not %s", $2); }
| OP_NOT expr  { $$ = template("!s", $2); }
| '+' expr { $$ = template("+%s",  $2); }
| '-' expr { $$ = template("-%s",  $2); }
| logic_expression { $$ = template("%s",  $1); }
;

func_call: IDENT'('argu_call')' { $$ = template("%s(%s)",$1,$3); }
;

logic_expression: expr KW_AND expr { $$ = template("%s && %s", $1, $3); }
| expr KW_OR expr { $$ = template("%s || %s", $1, $3); }
| expr OP_AND expr { $$ = template("%s && %s", $1, $3); }
| expr OP_OR expr { $$ = template("%s || %s", $1, $3); }
| expr '=' expr { $$ = template("%s == %s", $1, $3); }
| expr OP_NOTEQUAL expr { $$ = template("%s != %s", $1, $3); }
| expr OP_LESSEQUAL expr { $$ = template("%s <= %s", $1, $3); }
| expr '<' expr { $$ = template("%s < %s", $1, $3); }
;

/*------------------------------------------------------------------------------*/

/*-----------------------COMMANDS-----------------------------------------------*/

command:';' { $$ = template(";\n"); }
| const_decl_id';' { $$ = template("%s;\n",$1); }
| const_decl_id TK_ASSGN expr ';' { $$ = template("\n%s = %s;", $1, $3); }
| const_decl_id '[' expr']' TK_ASSGN expr ';' { $$ = template("\n%s %s = %s;", $1,$3,$6);}
| func_call ';' { $$ = template("\n  %s;",$1); }
| return_statement ';' { $$ = template("%s;",$1); }
| while_loop { $$ = template("\n%s",$1); }
| if_statement { $$ = template("%s",$1); }
;


return_statement: KW_RETURN expr { $$ = template("\n  return %s",$2); }
| KW_RETURN  { $$ = template("\n  return "); };

while_loop: KW_WHILE expr  KW_LOOP body KW_POOL ';' { $$ = template("while (%s){\t%s}", $2,$4); };

if_statement: KW_IF expr KW_THEN body KW_FI ';' { $$ = template("if (%s){\t%s}", $2, $4); }
| KW_IF expr KW_THEN body KW_ELSE body KW_FI ';'{ $$ = template("if (%s){\t%s}\nelse{\t%s}", $2, $4, $6); };



command_list: command{ $$ = template("%s", $1); }
| command_list command { $$ = template("%s %s", $1, $2); }
;

body:  %empty { $$ = template(""); }
| decl_list { $$ = template("%s", $1); }
| command_list { $$ = template("%s", $1); }
| decl_list command_list { $$ = template("%s %s", $1,$2); }
;
/*------------------------------------------------------------------------------*/


%%
/*-----------------------MAIN---------------------------------------------------*/

int main () {
  if ( yyparse() == 0 ){
     printf("/*--------------Your program is syntactically correct!-------*/\n");
  }
  else{
    printf("/*-------------------------Rejected!---------------------------*/\n");
    printf("/* Unrecognized token %s in line %d: ",yytext,line_num);
  }

/*------------------------------------------------------------------------------*/
}