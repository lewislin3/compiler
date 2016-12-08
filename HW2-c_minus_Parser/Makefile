all: 
	yacc -d -v yacctemplate.y
	lex lextemplate.l
	gcc -o parser lex.yy.c y.tab.c -ly -lfl -lbsd

clean:
	rm -f parser