%{
#include <stdio.h>
#include <string.h>
#include "yacc.tab.h"
#undef YYLMAX
#define YYLMAX 10000
%}

/* basicos */
DIGITOS         [0-9]+
LETRA		[A-Za-záÉçãêü\)\(@\{\}/]+
ASPAS           [\“\”\’\']+

/*  tags */
ABRIRTEXTO      "<text:p "
ABRIRTEXTOH     "<text:h "
STYLE		"text:style-name="
FECHARTAG       "\\>"
TAG		        ">"
FECHARTEXTO     "</text:p>"
FECHARTEXTOH    "</text:h>"

/*  extra texto */
PULARLINHA 	[\n]
PARAGRAFO 	[\t]
ESPACO 		[" "]
PONTUACAO	[–.:,-\<=\\>\>\\n\#]+

/*  identificadores */
TITLE		"\"P2\""
AUTHOR          "\"SBC_3a_author_28_s_29_\""
INSTITUTION     "\"SBC_3a_institution\""
ADDRESS		"\"SBC_3a_address\""
EMAIL		"\"SBC_3a_email\""
ABSTRACT	"\"SBC_3a_abstract\""
RESUMO          "\"SBC_3a_resumo\""
SECTION         "\"SBC_3a_title_3a_1\""
SUBSECTION      "\"SBC_3a_title_3a_2\""
FPARAGRAPH      "\"SBC_3a_paragraph_3a_first\""
OPARAGRAPH      "\"SBC_3a_paragraph\""
ABRIRFIGURE     "draw:image xlink:href=\""
FECHARFIGURE    "\" xlink:type=\"simple\" xlink:show=\"embed\" xlink:actuate=\"onLoad\"/>"
FECHARTITLE    "\<text:note text:id=\"ftn1\" text:note-class=\"footnote\">"

String		    {LETRA}|{DIGITOS}|{PONTUACAO}|{PARAGRAFO}|{ESPACO}|{ASPAS}

%%

{ABRIRTEXTO}       {
    return ABRIRTEXTO;
}
{STYLE}       {
    return STYLE;
}
{FECHARTEXTO}       {
    return FECHARTEXTO;
}
{ABRIRTEXTOH}       {
    return ABRIRTEXTOH;
}
{FECHARTEXTOH}       {
    return FECHARTEXTOH;
}
{TAG}       {
    return TAG;
}
{TITLE}   {
    return TITLE;
}
{AUTHOR}   {
    return AUTHOR;
}
{INSTITUTION}   {
    return INSTITUTION;
}
{ADDRESS}   {
    return ADDRESS;
}
{EMAIL}   {
    return EMAIL;
}
{ABSTRACT}   {
    return ABSTRACT;
}
{RESUMO}   {
    return RESUMO;
}
{SECTION}   {
    return SECTION;
}
{SUBSECTION}   {
    return SUBSECTION;
}
{FPARAGRAPH}   {
    return FPARAGRAPH;
}
{OPARAGRAPH}   {
    return OPARAGRAPH;
}
{ABRIRFIGURE}   {
    return ABRIRFIGURE;
}
{FECHARFIGURE}   {
    return FECHARFIGURE;
}
{String}       {
    return String;
}
{FECHARTITLE}       {
    return FECHARTITLE;
}
%%
