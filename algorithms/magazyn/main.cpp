#include <iostream>
using namespace std;

struct CityInfo {
	int x,y,t;
};

void rotateDims(cityInfos) {

}

int findXMedian(cityInfos) {

}

int findYMedian(CityInfo) {

}

CityInfo findWarehouse (CityInfo* cityInfos) {
	rotateDims(cityInfos);
	int x = findXMedian(cityInfos);
	int y = findYMedian(cityInfos);
	CityInfo result; result.x = x; result.y = y;
	return result;
}

int main(int argc, char const *argv[])
{
	int Ncity;
	cin >> Ncity;

	CityInfo* cityInfos = new CityInfo[Ncity]();

	for (int icity = 0; icity < Ncity; ++icity) {
		int x,y,t;
		cin >> x >> y >> t;
		cityInfos[icity].x = x; 		
		cityInfos[icity].y = y; 		
		cityInfos[icity].t = t; 		
	}
	CityInfo result = findWarehouse(cityInfos);
	cout << result.x << result.y;

	delete[] cityInfos;

	return 0;
}

