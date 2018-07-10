#include <string>
#include <iostream>
#include <vector>


int main()
{
    typedef double f__;
    f__ f = 1.000000000000000000000000001;
    f__ f2 = 1;
    std::cout << (bool)(f == f2);
    return 0;
}
