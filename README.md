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
is in C. Each TeaC program is a set of word units, which are arranged according to syntax rules.
The implementation is split to two parts
* Lexical Analyzer
* Parser Generator
  * Convertion fictional code to C code using bison actions.   

### Flex
Follows the general form of description of a language programming.
* Keywords
* Identifiers
* Constants
    * Boolean
    * Real positive
    * Strings
* Operators
* Delimiters
* Specials (white space, comments, line commants)


| Keywords |     |  |
| ------------- | ------------- | ------------  |
| int  | real  | bool  |
| string  | true| false  |
| if  | then  | else  |
| fi  | while  | loop |
| pool  | const  | let  |
| return  | not  | end  |
| or  | start  |   |

## Bison
The syntactic rules of the language define the correct syntax of its word units
* Programs
    * Declarations
    * Functions
    * Main Body 
* Data Types
* One dimensional array
* Variables
* Functions
* Expressions
* Commands
* Constants

In bison, the mapping is done from the fictional language to C.

## Screenshots

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
In `\scripts`, there are a few script for testing code for different sample inputs. ` correct1.tc` is the source code of teac language. In file, there are some sample of teac source code for various tests.

## Acknowledgements
- This project was created for the requirements of the lesson Theory of Computation

