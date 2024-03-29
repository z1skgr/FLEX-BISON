# Compiler generation (TeaC Compiler)
> Source-to-source compiler (trans-compiler or transpiler) using FLEX & BISON. 
## Table of contents
* [General Info](#general-information)
* [Installation](#installation)
* [Execution](#execution)
* [Acknowledgements](#acknowledgements)

## General Information
The input files (file .tc) is written in the fictional TeaC programming language and the generated code is in C. Each TeaC program is a set of word units, which are arranged according to syntax rules of a fictional language. We generate a compiler that recognizes .tc archives and generate the equivalent C code. The implementation is split to two parts:
* Lexical Analyzer
* Parser Generator
  * Convertion fictional code to C code using bison actions.   


### Flex
General form of description of a language programming. Scans words in text files in token format and corresponds them to grammatical rules (declared in `.l` file).<br>
We specify the categories of rules:
* Keywords
* Identifiers
* Constants
    * Boolean
    * Real positive
    * Strings
* Operators
* Delimiters
* Specials (white space, comments)

In this version, we have set some specific words for TeaC as keywords:

| Keywords |     |  |
| ------------- | ------------- | ------------  |
| int  | real  | bool  |
| string  | true| false  |
| if  | then  | else  |
| fi  | while  | loop |
| pool  | const  | let  |
| return  | not  | end  |
| or  | start  |   |

The other categories have basic common programming language content (possibly with some shortcomings, check `.l` for clarifications). <br><br>For more information about Flex, see https://www.geeksforgeeks.org/flex-fast-lexical-analyzer-generator/.<br>







### Bison
Syntactic rules of a language define the correct syntax of its word units. Here, we have:
* Main
    * Declarations
    * Functions
    * Body 
* Data Types
* Array (one dimension)
* Variables
* Functions
* Expressions
* Commands
* Constants

It builds `<parser_name>.tab.c, <parser_name>.tab.h` files.<br><br> For more information https://www.geeksforgeeks.org/bison-command-in-linux-with-examples/

## Installation
* In linux terminal, run commands to install tools. 

```
$ sudo apt-get install flex
$ sudo apt update
$ sudo apt install bison
```


For any help, see
```
$ bison --help
```

* GCC install to converter parser rules to a recognized programming language (C in this case)
```
$ sudo apt install build-essential
$ sudo apt-get update
```
* Verify correctly installation with the version of the GCC
```
 gcc --version
```

## Execution
* Syntax analysis from parser
```
bison -d -v -r  <parser_name>.y
```
* Lexical analysis from lexer
```
flex <analyzer name>.l
```
* Build compiler using the extracted rules
```
gcc -o teac <parser_name>.tab.c <analyzer name>.yy.c cgen.c -lfl
```


* Convert the fictional input to a .c file
```
./teac < <TeaC_input>.tc> output.c
 ```
* Build and run
```
gcc -Wall -std=c99 -o out output.c
./out
```
In `\scripts`, there are a few script for testing code for different sample inputs. ` correct1.tc` is a sample of source code of TeaC language. 

### Prerequisites
```cgen.c``` contains function for lex to handle string. In other words, uses buffers to handle the parser's tokens. <br>Error in stream => Error in syntax => No executable 
 <br>

## Acknowledgements
- This project was created for the requirements of the lesson Theory of Computation

