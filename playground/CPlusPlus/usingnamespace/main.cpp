#include <iostream>
#include <vector>
#include <list>
#include <typeinfo>

int main(int argc, char *argv[])
{
	using std::cout;
	using std::string;
	using std::list;
	using std::vector;
	using std::endl;

	vector<int> supper = {1,2,3,4};
	/* for ( auto w: supper ) { */
	/* 	cout << w << endl; */
	/* 	cout << typeid(w).name() << endl; */
	/* } */

	for(auto it=supper.begin(); it!= supper.end(); ++it){
		cout << "CURR:";
		cout << *it;
		auto it2 (it);
		auto i3 = it-1;
		if (it == supper.begin()) {
			cout << endl;
			continue;
		}
		it2--;
		cout << "  PREV:";
		cout << (*it2);  
		cout << endl;
	}

	return 0;
}
