# Analysis of Return Oriented Programming

## Source code analysis of ld.so 

[Starting point](http://repo.or.cz/w/glibc.git/blob/HEAD:/elf/rtld.c)

### Run time type information
* C++ has something called Run time type information (RTTI). RTTI is a C++ mechanism that exposes information about object's data type at the runtime. 
* Dynamic_cast<> and typeif operator are a part of RTTI.
* C++ run time type information permits performing safe typecasts and manipulation type information at the run time. _Weird_
* RTTI is available only for classes which are polymorphic. 

#### Typeid 
[code](www.github.com/jarusified/shil/security/code/rtti.cpp)
* _typeid_ can also be used in templates to determine the type of template parameter. 
* if the expression is dereferencing a pointer and the pointer's value is 0, typeid throws a **bad_typeid exception*.
* typeid(int) == typeid(int&)

### Polymorphism 
* It is an ability to present the same interface for differing underlying forms or data-types. _ Morph -> Morpheus = Greek god of languages_ 
* Integers and floats are implicitly polymorphic in nature since you can add, subtract, etc. 

### Linkers and loaders
* cpp, cc1, as are the GNU's preprocessor, compiler proper and the assembler. 
* Compilation can involve up to 4 stages:
  > Preprocessing
  > Compilation proper
  > Assembly
  > Linking
* file.c -> C source code that must be preprocessed. 
* file.i -> C source code that should not be preprocessed. 
* file.s -> assembler code.
* file.sx -> assembler code that must be preprocessed. 

#### Object files
* Object files come in three forms:
  > Relocatable Object file: Contains both binary code and the data in a form that can be combined with other relocatable object files at compile time.
  > Execuatable Object file: Contains binary code and data in a form that can be directly loaded into memory and executed. 
  > Shared Object file: Special type of relocatable file that is loaded into memory at either load time or the run time. 

