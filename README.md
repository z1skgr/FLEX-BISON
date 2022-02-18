# Theory of Computation
> Source-to-source compiler (trans-compiler or transpiler) using FLEX & BISON.
## Table of contents
* [General Info](#general-information)
* [Screenshots](#screenshots)
* [Installation](#installation)
* [Execution](#exec)
* [Acknowledgements](#acknowledgements)

## General Information
The source input code is written in the fictional TeaC programming language and the generated code
is in C. Each TeaC program is a set of word units, which are arranged according to syntax rules.
The implementation is split to two parts:
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
* Specials (white space, comments)


| Keywords |     |  |
| ------------- | ------------- | ------------  |
| int  | real  | bool  |
| string  | true| false  |
| if  | then  | else  |
| fi  | while  | loop |
| pool  | const  | let  |
| return  | not  | end  |
| or  | start  |   |

### Bison
The syntactic rules of the language define the correct syntax of its word units:
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



## Screenshots

## Installation
* In linux terminal, run commands to install tools
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


* GCC install to converter parser rules to a recognized programming language (C in this case)
```
$ sudo apt install build-essential
$ sudo apt-get update
```
Verify correctly installation with the version of the GCC
```gcc --version```

## Execution
* Syntax analysis from parser
```
bison -d -v -r  <parser_name>.y
```
* Lexical analysis from lexer
```
flex <analyzer name>.l
```
* Build executable in C using the extracted rules
```
gcc -o teac teac_parser.tab.c lex.yy.c cgen.c -lfl
```
```cgen.c``` contains function for lex to handle string. In other words, uses buffers to handle the parser's tokens. <br>
Error in stream => Error in syntax => No executable <br>



./teac < correct1.tc > output.c

gcc -Wall -std=c99 -o out output.c
./out
```
In `\scripts`, there are a few script for testing code for different sample inputs. ` correct1.tc` is the source code of teac language. In file, there are some sample of teac source code for various tests.

## Acknowledgements
- This project was created for the requirements of the lesson Theory of Computation

