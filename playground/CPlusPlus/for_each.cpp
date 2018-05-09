#include <iostream>
#include <vector>
#include <algorithm>

using std::vector;
using std::cout;
using std::for_each;

template <typename RandomAccessIterator, typename Function>
void for_each_(RandomAccessIterator begin, RandomAccessIterator end, Function f) {
	RandomAccessIterator it = begin, it_prev = begin;
	for (;it!=end; it_prev = it, ++it )
		f(it, it_prev, it==begin, it==(end-1));
	return;
}

void fun(vector<int>::iterator it, vector<int>::iterator it_prev, bool ifFirst, bool ifLast) {
	cout << (*it);
	return;
}

int main(int argc, char *argv[]) {
	vector<int> myvector={1,2,3,4,5};
	vector<int> result;
	for_each_(myvector.begin(), myvector.end(), 
		[&result](vector<int>::iterator it, vector<int>::iterator it_prev, 
			      bool ifFirst, bool ifLast) { 
					if (ifFirst) { cout << "First iter"; }
					if (ifLast)  { cout << "Last iter";}
					result.push_back( (*it) + (*it_prev));
				});
	for_each(result.begin(), result.end(), [] (int& el) { cout << el; });
	return 0;
}
