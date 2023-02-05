%{
  open Ast
%}

%token <int> CST
%token <string> IDENT

%token IF GOTO
%token EOF
%token COLON EQUAL NEWLINE
%token PLUS MINUS TIMES DIV MOD BEQ BNEQ BLT BLE BGT BGE

%left PLUS MINUS
%left TIMES DIV MOD

%start file

%type <Ast.stmt> file

%%

file:
| b = nonempty_list(stmt) EOF { Sblock b }
;

expr:
| c = CST
    { Ecst c }
| id = ident
    { Eident id } 
| e1 = expr PLUS e2 = expr
    { Ebinop (Badd, e1, e2) }   
| e1 = expr MINUS e2 = expr
    { Ebinop (Bsub, e1, e2) }   
| e1 = expr TIMES e2 = expr
    { Ebinop (Bmul, e1, e2) } 
| e1 = expr DIV e2 = expr
    { Ebinop (Bdiv, e1, e2) }
| e1 = expr MOD e2 = expr
    { Ebinop (Bmod, e1, e2) }  
;                                  

cond:
| id = ident BEQ e = expr   
    { Cmpl (Beq, id, e) }
| id = ident BNEQ e = expr  
    { Cmpl (Bneq, id, e) }
| id = ident BEQ e = expr   
    { Cmpl (Beq, id, e) }
| id = ident BLT e = expr   
    { Cmpl (Blt, id, e) }
| id = ident BLE e = expr   
    { Cmpl (Ble, id, e) }   
| id = ident BGT e = expr   
    { Cmpl (Bgt, id, e) }   
| id = ident BGE e = expr  
    { Cmpl (Bge, id, e) } 

| e = expr BEQ id = ident
    { Cmpr (Beq, e, id) }
| e = expr BNEQ id = ident
    { Cmpr (Bneq, e, id) }
| e = expr BEQ id = ident
    { Cmpr (Beq, e, id) }
| e = expr BLT id = ident
    { Cmpr (Blt, e, id) }
| e = expr BLE id = ident
    { Cmpr (Ble, e, id) }   
| e = expr BGT id = ident
    { Cmpr (Bgt, e, id) }   
| e = expr BGE id = ident
    { Cmpr (Bge, e, id) } 
;      

stmt:
|  id = ident EQUAL e2 = expr
    {Sassign (id,e2) }
|  idlabel = ident COLON IF c = cond GOTO id2 = ident
        s= nonempty_list(stmt)
    GOTO idlabl = ident
        {Sgoto (idlabel,c,Sblock s) }
;

ident:
  id = IDENT { id }
;