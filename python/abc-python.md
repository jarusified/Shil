## [ABC-Python](https://docs.python.org/2/library/abc.html)

A pure virtual function is a function that doesnt have a definition on its own. The classes which derive from this class need to provide the definition for such function. A class containing at least one such pure virtual function is an abstract base class. 

	''' 
		class Shape{
			int x,y;
			public:
				// makes draw point to a null pointer
				virtual draw() const = 0;;
	    }
		
		class Rectange: public Shape{
			void draw(){
				
			}
		}
		
	'''

Python being a ducktyped language doesnt care about the data type of the object. Till python PEP 3119 there was no abstract base class concept in python. In the domain of object-oriented programming, the usage patterns for interacting with an object can be divided into two basic categories, which are 'invocation' and 'inspection'.

* Invocation means interacting with an object by invoking its methods. Usually this is combined with polymorphism, so that invoking a given method may run different code depending on the type of an object.

* Inspection means the ability for external code (outside of the object's methods) to examine the type or properties of that object, and make decisions on how to treat that object based on that information.

Invocation is generally preferred among the object oriented programming paradigm. 


### Python abc module

It defines a metaclass ABCMeta and decorators( @abstractmethod and @abstractproperty). It overrides __instancecheck__ and __subclasschecK__ and defines a register method. Register takes one argument whihc is a class. 

	'''
	from abc import ABCMeta
	
	class A(metaclass=ABCMeta):
		pass 
		
	A.register(B)
	
	assert issubclass(B, A)
	assert isinstance((), A)
	
	'''
	
abc module also has a decorator called @abstractmethod which defines the virtual function of a class. 

	'''
	from abc import ABCMeta, abstractmethod

	class A(metaclass=ABCMeta):
		@abstractmethod
		def foo(self): pass

	A()  # raises TypeError

	class B(A):
		pass

	B()  # raises TypeError

	class C(A):
		def foo(self): print(42)
	
	C()  # work
	'''
	
Dynamically adding abstract methods to a class, or attempting to modify the abstraction status of a method or class once it is created, are not supported. The @abstractmethod only affects subclasses derived using regular inheritance; "virtual subclasses" registered with the register() method are not affected.


