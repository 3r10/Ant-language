#!/bin/sh

ocamlc -c ast.ml
echo 0
ocamllex lexer.mll       # generates lexer.ml
ocamlyacc -v parser.mly   # generates parser.ml and parser.mli
echo 1
ocamlc -c parser.mli
echo 2
ocamlc -c lexer.ml
ocamlc -c parser.ml
ocamlc -c compiler.ml
echo 3
ocamlc -o antcc ast.cmo lexer.cmo parser.cmo compiler.cmo
rm lexer.ml parser.ml parser.mli
rm *.cmi *.cmo
