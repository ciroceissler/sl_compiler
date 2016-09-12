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

else       return  ELSE       ;
if         return  IF         ;
functions  return  FUNCTIONS  ;
goto       return  GOTO       ;
return     return  RETURN     ;
types      return  TYPES      ;
var        return  VAR        ;
vars       return  VARS       ;
void       return  VOID       ;
while      return  WHILE      ;
labels     return  LABELS     ;

%{
/* symbols */
%}

"=="  return  EQUAL             ;
"!="  return  DIFFERENT         ;
"<"   return  LESS              ;
"<="  return  LESS_OR_EQUAL     ;
">"   return  GREATER           ;
">="  return  GREATER_OR_EQUAL  ;
"+"   return  PLUS              ;
"-"   return  MINUS             ;
"|"   return  OR                ;
"*"   return  MULTIPLY          ;
"/"   return  DIV               ;
"&"   return  AND               ;
"++"  return  UNARY             ;
"}"   return  CLOSE_BRACE       ;
"]"   return  CLOSE_BRACKET     ;
")"   return  CLOSE_PAREN       ;
":"   return  COLON             ;
","   return  COMMA             ;
"="   return  ASSIGN            ;
"!"   return  NOT               ;
"{"   return  OPEN_BRACE        ;
"["   return  OPEN_BRACKET      ;
"("   return  OPEN_PAREN        ;
";"   return  SEMI_COLON        ;

%{
/* identifiers and integers */
%}

{ID}      return  IDENTIFIER  ;
{DIGIT}+  return  INTEGER     ;

%{
/* others */
%}

<<EOF>>  return  END_OF_FILE   ;
.        return  LEXICAL_ERROR ;

%%

int yywrap() {
  return 1;
}
