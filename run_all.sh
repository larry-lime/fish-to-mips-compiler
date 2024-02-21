#!/bin/bash
cd test
FILES=$( (ls *.fish))
for f in $FILES; do
	echo "Compiling: $f"
	../ps3 sexp ${f%.fish}.sexp >../compiled/${f%.fish}.s
done
