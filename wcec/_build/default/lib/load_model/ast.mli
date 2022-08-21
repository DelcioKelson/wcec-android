type stmt =
  | Inst of string * float
  | Sline of stmt list
