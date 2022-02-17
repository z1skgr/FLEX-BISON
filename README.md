# Theory of Computation
> Source-to-source compiler (trans-compiler or transpiler).
## Table of contents
* [General Info](#general-information)
* [Technologies Used](#technologies-used)
* [Screenshots](#screenshots)
* [Room for Improvement](#room-for-improvement)
* [Setup](#setup)
* [Acknowledgements](#acknowledgements)

## General Information
The source input code is written in the fictional TeaC programming language and the generated code
is in C. <br>
The implementation is split to two parts
* Lexical Analyzer
* Parser Generator


## Screenshots


## Technologies Used


## Installation
```
$ sudo apt-get install flex
$ sudo apt update
$ sudo apt install bison
```
For any help 
```
$ bison --help
```
Use the latest version for both tools <br>
* [Flex](https://github.com/westes/flex) 
* [Bison](https://github.com/akimd/bison)


## Execution
In linux terminal
```
bison -d -v -r  <parser_name>.y
flex <analyzer name>.l
gcc -o teac teac_parser.tab.c lex.yy.c cgen.c -lfl
./teac < correct1.tc > output.c

gcc -Wall -std=c99 -o out output.c
./out
```
The file `script.c` has an example of testing.

## Acknowledgements
- This project was created for the requirements of the lesson Theory of Computation

