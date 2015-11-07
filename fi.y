%{
#include<stdio.h>

char buf[50][50],buff[80],temp[50],ptype[10][10],dtype[10][10],ctype[10][10],buf1[50][50],buf2[50][50],dec[60],cond[70],one[50][30],two[50][20];
int np=0,nd=0,nc=0,a=0,l=0,m=0,j=0,n=0,y=0,f=0,b=0,p=0,d=0,c=0,p1=0,d1=0,c1=0,z=0,i,z,r,vt,k,g1,g2,flag,count,cas=0,forr=0;
%}
%token fname,semi,comma,ope,clo,seto,setc,type,whi,lop,no,equ,any,IF,ELSE,ELSEIF,SWI,CASE,BREAK,COLON,any,DEFAULT
%%
start: pro call start     
       |
       defn call start
       |
       pro defn call start
	|
       ini who start
       |
       IF COM SET start SET start {flag=1;}
       |
       IF COM SET SET SECOND THIRD start {flag=1;}
       |
       SWI ope fname clo SET CON SET start { 
	if(cas==1)
		printf("\nValid switch\n");
	if(cas==2)
		printf("\nBreak missing\n");
	if(cas==0) 
		printf("\nInvalid switch\n");
	if(cas==3) 
		printf("\nSwitch without case\n");
	}
       |
       ;

CON:CASE anyth COLON SET BREAK semi SET CON {cas=1;}
    | 
    CASE anyth COLON SET SET CON {cas=2;}
    |
	{cas=3;}
    ;
anyth: fname
       |
       no;
SECOND: ELSEIF COM SET SET
        |
        ELSEIF COM SET start SET
        |
         ;
       
THIRD: ELSE SET
        |
       ELSE SET start SET
        |
        ;

SET : seto
       |
       setc
       |
       ;
COM: ope fname lop fname clo;   

ini:
       type fname equ no semi 
       {
          j=0;
          r=0;z=0;a=0;n=0;
          strcpy(dec,(char*)$2);
          while(dec[j]!='=')
          {
          buf1[r][n++]=dec[j];
          j++;
          }
         
          j++;
         while(dec[j]!=';')
          {
	buf2[z][a++]=dec[j];
	j++;
	}	
       
          r++;z++;
       };
set: seto
      |
      setc
      |
      ;


who:
       whi ope wen {if(forr!=1) printf("\nValid loop\n");}
       |
       ;
wen: fname lop no clo set fname set 
      {               
          j=0;
          r=0;z=0;a=0;n=0;
          strcpy(cond,(char*)$1);
        while(cond[j]!='<')
          {
          one[g1][n++]=cond[j];
          j++;
          }
         j++;
        while(cond[j]!=')')
          {
          two[g2][a++]=cond[j];
          j++;
          }
       
for(k=0;k<=r;k++)
{
  for(vt=0;vt<=g1;vt++)
  {
	if(strcmp(buf1[k],one[vt])==0)
	{
	   if(strcmp(buf2[k],two[vt])<=0)		
		printf("\nInvalid Loop\n");
		forr=1;	  	   
		break;
	}
  }
}

}
|
fname clo
|
;
    
pro: type fname ope pen clo semi 
{
strcpy(buff,(char*)$2);
j=0;
while(buff[j]!='(')
{
buf[m][n++]=buff[j];
j++;
}

m++;

	
}       
;
pen: type fname pen2
     {  np++;
	strcpy(buff,(char*)$1);
	j=0;p=0;
	while(buff[j]!=' ')
	{
	ptype[p1][p++]=buff[j];
	j++;	
	}
	p1++;
	
      }
     |
     ;
pen2:comma pen
      |
      ;

defn:type fname ope den clo seto setc 
{
strcpy(buff,(char*)$2);
j=0;
while(buff[j]!='(')
{
buf[m][n++]=buff[j];
j++;
}

m++;

}
;

den: type fname den2
       {
	nd++;
	strcpy(buff,(char*)$1);
	j=0;d=0;
	while(buff[j]!=' ')
	{
	dtype[d1][d++]=buff[j];
	j++;	
	}
	d1++;
	
      }
     |  
     ;
den2:comma den
     |
     ;

call: fname ope cen clo semi
     {
strcpy(buff,(char*)$1);
j=0;
while(buff[j]!='(')
{
temp[f++]=buff[j];
j++;
}

}
;

cen: fname cen2
       {
	nc++;
      }	
     |
     ;
cen2:comma cen
     |
     ;
%%
#include<string.h>
#include "lex.yy.c"
main()
{
yyin=fopen("fi.c","r");
yyparse();
b=0;
while(b<=m)
{
  if(strcmp(temp,buf[b])==0)
	{
	
	y=1;
	break;
	}
 b++;
}
if(y==1)
 printf("\nfunction name match\n");
else 
 printf("\nfunction name not match\n");




if((np==nd)&&(nd==nc))
 printf("\nno. of parameter match\n");
else
 printf("\nno of parameter mismatch\n");




j=(np>nd)?np:nd;

for(i=0;i<j;i++)
{
if(strcmp(ptype[i],dtype[i])==0)
	z++;
	else
	printf("parameter type mismatch at %d\n",i+1);
}
if(z==j)
 printf("all parameter type match\n");

printf("\npro par---defn par\n");
for(i=0;i<j;i++)
{
	printf("%s------%s\n",ptype[i],dtype[i]);
	
	
}


}

yyerror()
{
printf("\n Syntax Error");
} 
yywrap()
{
}
