#include <string>
#include <iostream>
#include <vector>


int main()
{
    using std::string;
    using std::vector;  
    string strings[] = {string("zupa"), string("zupencja")};
    for(string& s: strings) {
        std::cout << s;
    }
    return 0;
}
