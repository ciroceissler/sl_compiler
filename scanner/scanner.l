/***********************************************/
/* project     : Simple Language               */
/*                                             */
/* description : scanner for a simple language */
/* author      : Ciro Luiz Araujo Ceissler     */
/* RA          : 108786                        */
/***********************************************/

/* defintions */

%{
/* contains declarations and token symbols */
#include "parser.h"
%}

DIGIT    [0-9]
ID       [a-z][a-z0-9]*

  int line_num = 1;

%x comment
%%

%{ 
/* token specifications */
%}

%{
/* comments */
%}

"/*"  BEGIN(comment);
<comment>[^*\n]*        /* eat anything that's not a '*' */
<comment>"*"+[^*/\n]*   /* eat up '*'s not followed by '/'s */
<comment>\n             ++line_num;
<comment><<EOF>>        return UNFINISHED_COMMENT;
<comment>"*"+"/"        BEGIN(INITIAL);

"//".* { /* ignore comments */ }

%{
/* increment line number */
%}

\n ++line_num;

%{
/* Blanks etc */
%}

[ \t]  /* ignore whitespace */

%{
/* reserved words */
%}

else       printf("%d  %s\n",  ELSE       ,  yytext);
if         printf("%d  %s\n",  IF         ,  yytext);
functions  printf("%d  %s\n",  FUNCTIONS  ,  yytext);
goto       printf("%d  %s\n",  GOTO       ,  yytext);
return     printf("%d  %s\n",  RETURN     ,  yytext);
types      printf("%d  %s\n",  TYPES      ,  yytext);
var        printf("%d  %s\n",  VAR        ,  yytext);
vars       printf("%d  %s\n",  VARS       ,  yytext);
void       printf("%d  %s\n",  VOID       ,  yytext);
while      printf("%d  %s\n",  WHILE      ,  yytext);
labels     printf("%d  %s\n",  LABELS     ,  yytext);

%{
/* symbols */
%}

"=="  printf("%d  %s\n",  EQUAL             ,  yytext);
"!="  printf("%d  %s\n",  DIFFERENT         ,  yytext);
"<"   printf("%d  %s\n",  LESS              ,  yytext);
"<="  printf("%d  %s\n",  LESS_OR_EQUAL     ,  yytext);
">"   printf("%d  %s\n",  GREATER           ,  yytext);
">="  printf("%d  %s\n",  GREATER_OR_EQUAL  ,  yytext);
"+"   printf("%d  %s\n",  PLUS              ,  yytext);
"-"   printf("%d  %s\n",  MINUS             ,  yytext);
"|"   printf("%d  %s\n",  OR                ,  yytext);
"*"   printf("%d  %s\n",  MULTIPLY          ,  yytext);
"/"   printf("%d  %s\n",  DIV               ,  yytext);
"&"   printf("%d  %s\n",  AND               ,  yytext);
"++"  printf("%d  %s\n",  UNARY             ,  yytext);
"}"   printf("%d  %s\n",  CLOSE_BRACE       ,  yytext);
"]"   printf("%d  %s\n",  CLOSE_BRACKET     ,  yytext);
")"   printf("%d  %s\n",  CLOSE_PAREN       ,  yytext);
":"   printf("%d  %s\n",  COLON             ,  yytext);
","   printf("%d  %s\n",  COMMA             ,  yytext);
"="   printf("%d  %s\n",  ASSIGN            ,  yytext);
"!"   printf("%d  %s\n",  NOT               ,  yytext);
"{"   printf("%d  %s\n",  OPEN_BRACE        ,  yytext);
"["   printf("%d  %s\n",  OPEN_BRACKET      ,  yytext);
"("   printf("%d  %s\n",  OPEN_PAREN        ,  yytext);
";"   printf("%d  %s\n",  SEMI_COLON        ,  yytext);

%{
/* identifiers and integers */
%}

{ID}      printf("%d  %s\n",  IDENTIFIER  ,  yytext);
{DIGIT}+  printf("%d  %s\n",  INTEGER     ,  yytext);

%{
/* others */
%}

.        return  LEXICAL_ERROR;
<<EOF>>  return  END_OF_FILE;

%%

int yywrap() {
  return 1;
}
