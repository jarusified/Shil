# Unknown Python 

* Dynamic and strongly typed language: In dynamically typed languages, objects will have a type but it is determined at the runtime. Whereas, in statically typed language, type of variables must be known before hand. 
* Python is encoded in UTF-8. 
* Interactive mode, last printed expression is assigned to the variable _ (mainly read only). We can though change the built-in functionality and play around. 
* Two or more string literals next to each other are automatically concatenated. 
* Immutable vs mutable:
  ```
	Immutable : String, Tuples
	mutable   : Lists
	
  ```
* Slicing lists leads to a shallow copy of the list from rhs to lhs.
* Loops have else statements: 
  ```
	for i in range(1,10):
		# do something
		for x in range(2,i):
			if i%x == 0:
				print( i, "=" ,x ,"*", i//x)
				break
		else:
			print(i, " is a prime")
   ```
executed when the loop terminates through exhaustion of the list. 

* Pass statements does nothing. Used to create minimal classes. 
  ```
	  class A:
		  pass

	  def function(*args):
		  pass
  ```		  
* The first string following a function is the documentation string. 
* The execution of a function introduces a new symbol table used for the local variables of the function. 
* Order of lookup for a variable:
  
	  * Local symbol table
	  * Local symbol table of enclosing functions
	  * global symbol table
	  * built_in names. 
	  
* When a function calls another function, a new local symbol table is created for that call.

* Function definition introduces the function name in the current symbol table. 
  ```
  >>>func
  <function func at 10043ed9>
  ```
* All functions in python have a return type, irrespective of the whether they return a value or not. Thats called "None", A built-in name.
  ```
  >>>print(func(0))
  None
  ```
* Default values are evaluated at the point of function definition in the defining scope.
  ```
	  i=5
	  
	  def f(arg=i):
		print(arg)
	
	  i=6
	  f()
	  
	  # 5 will be printed.
  ```	  
* **kwargs contains a dictionary of parameters. 

* myfunction.__doc__ -> provides the documentation of the function.
* myfunction.__annotations__ -> provides optional metadata
* List comprehensions:
  They are used as a concise way to create lists. 
  
``` 
	squares = [x**2 for x in range(10)]
```
  The initial expression in a list comprehension can be any arbitrary expression, including another list comprehension.

* Del & pop:
  del statement can be used to remove slices of list or even clear the entire list. pop() removes one element.
  
* Tuples are comma separated values. 
* enumerate() function retrieves the index and value
```
	for i, v in enumerate(['a','b','c']):
		print(i,v)
```
* We can loop over using enumerate(), sorted(), reversed(), etc.

* Module's name can be changed using __name__.
