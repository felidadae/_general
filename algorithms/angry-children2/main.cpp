#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
#include <stdlib.h>
using namespace std;



int cmp(const void *a, const void *b) {
	int* aa = (int *) a;
	int* bb = (int *) b;

	return (*aa)>=	(*bb);
}



struct SolutionSpace {
	int  N, K;
	int* pocket;
	//***
	long  minSumK=0;
 
	SolutionSpace(int N, int K, int arr[]) {
		// if (K > N) {
		// 	throw Exception();
		// }

		this->N=N;
		this->K=K;
		this->pocket=arr;
		//***
	}
	~SolutionSpace() {
	}

	long solve() {
		/* Init part */
		qsort(pocket, N, sizeof(int), &cmp);

		/* Rest part */
		for (int i = 0; i < K; ++i)
			for (int j = i; j < K; ++j)
				minSumK += abs(pocket[j]-pocket[i]);						

		long sum = minSumK;
		for (int ibase = 1; ibase < N-K; ++ibase)
		{
			//substract first
			for(unsigned i = ibase-1; i < ibase+K-1; ++i)
				sum -= abs(pocket[ibase-1]-pocket[i]);

			//add secondly
			for(unsigned i = ibase; i < ibase+K; ++i)
				sum += abs(pocket[ibase+K-1]-pocket[i]);

			if (sum<minSumK)
				minSumK = sum;
		}

		return minSumK;
	}
};

long solve(int arr[], int N, int K) {
    SolutionSpace solution(N, K, arr);
    return solution.solve();
}

int main() {
	int N, K;

	std::vector<int> someShit;
	someShit
	cin >> N >> K;
	int* arr = new int[N];
	for(int i = 0; i < N; i++)
		cin >> arr[i];

	cout << solve(arr, N, K);

	delete [] arr;
	return 0;
}
