%{
#include<stdio.h>
extern FILE *yyin;
%}
%token IDN DT SEM COMMA EQU DIGIT BRACK NEW DOUBLE_Q ROUND_B
%%
exp : start '\n' exp
| start '\n'					{printf("Multiline matched\n");}
;
start : dt idn sem			{printf("valid\n");}
;
dt : DT						{printf("Data type matched\n");}
| dt BRACK					{printf("Data type and bracket mached\n");}
;
idn : IDN					{printf("Identifire matched\n");}
| idn IDN					{printf("Identifire and identifire matched\n");}
| idn COMMA IDN			{printf("Identifire and comma matched\n");}
| idn EQU DIGIT				{printf("Equal and digit matched\n");}
| idn BRACK					{printf("array diclaration bracket matched\n");}
| idn EQU NEW				{printf("Equal and new matched\n");}
| idn DT						{printf("identire and data type matched\n");}
| idn DIGIT					{printf("identire and digit matched\n");}
| idn EQU DOUBLE_Q		{printf("Equal and double quotes matched\n");}
| idn DOUBLE_Q			{printf("identifire and double qoutes matched\n");}
| idn ROUND_B				{printf("Identifire and round bracket matched\n");}
;
sem : SEM					{printf("Semicolon matched\n");}
;
%%
void main()
{
	yyin=fopen("abc.txt","r");
	yyparse();
}
int yyerror(char *s)
{
	printf("Error: %s",s);	
}
