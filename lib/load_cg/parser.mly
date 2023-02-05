%{
  open Ast
%}

%token <string> STRING

%token EQUAL
%token EOF

%start file

%type <Ast.edge> file

%%

file:
| cg = nonempty_list(edge) EOF { Cg cg }
;

edge:
| from_node = STRING EQUAL  to_node = STRING
        {Edge (from_node , to_node) }