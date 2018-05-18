#include <string>
#include <iostream>

using namespace std;



string& makeMyShit() {
    string mystring("zupa z ogorka");
    return mystring;
}

void myShit() {
    std::string s;
    const std::string& my_loved = new std::string("zupencja");
    std::string& my_loved_2 = s;
    return;
}

int main()
{
    string& mylocalstring(makeMyShit());
    cout << mylocalstring;
    return 0;
}
