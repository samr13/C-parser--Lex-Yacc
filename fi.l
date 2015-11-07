%{
#include<stdio.h>

%}
con1 "if"
con2 "else if"
con3 "else"
%%
("void"|"int"|"float"|"char") {yylval=(int)yytext;return type;}

{con1} return IF;
{con2} return ELSEIF;
{con3} return ELSE;
"case" return CASE;
":" return COLON;
"break" return BREAK;
"default" return DEFAULT;
"switch" return SWI;
"while" return whi;
"<"|"<=" return lop;
"=" return equ;
[0-9]+ return no;
[a-z][a-z0-9]* {yylval=(int)yytext;return fname;}
";" {return semi;}
"," {return comma;}
"(" {return ope;}
")" {return clo;}
"{" {return seto;}
"}" {return setc;}
[a-z0-9]+ return any;
\n {}
%%


