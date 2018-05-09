#include <iostream>
#include <boost/algorithm/string.hpp>


using std::vector; 
using std::string;
using std::cout;
using std::endl;
int main() { 
    vector<string> strs; 
    boost::split(strs, "string to split", boost::is_any_of("\t "));
    for (const string& word: strs)
        cout << word << endl;
    return 0;
}
