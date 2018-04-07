%option
%{
#include<stdio.h>
#include<string.h>
#include "y.tab.h"
    enum {LOOKUP,VERB,ADVERB,ADJ,NOUN,PRONOUN,CONJ};

    void add_tab(int type,char *word);
    int lookup_tab(char* word);
    int state = 0;
    static int count=0;
    struct word_type
    {
        int type;
        char word[50];
    };
    struct word_type obj[50];
%}

%%
\n {state = LOOKUP;}
^verb {state = VERB;}
^adverb {state = ADVERB;}
^adjective {state = ADJ;}
^noun {state = NOUN;}
^pronoun {state = PRONOUN;}
^conjunction {state = CONJ;}
"#" {return yytext[0];}
[a-z]+ {
    if(state!=LOOKUP)
    {

        add_tab(state,yytext);

    }
    else
    {

        switch(lookup_tab(yytext))
        {
        case VERB:
            printf("Verb is Found\n");
            return VERB1;
            break;

        case NOUN:
            printf("Noun is Found\n");
            return NOUN1;
            break;

        case ADJ:
            printf("Adjective is Found\n");
            return ADJ1;
            break;

        case PRONOUN:
            printf("Pronoun is Found\n");
            return PRONOUN1;
            break;
        case CONJ:
        	printf("Conjunction is found\n");
        	return CONJ1;
        	break;

        }
    }
}

%%



void add_tab(int type,char *word)
{
    if(lookup_tab(word)!=-1)
        printf("Word already present");
    else {

        obj[count].type = type;
        strcpy(obj[count].word,word);
        count++;
        printf("word added %s \n",word);
    }

}
void display_tab()
{
    int j;
    for(j=0; j<count; j++)
    {
        printf("%d\t\t%s",obj[j].type,obj[j].word);
        printf("\n");
    }
}

int lookup_tab(char* word)
{
    int j;

    for(j=0; j<count; j++)
    {
        if(!strcmp(obj[j].word,word))
        {

            return obj[j].type;
        }
    }
    return -1;

}
int yywrap()
{
    return 1;
}

