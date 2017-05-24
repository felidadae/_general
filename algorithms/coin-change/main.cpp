#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;


struct Solution {
	int N, M;
	int* coins;

	Solution(int N, int M, int* coins) {
		this->N = N;
		this->M = M;
		this->coins = coins;
		this->subproblems = new long int[(N+1)*(M)];
	}
	~Solution() { delete[] subproblems; }

	/* matrix with M columns and N+1 rows */
	long int* subproblems;

	long int solveAll() {
		for (int i_n = 0; i_n < N+1; ++i_n)
			for (int i_coin = 0; i_coin < M; ++i_coin)
				subproblems[i_n*M + i_coin] = 0;

		for (int i_n = 1; i_n < N+1; ++i_n)
			for (int i_coin = 0; i_coin < M; ++i_coin)
			{	
				long int sum = 0;
				int j_n = i_n - coins[i_coin];
				if( j_n == 0 ) 
					++sum;
				else if (j_n > 0)
					sum += subproblems[j_n*M + i_coin];
				if (i_coin > 0) 
					sum += subproblems[i_n*M + i_coin - 1];
				subproblems[i_n*M + i_coin] = sum;
			}
		
		return subproblems[N*M+M-1];
	}

	void printSubproblems() {
		for (int i_n = 0; i_n < N+1; ++i_n) {
			for (int i_coin = 0; i_coin < M; ++i_coin)
				cout << subproblems[i_n*M + i_coin] << " " ;
			cout << endl;
		}
	}
};


int main() {
//	int N = 4;
//	int M = 3;
//	int coins[4] = {1,2,3};
	int N = 10;
	int M = 4;
	int coins[4] = {2,3,5,6};

	Solution solution(N,M, coins);
	cout << solution.solveAll() << endl;
	solution.printSubproblems();

    return 0;
}

