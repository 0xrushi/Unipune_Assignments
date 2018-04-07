lex lexL2.l
yacc -d lexL2.y
gcc lex.yy.c y.tab.c
