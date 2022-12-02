%{
  open Ast
%}

%token <string> STRING
%token <float> FLOAT

%token VERTICALBAR
%token EOF

%start file

%type <Ast.stmt> file

%%

file:
| lines = nonempty_list(stmt) EOF { Lines lines }
;

stmt:
| inst = STRING VERTICALBAR  power = FLOAT VERTICALBAR time = FLOAT 
        {Inst (inst, power, time) }