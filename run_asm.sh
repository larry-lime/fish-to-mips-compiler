#!/bin/bash
if [[ -z $1 ]]; then
	cd compiled
	FILES=$( (ls *.s))
	for f in $FILES; do
		echo "Running: $f"
		spim -file "$f"
		echo ""
	done
else
	spim -file $1
	echo ""
fi
