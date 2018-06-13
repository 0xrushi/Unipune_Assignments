%option noyywrap
%{
	#include<stdio.h>
	#include<string.h>
	
	int cc=0;
	int lc=0;
	int wc=0,sc=0,wlen;
	char buf[200];
	char sub[10];
	int l1,l2;
%}

letter [A-Za-z]
%%
[A-Za-z]+ 	{
	wlen=strlen(yytext);
	cc=cc+wlen;
	wc++;
	strcat(buf,yytext);
}
(\n) 	{
	lc++;				//linecount
}
[" "] {
	sc++;				//spacecount
}

%%
main() 
{
int i=0,count=0,count1=0,j=0;
yyin=fopen("testjavafile.txt","r");
yylex();
printf("Word Count %d\n",wc);
printf("Char Count %d\n",cc);
printf("Line Count %d\n",lc);
printf("Space Count %d\n",sc);

}
/*
l1 = strlen(buf);
printf("Enter character or word to count ");
scanf("%[^\n]%*c", sub);
l2 = strlen(sub);
printf("buf is %s",buf);

for (i = 0; i < l1;){
j = 0;
count = 0;
while (buf[i] == sub[j]){
    count++;
    i++;
    j++;
}

if (count == l2){
    count1++;                                   
    count = 0;
}
else
	{i++;}

} 

printf("Custom Count %d\n",count1);   
*/