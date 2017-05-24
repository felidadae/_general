#include <iostream>



class Stolec {
public:
	Stolec() {
		std::cout << "Stolec::Stolec()" << std::endl;
		kupka();
		siczki();
	}

	~Stolec() {
		std::cout << "Stolec::~Stolec()" << std::endl;
		kupka();
		siczki();
	}

	virtual int kupka() {
		std::cout << "Stolec::kupka()" << std::endl;
	}

	virtual int siczki() {
		std::cout << "Stolec::siczki()" << std::endl;
	}

	void wyczyscSie() {
		kupka();
		siczki();
	}
};

class StolecMutacja: public Stolec {
public:
	StolecMutacja() {
		std::cout << "StolecMutacja::Stolec()" << std::endl;
		kupka();
		siczki();
	}

	~StolecMutacja() {
		std::cout << "StolecMutacja::~StolecMutacja()" << std::endl;
		kupka();
		siczki();
	}

	virtual int kupka() override final {
		std::cout << "StolecMutacja::kupka()" << std::endl;
	}

	virtual int siczki() {
		std::cout << "StolecMutacja::siczki()" << std::endl;
	}

};



int main(int argc, char const *argv[])
{
	{
		Stolec stolec; 
		std::cout << "***" << std::endl;
		stolec.wyczyscSie();
	}

	std::cout << "*********" << std::endl;

	{
		StolecMutacja stolecMutacja; 
		std::cout << "***" << std::endl;
		Stolec* st = &stolecMutacja;
		st->wyczyscSie();
	}

	return 0;
}
