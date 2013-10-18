CC = gcc
FLEX = flex
BISON = bison
BFLAGS = -d -v
DELETE = DEL

all: 
	${BISON} ${BFLAGS} yacc.y
	${FLEX} lex.l
	${CC} yacc.tab.c

runWin:
	a.exe

run:
	./a.out
	
cleanWin:
	${DELETE} yacc.output
	${DELETE} yacc.tab.c
	${DELETE} yacc.tab.h
	${DELETE} lex.yy.c
	${DELETE} Result.tex
	${DELETE} a.exe
	
clean:
	rm yacc.output
	rm yacc.tab.c
	rm yacc.tab.h
	rm lex.yy.c
	rm a.out
	rm Docs/Result.tex
