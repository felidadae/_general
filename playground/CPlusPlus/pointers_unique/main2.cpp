/* to compile: g++ -std=c++11 main.cpp -o all; ./all */
#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
#include <memory>

using namespace std;

class MyClass {
public:
    const int name = 8;
    MyClass() { std::cout << "Witaj!" << std::endl; }
    virtual ~ MyClass() { std::cout << "Zegnaj!" << std::endl; };
};

#include <iostream>

struct Resource{
    int k=8;
};

void someFunction() {
    Resource *ptr = new Resource;

    int x;
    std::cout << "Enter an integer: ";
    std::cin >> x;

    if (x == 0)
        throw std::exception(); // the function returns early, and ptr won’t be deleted!

    // do stuff with ptr here

    delete ptr;
}

int main() {
    /* unique_ptr<MyClass> p_u = make_unique<MyClass>(); */
    unique_ptr<MyClass> p_u (new MyClass());
    unique_ptr<MyClass> p_u_2 (std::move(p_u));
    /* p_u.reset(); */
    p_u.release();
    if (p_u)
        std::cout << p_u->name << std::endl;
    if (p_u_2)
        std::cout << p_u_2->name << std::endl;

    try {
    someFunction();
    } catch(std::exception e) {
    std::cout << "Wyjateczek rzucony!" << std::endl;
    }

    return 0;
}
