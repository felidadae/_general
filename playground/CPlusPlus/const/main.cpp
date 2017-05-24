#include <iostream>



class MyClass
{
private:
	mutable int counter;
	int shit;

public:

	MyClass() : counter(0) {}

	void Foo()
	{
		counter++;
		std::cout << "Foo" << std::endl;    
	}

	void Foo() const
	{
		counter++;
		std::cout << "Foo const" << std::endl;
	}

	void broTimer() const {
		std::cout << "broTimer" << std::endl;
	}

	int GetInvocations() const
	{
		return counter;
	}
};

int main(void)
{
	MyClass cc;
	const MyClass& ccc = cc;
	cc.Foo();
	ccc.Foo();
	cc.broTimer();
	ccc.broTimer();
	std::cout << "The MyClass instance has been invoked " 
		<< ccc.GetInvocations() << " times" << std::endl;
}