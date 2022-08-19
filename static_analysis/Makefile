CMO= lexer.cmo parser.cmo abs.cmo main.cmo
GENERATED = lexer.ml parser.ml parser.mli
FLAGS=-annot -g

all: analyse


clean:
	rm -f *.cm[io] *.o *.annot *~ analyse $(GENERATED)
	rm -f parser.output parser.automaton

	
.PHONY: tests
tests: analyse
	bash run-tests

analyse: $(CMO)
	ocamlc $(FLAGS) -o $@ $(CMO)

.SUFFIXES: .mli .ml .cmi .cmo .mll .mly

.mli.cmi:
	ocamlc $(FLAGS) -c  $<

.ml.cmo:
	ocamlc $(FLAGS) -c $<

.mll.ml:
	ocamllex $<

.mly.ml:
	menhir --infer -v $<

.mly.mli:
	menhir --infer -v $<

.depend depend:$(GENERATED)
	rm -f .depend
	ocamldep *.ml *.mli > .depend

include .depend



