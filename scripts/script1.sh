#!/bin/bash
# Description :	Compile and run all the variations of the algorithm witn the same inputs.


bison -d -v -r all teac_parser.y
flex teac_lex.l
gcc -o mycomp teac_parser.tab.c lex.yy.c cgen.c -lfl
./mycomp < correct1.tc > C1output.c

gcc -Wall -std=c99 -o C1 C1output.c

echo -e "\n\nPROGRAM\n" 
./C1
echo -e "\n" 