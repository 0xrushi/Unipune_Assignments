%{
    #include <stdio.h>
    extern FILE *yyin;
    void yyerror(char *s);
    int yylex();
%}
%token  VERB1 NOUN1 PRONOUN1 ADJECTIVE1 ADVERB1 CONJUNCTION1 HASH
%%
state:compound HASH {}
|state simple HASH {}
|simple HASH  {}
;
compound:simple CONJUNCTION1 simple {printf("Compound Sentence Found");}
|compound CONJUNCTION1 compound {}
;
simple: object_noun VERB1 sub_noun
;
object_noun:NOUN1 {}
|PRONOUN1 {}
;
sub_noun:NOUN1 {}
|ADJECTIVE1 sub_noun {}
|sub_noun ADJECTIVE1 {}
;
%%
int main(){
    yyin=fopen("../fileTxt.txt","r");
    
    do{
		yyparse();
	}while(!feof(yyin));
	return 0;}

void yyerror(char *s){
    printf ("Error %s ",s);
}