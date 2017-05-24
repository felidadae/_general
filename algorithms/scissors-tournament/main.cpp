#include <iostream>
using namespace std;

int N,R,P,S;

string findAFirstTree(string winner) {
	char *prevLeafs, *newLeafs;
	prevLeafs= new char[1];
	newLeafs = new char[2];
	for (ilevel = 1; ilevel < N; ++ilevel) {
		char* leafs = new char[Nleafs];
			
	}
}

string chooseFirst(string a, string b, string c) {
	return a > b ? (a>c ? a : c) : (b>c ? b : c);
}

string solve() {
	string solutionP = findAFirstTree("P");
	string solutionR = findAFirstTree("R");
	string solutionS = findAFirstTree("S");
	return chooseFirst( solutionP, solutionR, solutionS );
}



int main(int argc, char const *argv[])
{
	int T;
	cin >> T;

	for (int it = 0; it < T; ++it) {
		cin >> N >> R >> P >> S;
	}

	return 0;
}

