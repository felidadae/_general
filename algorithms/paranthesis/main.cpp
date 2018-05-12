/*
    to compile:
    g++ -std=c++11 main.cpp -o all; ./all
 */
#include <iostream>
#include <string>
#include <vector>
#include <unordered_map>
#include <memory>

using namespace std;

bool is_opening(char ch) {
    if (ch == '[' || ch == '{' || ch == '(') return true;
    return false; 
}

bool match(char open, char close) {
    if (open == '(' && close == ')') return true; 
    if (open == '{' && close == '}') return true; 
    if (open == '[' && close == ']') return true; 
    return false;
}

bool isValid(string s) {
    std::vector<char> stack;
    for (const char& ch : s) {
        if (is_opening(ch)) stack.push_back(ch);
        else if (match(stack.back(), ch)) stack.pop_back();
        else return false;
    }
    if (stack.size()) return false;
    return true;
}

int main() {
    std::cout << isValid("((()))") << std::endl;
    std::cout << isValid("((())") << std::endl;
    return 0;
}
