/*

	

*/

#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
#include <string>
using namespace std;

const int CHILDREN_NUMBER = 11;
const int TERMINAL = '0';
char MAPLN(char letter) {
	if (letter == TERMINAL) return CHILDREN_NUMBER-1;
	else return letter-'a';
}

struct Node {
	char data;
	Node** children;
	
	Node() {
		children = new Node*[CHILDREN_NUMBER];
		for (int i = 0; i < 10; ++i)
		{
			children[i] = NULL;
		}
	}
	void createChild(char letter) {
		children[MAPLN(letter)] = new Node();
	}
	Node* getChild(char letter) {
		return children[MAPLN(letter)];
	}
	bool checkIfExists(char letter) {
		if ( children[MAPLN(letter)] ) {
			return true;
		}
		return false;
	}
};

struct PrefixTree {
	Node* root;
	PrefixTree() {
		root = new Node();
	}

	bool insertWord(string word) {
		/* Add all letter from the word */
		Node* walker = root;
		bool ifCreatedAnyNode = false;
		for(std::string::size_type i = 0; i < word.size(); ++i) {
			/* Check if we have already prefix added before to our word */
			if (walker->checkIfExists(TERMINAL))	
				return false;

			char l = word[i];
			if ( !walker->checkIfExists(l) ) {
				/* create Node with given letter */
				walker->createChild(l);
				ifCreatedAnyNode = true;
			}
			walker = walker->getChild(l);
		}

		/* 
			We are at last letter;
			Now add terminal or check, 
			maybe precisely the same 
			word alredy was added */
		if (walker->checkIfExists(TERMINAL) || ifCreatedAnyNode == false)
				return false;
		else {
			walker->createChild(TERMINAL);
		}

		return true;
	}
};



int main() {
	int N;	

	if (N==1) {
		cout << "GOOD SET" << endl;
		return 0;
	}

	string* set = new string[N];
	for (int i =0; i < N; ++i)
		cin >> set[i];

	PrefixTree prefTree;
	for (int i = 0; i < N; ++i)
	{
		bool result = prefTree.insertWord(set[i]);
		if (!result) {
			cout << "BAD SET" << endl << set[i] << endl;
			return 0;
		}
	}

	cout << "GOOD SET" << endl;
	return 0;
}
