# Theory of Computation
 Flex-Bison

# Introduction
This project aims to the deepestunderstanding of the use of the application of theoretical tools, such as regular expressions and grammatical without context, to the problem of compilation of programming languages. In particular, the work is about designing and implementing the initial stages of a compiler for the fantastic TeaC programming language.

There are 2 modules in this project.

1)Implement a verbal analyzer for a specific language(called Teac) using flex. This is the file .l . <br /> 

2)Implement an editorial analyst for a specific language(called Teac)using bison. This is the file .y . <br />

3)Convert TeaC code to C code using bison actions. <br />


# TeaC Language
The description of the TeaC language below follows the general description format of a language Programming. The verbal units of the TeaC language are divided into the following categories:
# Verbal Units
Verbal units are divided into the following categories:
1) keywords. <br />
2) identifiers. <br />
3) integer positive constants. <br />
4) real positive constants. <br />
5) boolean constants. <br />
6) constants strings. <br />
7) operators. <br />
8) identifiers. <br />
9) delimiters. <br />
10) white space. <br />
11) comments. <br />
12) line comments. <br />

# Editorial Rules
The editorial rules determine the correct drafting of its verbal units.
1)Program.<br />
2)Data types.<br />
3)Variables.<br />
4)Constants.<br />
5)Functions.<br />
6)Expressions.<br />
7)Statements.<br />

# Mapping from TeaC to C99
1) Assign data type and constants.<br />
2) Assigning verbal blocks

# How to run
This project can run in linux terminal using lex and bison packages. 

**Install flex**
sudo apt-get upgrade
sudo apt-get install flex

**Install Bison**
sudo apt-get install bison


There are external libraries for executing the transformation for teac to C99 (teaclib.h /cgen.c /cgen.h). 

The project can run as: <br />. 
**bison -d -v -r all teac_parser.y .<br />
flex teac_lex.l .<br />
gcc -o mycomp teac_parser.tab.c lex.yy.c cgen.c -lfl .<br />
./mycomp < correct1.tc > C1output.c .<br />**

For transformation to C execute
**gcc -Wall -std=c99 -o C1 C1output.c .<br />**
