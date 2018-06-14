%option noyywrap
%{
#include<stdio.h>
#include "y.tab.h"
%}
letter [a-zA-Z]
digit [0-9]
%%
"int"|"char"|"String"|"float"|"double"|"byte"		{return DT;}
"new"							{return NEW;}
[a-zA-Z][a-zA-Z0-9_]*			{return IDN;}
";"								{return SEM;}
","								{return COMMA;}
"\n"							{return yytext[0];}
"="								{return EQU;}
{digit}+(.{digit})?				{return DIGIT;}
"["|"]"							{return BRACK;}
"\""								{return DOUBLE_Q;}
"("|")"							{return ROUND_B;}
%%
