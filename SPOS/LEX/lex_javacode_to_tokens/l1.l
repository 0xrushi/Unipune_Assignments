%option noyywrap
%{
	#include<stdio.h>
	#include<string.h>
	
	char iden_array[20][20];
	char keyword_array[20][20];
	char num_array[20][20];
	int icnt=0,ncnt=0,kcnt=0;
%}
letter [A-Za-z]
%%
[+-]?[0-9]+(.[0-9]+)?([eE][-+][0-9]+)? 	{
	strcpy(num_array[ncnt],yytext);
	ncnt++;
}
("void"|"main"|"char"|"import"|"int"|"float"|"class"|"double"|"long"|"static"|"public"|"String"|"java"|"io"|"util") {
		//printf("%s is keyword ",yytext);
		strcpy(keyword_array[kcnt],yytext);
		kcnt++;
	}
[a-zA-Z_$]([0-9a-zA-Z_$]+)? {
//	printf("%s is identifier ",yytext);
	strcpy(iden_array[icnt],yytext);
	icnt++;
}
%%
main() 
{
int i=0;
yyin=fopen("testjavafile.txt","r");
FILE *f = fopen("output.txt", "w");
yylex();
	fprintf(f,"\nSrno  keyword\n");
	
	for(i=0;i<kcnt;i++){
		fprintf(f,"%d\t%s\n",i+1,keyword_array[i]);
	}

	fprintf(f,"Srno  identifier\n");
	i=0;
	for(i=0;i<icnt;i++){
		fprintf(f,"%d\t%s\n",i+1,iden_array[i]);
	}

	fprintf(f,"Srno  number\n");
	i=0;
	for(i=0;i<ncnt;i++){
		fprintf(f,"%d\t%s\n",i+1,num_array[i]);
	}
}