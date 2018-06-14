%{
    #include <stdio.h>
    extern FILE *yyin;
%}
%token KWD IDN SEM EQU NUM COMMA DOLLAR SQBKT NEW
%%
expn: stmt DOLLAR expn {printf("expn found\n");}
|stmt DOLLAR
;
stmt: kwd idn sem {printf("stmt found\n");}
|kwd idn sqbkt sqbkt equ NEW kwd sqbkt NUM SQBKT sem
|kwd idn sqbkt sqbkt sem {}
;
kwd: KWD {printf("kwd found\n");}
;
idn: IDN {printf("iden found\n");}
| idn EQU NUM
| idn COMMA IDN
|idn SQBKT SQBKT
;
sem: SEM {printf("sem found\n");}
;
equ:EQU 
;
sqbkt: SQBKT{printf("sqbkt found");}
;
%%
int main(){
    yyin=fopen("abc.txt","r");
	yyparse();
    return 0;
}

void yyerror(char *s)
{
	printf("Error: %s",s);	
}
