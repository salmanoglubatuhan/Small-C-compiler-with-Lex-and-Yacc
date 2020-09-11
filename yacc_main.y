%{
#include<stdio.h>
#include<stdlib.h>
#include <string.h>
extern int yylineno;
int yylex(void);
void yyerror(char *);
%}

%token NUMBER ID DECLRINT OUT OUTC READ READC STRIN DECLRSTRING DECLRCHAR COMMA SEMIC IF ELSE END EQLTO NETQLTO SMALLEREQ BIGGEREQ WHILE
%left '+' '-'
%left '*' '/'

%%
main:
    program {printf("valid expression\n");} 
;
program:
    stmt
    |
    program stmt | ifelsestmt | program ifelsestmt  
;
ifelsestmt: IF '(' cond ')'
                stmt
            END
            |
            IF '(' cond ')'
                stmt
            END
            ELSE
                stmt
            END 
            |
            IF '(' cond ')'
                ifelsestmt
            END
            |
            IF '(' cond ')'
                ifelsestmt
            END
            ELSE
                ifelsestmt
            END 
            |
            IF '(' cond ')'
                stmt
            END
            ELSE
                ifelsestmt
            END 
            |
            IF '(' cond ')'
                ifelsestmt
            END
            ELSE
                stmt
            END 
            |
            WHILE '(' cond ')'
                stmt
            END
            |
            WHILE '(' cond ')'
                ifelsestmt
            END
            | 
            ifelsestmt ifelsestmt
;

stmt: exp SEMIC | assgn SEMIC | declr SEMIC  | readout SEMIC 
;

cond: exp '<' exp | exp '>' exp | exp EQLTO exp | exp NETQLTO exp | exp SMALLEREQ exp | exp BIGGEREQ exp | exp 
        ;

declr: DECLRINT strl | DECLRCHAR strl | DECLRSTRING ID '=' STRIN 
;
readout: readc| read | out | outc
;
readc: READC'(' ID ')'
;
read: READ'(' NUMBER ')'
;
out: OUT'(' NUMBER ')'
;
outc: OUTC'(' ID ')'

strl: strl COMMA ID|ID | assgn | strl COMMA assgn
;

assgn: temp '=' exp
;

exp: exp '+' exp | exp '-' exp | exp '*' exp | exp '/' exp | '(' exp ')' | NUMBER  | ID |
;

temp: NUMBER | ID
;


%%

void yyerror(char  *msg)
{
    fprintf(stderr, "line %d: %s\n", yylineno, msg);
    printf("Invalid expression\n",msg);
    exit(0);
}

int main()
{
 printf("enter the expression: \n");
 yyparse();
}