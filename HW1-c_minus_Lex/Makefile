all: lextemplate.l
	lex lextemplate.l
	gcc -o scanner lex.yy.c -lfl 

clean:
	rm -f scanner