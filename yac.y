%{
	#include <stdio.h>
	#include<stdlib.h>
    extern int yylex();
    void yyerror(char *);
%}

%union {
	char c;
	char *s;
	int d;
}


%token V F NOT AND
%token SI ENTONCES FIN PARA HACER A
%token DECLARACIONES INSTRUCCIONES
%token LOGICO ENTERO REAL COMPLEJO


%left '+' '-' '*' '/'
%left '>' '<' GR LS
%left OR AND EQ NEQ
%right '=' '!'

%%

programa: declaraciones instrucciones
        ;

declaraciones: DECLARACIONES '{' declaracion ';' '}' {printf("flag");}
        ;

instrucciones: INSTRUCCIONES '{' instruccion '}'
        ;

instruccion: inst_asiq
            | inst_si
            | inst_para
        ;

declaracion: tipo ':' lista_id
        ;

tipo: LOGICO
     | ENTERO
     | REAL
     | COMPLEJO
    ;

lista_id: id '{' ',' id '}'

inst_asiq: id '(' ':' '=' ')' expr
    ;

id: '(' letra '{' letra
     | digito
     | '_' '}' ')'
    ;

inst_si: SI expr ENTONCES '{' instruccion '}' FIN SI

inst_para: PARA inst_asiq A expr HACER '{' instruccion '}' FIN PARA

digito : '0'|'1'|'2'|'3'|'4'|'5'|'6'|'7'|'8'|'9'
;

letra : 'a'|'b'|'c'|'d'|'e'|'f'|'g'|'h'|'i'|'j'|'k'
       |'l'|'m'|'n'|'o'|'p'|'q'|'r'|'s'|'t'|'u'|'v'
       |'w'|'x'|'y'|'z'|'A'|'B'|'C'|'D'|'E'|'F'|'G'|'H'
       |'I'|'J'|'K'|'L'|'M'|'N'|'O'|'P'|'Q'|'R'|'S'|'T'
       |'U'|'V'|'W'|'X'|'Y'|'Z'
;

bool: V 
     | F
    ;

num: num_ent | num_rea | num_com

num_ent: '(' digito '{' digito '}'

num_rea: '(' '[' '+' 
     | '-' ']' num_ent '.' num_ent '[' 'E' '[' '+' 
     | '-' ']' num_ent ']' ')'
    ;

num_com: '(' num_rea '+' 'j' num_rea ')'
     | '(' num_rea '*' 'e' '^' 'j' num_rea ')'
    ;


expr: bool
    | num
    | '-' expr
    | expr '+' expr
    | expr '*' expr
    | expr '=' expr
    | expr '>' expr
    | NOT expr
    | expr AND expr
    | '(' expr ')'
   ;

%%

int main(){
	yyparse();

	return 0;
}

void yyerror(char *s){
	fprintf(stderr, "ERROR in line %s\n", s);
}