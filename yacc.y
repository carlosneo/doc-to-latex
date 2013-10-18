%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "lex.yy.c"
#include "functions.c"
FILE *arq; 
%}

%token ABRIRTEXTO
%token STYLE
%token FECHARTEXTO
%token ABRIRTEXTOH
%token FECHARTEXTOH
%token TAG
%token TITLE
%token AUTHOR
%token INSTITUTION
%token ADDRESS
%token EMAIL
%token ABSTRACT
%token RESUMO
%token SECTION
%token SUBSECTION
%token FPARAGRAPH
%token OPARAGRAPH
%token ABRIRFIGURE
%token FECHARFIGURE
%token TABULACAO
%token PONTUACAO
%token String
%token FECHARTITLE

%{
char buffer[1000];
char str1[1000];
%}

%%

Commands:
    Title | Author | Institution | Address | Email | Abstract | Resumo | Section | Subsection | 
    Fparagraph | Oparagraph | AbrirFigure | Nada | 

Title:

    | ABRIRTEXTO STYLE TITLE TAG Texto FECHARTITLE 
    
    {   printf("\nTag TITLE RECONHECIDA \n");
        fprintf(arq,"\\title{%s} \n", str1);
        zeroChar(str1);
    }Commands

Author: 

    | ABRIRTEXTO STYLE AUTHOR TAG Texto FECHARTEXTO 
    
    {   printf("Tag AUTHOR RECONHECIDA \n");
        fprintf(arq,"\\author{%s} \n", str1);
        zeroChar(str1);
    }Commands

Institution:

    | ABRIRTEXTO STYLE INSTITUTION TAG Texto FECHARTEXTO 
    
    {   printf("Tag INSTITUTION RECONHECIDA \n");
        fprintf(arq,"\\address{%s \n", str1);
        zeroChar(str1);
    }Commands
    
Address:

    | ABRIRTEXTO STYLE ADDRESS TAG Texto FECHARTEXTO 
    
    {   printf("Tag ADDRESS RECONHECIDA \n");
        fprintf(arq,"\\nextinstitute %s \n}", str1);
        zeroChar(str1);
    }Commands

Email:

    | ABRIRTEXTO STYLE ADDRESS TAG Texto FECHARTEXTO 
    
    {   printf("Tag ADDRESS EMAIL RECONHECIDA \n");
        fprintf(arq,"\\email{ %s} }\n\n", str1);
        zeroChar(str1);
    }Commands

Abstract:

	| ABRIRTEXTO STYLE ABSTRACT TAG Texto FECHARTEXTO

	{	printf("Tag ABSTRACT RECONHECIDA \n");
		fprintf(arq,"\\maketitle \n \\begin{abstract} %s \n \\end{abstract}\n\n", str1);
		zeroChar(str1);
	}Commands

Resumo:

	| ABRIRTEXTO STYLE RESUMO TAG Texto FECHARTEXTO

	{	printf("Tag RESUMO RECONHECIDA \n");
		fprintf(arq,"\\begin{resumo} %s \n\\end{resumo}\n\n", str1);
		zeroChar(str1);
	}Commands

Section:

	| ABRIRTEXTOH STYLE SECTION TAG Texto FECHARTEXTOH

	{	printf("Tag SECTION RECONHECIDA \n");
		fprintf(arq,"\\section{%s} \n", str1);
		zeroChar(str1);
	}Commands

Subsection:

	| ABRIRTEXTOH STYLE SUBSECTION TAG Texto FECHARTEXTOH

	{	printf("Tag SUBSECTION RECONHECIDA \n");
		fprintf(arq,"\\subsection{%s} \n", str1);
		zeroChar(str1);
	}Commands

Fparagraph:

	| ABRIRTEXTO STYLE FPARAGRAPH TAG Texto FECHARTEXTO

	{	printf("Tag FPARAGRAPH RECONHECIDA \n");
		fprintf(arq,"%s \n", str1);
		zeroChar(str1);
	}Commands

Oparagraph:

	| ABRIRTEXTO STYLE OPARAGRAPH TAG Texto FECHARTEXTO

	{	printf("Tag OPARAGRAPH RECONHECIDA \n");
		fprintf(arq,"\n %s \n", str1);
		zeroChar(str1);
	}Commands

AbrirFigure:

	| ABRIRFIGURE Texto FECHARFIGURE

	{	printf("Tag FIGURE RECONHECIDA \n");
		fprintf(arq, "\n\\begin{figure}[ht]\n");
		fprintf(arq, "\\centering\n");
		fprintf(arq,"\\caption{}\n");
		fprintf(arq,"\\includegraphics[width=.3\\textwidth]{%s} \n", str1);
		fprintf(arq,"\\end{figure}\n");
		zeroChar(str1);
	}Commands

Texto:

    String

    {	strcpy(buffer, yytext);
        strcat(str1, buffer);
    } 

    Texto  |

Nada:
	
	String

	{
		printf("valores nao utilizados\n");
	}Commands

	Nada | 

%%

int yywrap() { 
	return 0; 
}

int yyerror(char *s) {
	printf("%s\n",s);
}

int main(void) {
	
	arq = fopen("Docs/Result.tex","w");
     
    fflush(arq);		

    fprintf(arq, "\\documentclass[12pt]{article}\n");
    fprintf(arq, "\\usepackage[utf8]{inputenc} \n");
    fprintf(arq, "\\usepackage{sbc-template} \n");
    fprintf(arq, "\\usepackage{graphicx, url} \n");
    fprintf(arq, "\\begin{document}\n");
    
	yyparse();

	fprintf(arq, "\\nocite{*} \n");
	fprintf(arq, "\\bibliographystyle{sbc} \n");
	fprintf(arq, "\\bibliography{sbc-template} \n");
    fprintf(arq, "\\end{document}");

    fclose(arq);
    }
