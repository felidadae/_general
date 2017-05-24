#include <iostream>

char const* getText()
{
   return "hello, world!";
}

double getSomeDoubleBro(int a, int b) {
	return double(a+b);
}

 

void initModule() {
	std::cout << "init module" << std::endl;
}

class B {
public:
	B() { std::cout << "B c-tor" << ";"; }
	virtual ~B() { std::cout << "B d-tor" << std::endl; }
	int get() { return doGet(); }
private:
	virtual int doGet() { return 0; }
};

class D : public B {
public:
	D(int v) : val_(v) {
		std::cout << "D c-tor, val_=" << val_ << std::endl;
	}
	virtual ~D() {
		std::cout << "D d-tor, val_=" <<  val_ << ";";
	}
private:
	int doGet() { return val_; }
	int val_;
};

#include <boost/python.hpp>

using namespace boost;
using namespace boost::python;

BOOST_PYTHON_MODULE(hello)
{
    initModule();

    def("getText", getText);
    def("getSomeDoubleBro", getSomeDoubleBro);

    class_<B>("Base", no_init )
        .def( "get", &B::get )
        ;

    class_<D, bases<B> >("Derived", init<int>() )
        ;

}
