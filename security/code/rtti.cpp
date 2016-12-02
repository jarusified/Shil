#include<iostream>
// Header file for typeid. 
#include<typeinfo>

/* Typeid operator does a run-time check when applied to an I-value of a polymorphic class type, where the true type of the object cannot be determined by the static information provided. Such cases are:

 > A reference to a class
 > A pointer, dereferenced with * 
 > A subscripted pointer ([] -> It aint generally safe to use a subscript with a pointer to a polymorphic type) 

*/

class Base{
  public:
  virtual void vvfunc() {}
};

class Derived: public Base{};

using namespace std;

int main(){
  Derived* pd = new Derived;
  Base* pb = pd;
  cout<< typeid(pb).name() << endl;
  cout<< typeid(*pb).name() << endl;
  cout<< typeid(pd).name() << endl;
  cout<< typeid(*pd).name() << endl;

}
