#include <iostream>

using namespace std;



struct PriorityQueue {
	int* data;
	int N;
	int _N;
	PriorityQueue(int maxElements) {
		data = new int[maxElements];
		N = maxElements;
		_N = 0;
	}
	~PriorityQueue() {
		delete[] data;
	}
	int seeMin() {
		return data[0];
	}
	void swap(int i, int j) {
		int tmp = data[j];
		data[j] = data[i];
		data[i] = tmp;
	}
	int popMin() {
		if (_N == 0) throw (5);

		int min = data[0];
		data[0] = data[_N-1];
		--_N;

		int i = 0;
		bool ifAlreadyDone = false;
		while ((i+1)*2-1 < _N && !ifAlreadyDone) {
			int icl  = (i+1)*2-1; 	
			int icr  = (i+1)*2;
			if (icr >= _N) icr = icl;
			if (data[i] > data[icl] || data[i] > data[icr]) {
				int ic_;
				data[icl] < data[icr] ? ic_=icl : ic_=icr;
				swap (i, ic_);
				i = ic_;
			}
			else { ifAlreadyDone = true; }
		}

		return min;
	}
	void push(int newEl) {
		if (_N == N) return;

		data[_N] = newEl;
		++_N;
		
		bool ifAlreadyDone = false;
		int i = _N-1;
		while (i > 0 && !ifAlreadyDone) {
			int iparent;
			(i % 2 == 1) ? iparent = (i-1)/2 : iparent = (i-2)/2;

			if (data[i] < data[iparent]) { 
				swap(i, iparent);   
				i = iparent;   
			}
			else { ifAlreadyDone = true; } 
		}
	}

	void print(std::string title) {
		cout << endl;
		cout << title << endl;
		cout << "_N <- " << _N << endl;
		for (int i = 0; i < _N; ++i) {
			cout << data[i] << " ";
		}
		cout << endl;
	}
};


void test_popMin() {
	PriorityQueue pq(7);
	int v[7] = {0, 5,7, 8,10,10,8};
	for (int i = 0; i < 7; ++i)
	{
		pq.data[i] = v[i];
	}
	pq._N = pq.N;
	pq.print("Step 0");

	for (int i = 0; i < 6; ++i)
	{
		pq.popMin();
		pq.print("After popMin()");
	}
}

void test_push() {
	PriorityQueue pq(7);
	int v[7] = {7,6,5,4,3,2,1};

	for (int i = 0; i < 7; ++i)
	{
		pq.push(v[i]);
		pq.print("After push()");
	}
}

int main(int argc, char const *argv[])
{
	test_push();
	return 0;
}

