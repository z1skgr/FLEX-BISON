# TeaC Compiler
> Source-to-source compiler (trans-compiler or transpiler) using FLEX & BISON.
## Table of contents
* [General Info](#general-information)
* [Installation](#installation)
* [Execution](#execution)
* [Acknowledgements](#acknowledgements)

## General Information
The input files (.tc file) is written in the fictional TeaC programming language and the generated code
is in C. Each TeaC program is a set of word units, which are arranged according to syntax rules. We generate a compiler that recognizes .tc archives and generate the equivalent C code. The implementation is split to two parts:
* Lexical Analyzer
* Parser Generator
  * Convertion fictional code to C code using bison actions.   

### Flex
Scans words in text files  in token format. For more information https://www.geeksforgeeks.org/flex-fast-lexical-analyzer-generator/
General form of description of a language programming. 
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

`.y` file contains the lexical rules. 

### Bison
For more information https://www.geeksforgeeks.org/bison-command-in-linux-with-examples/
Syntactic rules of the language define the correct syntax of its word units:
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

makes <parser_name>.tab.c, <parser_name>.tab.h files


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
Use the latest version for both tools: 
[Flex](https://howtoinstall.co/en/flex) <t>
[Bison](https://geeksww.com/tutorials/miscellaneous/bison_gnu_parser_generator/installation/installing_bison_gnu_parser_generator_ubuntu_linux.php)

* GCC install to converter parser rules to a recognized programming language (C in this case)
```
$ sudo apt install build-essential
$ sudo apt-get update
```
Verify correctly installation with the version of the GCC
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
```cgen.c``` contains function for lex to handle string. In other words, uses buffers to handle the parser's tokens. Error in stream => Error in syntax => No executable 
 <br>

* Convert the fictional input to a .c file
```
./teac < <TeaC input name>.tc> output.c
 ```
* Build and run
```
gcc -Wall -std=c99 -o out output.c
./out
```
In `\scripts`, there are a few script for testing code for different sample inputs. ` correct1.tc` is a sample of source code of TeaC language. 
## Acknowledgements
- This project was created for the requirements of the lesson Theory of Computation

