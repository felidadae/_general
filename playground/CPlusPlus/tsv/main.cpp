#include <fstream>
#include <iostream>

int main()
{
    std::ofstream outfile("test.txt", std::ofstream::binary | std::ofstream::out);
    outfile << "ust beginning";
    outfile.close();
    return 0;
}
