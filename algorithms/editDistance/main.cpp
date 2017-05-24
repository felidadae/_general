#include <iostream>
#include <string>
#include <algorithm>
#include <tuple>



int min3(int i1, int i2, int i3) {
	return std::min(std::min(i1, i2), i3);
}

struct EditDistanceSpace {
	int COST_INSERTION 	= 1;
	int COST_DELETION 	= 1;
	int COST_REPLACE 	= 1;

	/*
	@Discussion
		
	*/
	int solve( 
		std::string& s1, std::string& s2, 
		int i1 = 0, int i2 = 0 ) 
	{
		if ( i1 == s1.length() || i2 == s2.length() ) {
			return s1.length() > s2.length() ? 
				(s1.length() - s2.length()) * COST_DELETION : 
				(s2.length() - s1.length()) * COST_INSERTION;
		}

		int m_ = -1;
		if ( s1[i1] == s2[i2] ) {
			m_ = solve(s1, s2, 1+i1, 1+i2);
		}

		int min3_ = min3(
			COST_INSERTION + solve(s1, s2,   i1, 1+i2), 
			COST_DELETION  + solve(s1, s2, 1+i1,   i2),
			COST_REPLACE   + solve(s1, s2, 1+i1, 1+i2)
		);

		if (m_ == -1) 
			return min3_;
		else 
			return std::min(m_, min3_);
	}

	/*
		Dynamic solution;
		matrix N1xN2
		solution([1:N1], [1:N2]) = min( 1+solution() ) 
	*/
	struct Array2D {
		int N1_, N2_;
		int* data_;
		Array2D(int N1, int N2) {
			N1_ = N1; N2_ = N2;
			data_ = new int [N1]
		}
		
	};
	int solve2( 
		std::string& s1, std::string& s2, 
		int i1 = 0, int i2 = 0 )
	{
	}
};


int main() {
	using namespace std;
	EditDistanceSpace space;
	
	typedef tuple<string, string, int> TestCase;
	vector<TestCase> testCases;
	testCases.push_back(std::make_tuple("tata", "tatron", 3));
	testCases.push_back(std::make_tuple("tatoszek", "tat", 5));
	testCases.push_back(std::make_tuple("tatoszekzupka", "tat", 10));
	testCases.push_back(std::make_tuple("zapalka", "zapaka", 1));

	for(auto testCase: testCases) {
		auto result = space.solve(get<0>(testCase), get<1>(testCase));
		if (result != get<2>(testCase) ) return 1;
	}

	
	return 0;
}
