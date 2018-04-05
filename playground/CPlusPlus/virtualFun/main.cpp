/* 
 * https://stackoverflow.com/questions/5134891/
 * how-do-i-use-valgrind-to-find-memory-leaks
 */
#include <iostream>
#include <vector>


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
        return 0;
	}

	virtual int siczki() {
		std::cout << "Stolec::siczki()" << std::endl;
        return 0;
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
        return 0;
	}

	virtual int siczki() override {
		std::cout << "StolecMutacja::siczki()" << std::endl;
        return 0;
	}
};

class StolecMutacjaDestrukcyjna: public Stolec {
public:
    std::vector<int> myNumbers_;
	StolecMutacjaDestrukcyjna() {
		std::cout << "StolecMutacjaDestrukcyjna::Stolec()" << std::endl;
		kupka();
		siczki();
        for (auto i = 0; i < 100; ++i)
            myNumbers_.push_back(5);
	}

	virtual ~StolecMutacjaDestrukcyjna() {
		std::cout << "StolecMutacjaDestrukcyjna::~StolecMutacjaDestrukcyjna()" << std::endl;
		kupka();
		siczki();
	}

	virtual int kupka() override final {
		std::cout << "StolecMutacjaDestrukcyjna::kupka()" << std::endl;
        return 0;
	}

	virtual int siczki() override {
		std::cout << "StolecMutacjaDestrukcyjna::siczki()" << std::endl;
        return 0;
	}
};

int main() {
	{
		Stolec* stolec = new StolecMutacjaDestrukcyjna(); 
        delete stolec;
	}
	std::cout << "*********" << std::endl;
	{
		Stolec* stolec = new StolecMutacja(); 
        delete stolec;
	}
	return 0;
}
