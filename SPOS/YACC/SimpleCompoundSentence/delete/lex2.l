%option
%{
#include "y.tab.h"
#include<stdio.h>
#include<string.h>

struct word_type{
    int type;
    char word[50];
};

struct word_type obj[50];

static int state;
static int count=0;

void add_tab(int type,char * word);
int lookup_tab(char * word);
enum {LOOKUP,VERB,NOUN,PRONOUN,CONJUNCTION,ADVERB,ADJECTIVE};

%}
%%

\n {state=LOOKUP;}
"#" {return HASH;}
^verb {state=VERB;}
^noun {state=NOUN;}
^pronoun {state=PRONOUN;}
^adverb {state=ADVERB;}
^adjective {state=ADJECTIVE;}
^conjunction {state=CONJUNCTION;}

[a-z]+ {
    if(state!=LOOKUP){
        add_tab(state,yytext);
    }
    else{
        switch(lookup_tab(yytext)){
            case VERB:
                printf("Verb is Found\n");
                return VERB1;
                break;
            case NOUN:
                printf("Noun is Found\n");
                return NOUN1;
                break;
            case PRONOUN:
                printf("Pronoun is Found\n");
                return PRONOUN1;
                break;
            case ADJECTIVE:
                printf("adjective is Found\n");
                return ADJECTIVE1;
                break;
            case ADVERB:
                printf("Adverb is Found\n");
                return ADVERB1;
                break;
            case CONJUNCTION:
                printf("Verb is Found\n");
                return CONJUNCTION1;
                break;
        }
    }
}

%%

void add_tab(int type,char *word){
    if(lookup_tab(word)!=-1)
        printf("word already present \n");
    else{
        obj[count].type=type;
        strcpy(obj[count].word,word);
        count++;
        printf("word added %s \n",word);
    }
}

int lookup_tab(char *word){
    int j=0;
    for (j=0;j<count;j++){
        if(!strcmp(obj[j].word,word)){
            return obj[j].type;
        }
    }
    return -1;
}

int yywrap(){
    return 1;
}

