%{
	#include<stdio.h>
	extern FILE *yyin;
	void yyerror(char *s);
	int yylex();
%}
%token VERB1 ADJ1 ADVERB1 NOUN1 PRONOUN1 CONJ1
%%
S1: S1 S2 '#'
|S2 '#'
;
S2:simple  {printf("Simple sentence found\n");}
|compound  {printf("Compound sentence found\n");}
;
simple:obj_noun verb_v  sub_noun
;
obj_noun:NOUN1 {} 
| PRONOUN1 {}
;
verb_v:VERB1 {}
;
sub_noun:NOUN1 {}
|ADJ1 sub_noun {}
|sub_noun ADJ1 {}
;
compound : simple CONJ1 simple {printf("Compound statment is found\n");}
|compound CONJ1 compound {}
%%
int main()
{
	char c;
	yyin = fopen("fileTxt.txt","r");
	
	do
	{
		yyparse();
	}while(!feof(yyin));
	return 0;
}

void yyerror(char *s)
{
	printf("%s",s);
}
