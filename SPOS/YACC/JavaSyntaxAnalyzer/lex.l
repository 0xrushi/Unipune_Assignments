%option noyywrap
%{
    #include<stdio.h>
    #include "y.tab.h"
%}
letter [a-zA-Z]
digit [0-9]
%%
int|String      {return KWD;}
"new"           {return NEW;}
{letter}+       {return IDN;}
"="             {return EQU;}    
{digit}+        {return NUM;}
","             {return COMMA;}
";"             {return SEM;}
"$"            {return DOLLAR;}
"["|"]"      {printf("sqbkt");
    return SQBKT;}
%%
