#include <iostream>
#include <iterator>
#include <string>
#include <regex>

void fun2();

int main()
{
    fun2();
    return 0;
}

void fun2() {
    std::string s("zupa z kartoflaka");
    std::string s2("    \t\t ");
    
    std::regex r1("^\\s*$"); 
    std::smatch base_match;
    if(std::regex_match(s2, base_match, r1)) {
        std::cout << "matching!";
    }
}
