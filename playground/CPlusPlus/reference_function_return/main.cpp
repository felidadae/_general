#include <string>
#include <iostream>

using namespace std;



string& makeMyShit() {
    string mystring("zupa z ogorka");
    return mystring;
}

int main()
{
    string& mylocalstring(makeMyShit()); 
    cout << mylocalstring; 
    return 0;
}
