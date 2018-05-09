/*
    to compile:
    g++ -std=c++11 main.cpp -o all -lboost_locale; ./all
 */
#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
#include <memory>
#include <algorithm>
#include <boost/locale.hpp>


int main() {
    using namespace std;

    boost::locale::generator gen;
    // Create locale generator 
    std::locale::global(gen("pl_PL.UTF-8")); 

    std::string s("SPRZEDAJĄCYĘŻŹÓŁJK");
    std::string ss(s);
    std::string r = boost::locale::to_lower(s);
    /* std::transform(s.begin(), s.end(), ss.begin(), ::tolower); */
    std::cout << r << std::endl;

    return 0;
}
