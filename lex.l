%{
#include <stdlib.h>
#include "y.tab.h"

%}

NOT						not
HACER					hacer
LOGICO                  LOGICO
ENTERO                  ENTERO
REAL                    REAL
COMPLEJO                COMPLEJO
V                       V
F                       F

%%

"NOT"                   { return NOT; }
"HACER"                    { return HACER; }
"LOGICO"                  { return LOGICO; }
"ENTERO"                 { return ENTERO; }
"REAL"                  { return REAL; }
"COMPLEJO"                 { return COMPLEJO; }
"V"                   { return V; }
"F"                   { return F; }
    

[-+*/=(),]              { return *yytext; }



%%
