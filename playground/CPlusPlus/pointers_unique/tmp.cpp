#include <iostream>
#include <map>
#include <unordered_map>
#include <string>
#include <iterator>
#include <algorithm>

int main() {

	// Map of string & int i.e. words as key & there
	// occurrence count as values
	std::map<std::string, int> wordMap = {
						{ "is", 6 },
						{ "the", 5 },
						{ "hat", 9 },
						{ "at", 6 }
					};

	std::cout<<"std::map Contents : Elements are in sorted order of Keys"<<std::endl;

	// Print map contents
	std::for_each(wordMap.begin(), wordMap.end(), [](std::pair<std::string, int>  elem){
		std::cout<<elem.first<< " :: "<< elem.second<<std::endl;
	});



	// Unordered_map of string & int i.e. words as key & there
	// occurrence count as values
	std::unordered_map<std::string, int> wordUOMap = {
						{ "is", 6 },
						{ "the", 5 },
						{ "hat", 9 },
						{ "at", 6 }
					};

	std::cout<<"std::unordered_map Contents : Elements are in Random order of Keys"<<std::endl;

	// Print Unordered_map
	std::for_each(wordUOMap.begin(), wordUOMap.end(), [](std::pair<std::string, int>  elem){
								std::cout<<elem.first<< " :: "<< elem.second<<std::endl;
							});
	return 0;
}
