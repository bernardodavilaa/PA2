%option noyywrap

%{
#include <stdio.h>
#include <string.h>
#include "cool-parse.h"
#include "stringtab.h"
#include "utilities.h"

#define cool_yytext yytext
extern int curr_lineno;

/* Buffer para construir strings */
static char string_buf[1025];
static char *string_buf_ptr;
static int string_buf_len;

/* Contador para comentarios aninhados */
static int comment_depth = 0;

/* Flag para indicar erro de null character em string */
static int string_contains_null = 0;

/* Funcao auxiliar para adicionar caractere ao buffer */
static void add_to_string(char c) {
    if (string_buf_len >= 1024) {
        return; /* String muito longa, sera reportado */
    }
    *string_buf_ptr++ = c;
    string_buf_len++;
}
%}

%x COMMENT STRING

%%

 /* Espacos em branco */
[ \t\f\r\v]+    ;

 /* Nova linha */
\n              { curr_lineno++; }

 /* Comentario de linha */
"--".*          ;

 /* Inicio de comentario */
"(*"            { comment_depth = 1; BEGIN(COMMENT); }

 /* Comentario nao balanceado */
"*)"            { 
                  cool_yylval.error_msg = "Unmatched *)";
                  return ERROR;
                }

<COMMENT>{
    "(*"        { comment_depth++; }
    "*)"        { 
                  comment_depth--;
                  if (comment_depth == 0) {
                      BEGIN(INITIAL);
                  }
                }
    \n          { curr_lineno++; }
    <<EOF>>     {
                  BEGIN(INITIAL);
                  cool_yylval.error_msg = "EOF in comment";
                  return ERROR;
                }
    .           ;
}

 /* Palavras-chave - case insensitive exceto true/false */
(?i:class)      { return CLASS; }
(?i:else)       { return ELSE; }
(?i:fi)         { return FI; }
(?i:if)         { return IF; }
(?i:in)         { return IN; }
(?i:inherits)   { return INHERITS; }
(?i:isvoid)     { return ISVOID; }
(?i:let)        { return LET; }
(?i:loop)       { return LOOP; }
(?i:pool)       { return POOL; }
(?i:then)       { return THEN; }
(?i:while)      { return WHILE; }
(?i:case)       { return CASE; }
(?i:esac)       { return ESAC; }
(?i:new)        { return NEW; }
(?i:of)         { return OF; }
(?i:not)        { return NOT; }

t(?i:rue)       { cool_yylval.boolean = 1; return BOOL_CONST; }
f(?i:alse)      { cool_yylval.boolean = 0; return BOOL_CONST; }

 /* Operadores de dois caracteres */
"<-"            { return ASSIGN; }
"=>"            { return DARROW; }
"<="            { return LE; }

 /* Operadores de um caractere */
"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"="             { return '='; }
"<"             { return '<'; }
"~"             { return '~'; }

 /* Delimitadores */
"."             { return '.'; }
","             { return ','; }
";"             { return ';'; }
":"             { return ':'; }
"("             { return '('; }
")"             { return ')'; }
"{"             { return '{'; }
"}"             { return '}'; }
"@"             { return '@'; }

 /* Inteiros */
[0-9]+          {
                  cool_yylval.symbol = inttable.add_string(yytext);
                  return INT_CONST;
                }

 /* Identificadores de tipo (comecam com maiuscula) */
[A-Z][A-Za-z0-9_]* {
                  cool_yylval.symbol = idtable.add_string(yytext);
                  return TYPEID;
                }

 /* Identificadores de objeto (comecam com minuscula) */
[a-z][A-Za-z0-9_]* {
                  cool_yylval.symbol = idtable.add_string(yytext);
                  return OBJECTID;
                }

 /* Strings */
\"              {
                  string_buf_ptr = string_buf;
                  string_buf_len = 0;
                  string_contains_null = 0;
                  BEGIN(STRING);
                }

<STRING>{
    \"          {
                  BEGIN(INITIAL);
                  if (string_contains_null) {
                      cool_yylval.error_msg = "String contains null character";
                      return ERROR;
                  }
                  if (string_buf_len >= 1024) {
                      cool_yylval.error_msg = "String constant too long";
                      return ERROR;
                  }
                  *string_buf_ptr = '\0';
                  cool_yylval.symbol = stringtable.add_string(string_buf);
                  return STR_CONST;
                }
    
    \n          {
                  BEGIN(INITIAL);
                  curr_lineno++;
                  string_contains_null = 0;
                  cool_yylval.error_msg = "Unterminated string constant";
                  return ERROR;
                }
    
    <<EOF>>     {
                  BEGIN(INITIAL);
                  string_contains_null = 0;
                  cool_yylval.error_msg = "EOF in string constant";
                  return ERROR;
                }
    
    \0          {
                  string_contains_null = 1;
                }
    
    \\n         { add_to_string('\n'); }
    \\t         { add_to_string('\t'); }
    \\b         { add_to_string('\b'); }
    \\f         { add_to_string('\f'); }
    \\0         { add_to_string('0'); }
    \\\n        { curr_lineno++; add_to_string('\n'); }
    \\.         { add_to_string(yytext[1]); }
    
    [^\\\n\"\0]+  {
                  char *yptr = yytext;
                  while (*yptr) {
                      add_to_string(*yptr++);
                  }
                }
}

 /* Caracteres invalidos */
.               {
                  cool_yylval.error_msg = yytext;
                  return ERROR;
                }

%%

int cool_yylex() {
    return yylex();
}