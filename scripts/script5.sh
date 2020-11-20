#!/bin/bash
# Description :	Compile and run all the variations of the algorithm witn the same inputs.


bison -d -v -r all teac_parser.y
flex teac_lex.l
gcc -o mycomp teac_parser.tab.c lex.yy.c cgen.c -lfl
./mycomp < myprog.tc > C5output.c
gcc -Wall -std=c99 -o C5 C5output.c

echo -e "\n\nPROGRAM\n" 
./C5
echo -e "\n" 