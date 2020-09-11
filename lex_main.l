%{
#include"y.tab.h"
void yyerror(char *);
%}
%option yylineno
%%
if                               {return IF;}
readc                            {return READC;}
read                             {return READ;}
out                              {return OUT;}
outc                             {return OUTC;}
else                             {return ELSE;}
end                              {return END;}
while                            {return WHILE;}
string                           {return DECLRSTRING;}
char                             {return DECLRCHAR;}
int                              {return DECLRINT;}
","                              {return COMMA;}
";"                              {return SEMIC;}
[0-9]+                           {return NUMBER;}
[a-zA-Z][a-zA-Z0-9_]*            {return ID;}
[ \t\n]                          {;}
['][a-zA-Z0-9_]*[']              {return STRIN;}
.                                {return yytext[0];}
"=="                             {return EQLTO;}
"!="                             {return NETQLTO;}
"<="                             {return SMALLEREQ;}
">="                             {return BIGGEREQ;}
[/][*][a-zA-Z0-9_;,"'.=? \n\t]*[*][/]   {;}


%%
int yywrap(){
   return 1;
}