#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>  
using namespace std;





struct People {
	int* belongings;
    int* sizes;
	int N;

	People(int N) {
		this->N = N;
		belongings = new int[N];
        sizes = new int[N];
		for (int i = 0; i < N; ++i)
		{
			belongings[i] = i;
			sizes[i] = 1;
		}
	}
	~People () {
		delete[] belongings;
		delete[] sizes;
	}

	void printBelongings() {
		cout << "printBelongings: ";
		for (int i = 0; i < N; ++i)
		{
			cout << belongings[i] << " ";
		}
		cout << endl;
	}
	void printCommunitySizeForEachGuy() {
		cout << "printCommunitySizeForEachGuy: ";
		for (int i = 0; i < N; ++i)
		{
			cout << getSizeOfCommunity(i) << " ";
		}
		cout << endl;
	}
	void printCommunityBelongingsForEachGuy() {
		cout << "printCommunityBelongingsForEachGuy: ";
		for (int i = 0; i < N; ++i)
		{
			cout << findCommunityID(i) << " ";
		}
		cout << endl;
	}

	int findCommunityID(int guyI) {
		int result;

		int itr = guyI;
		int countUp = 0;
		int guyOneUp = belongings[itr];
		while ( itr != belongings[itr] ) {
			itr = belongings[itr];
			++countUp;
		} 
		result = itr;

		if (guyOneUp != belongings[itr]) {
			int* upGuys = new int[countUp];
			itr = guyOneUp;
			while ( itr != belongings[itr] ) {
				itr = belongings[itr];
				upGuys[countUp] = itr;
				++countUp;
			}
			for (int i = 0; i < countUp; ++i)
			{
				upGuys[i] = result;
			} 
            
            delete[] upGuys;
		}

		return result;
	}

	void mergeCommunities(int guyI, int guyJ) {
		int guyI_communityID = findCommunityID(guyI);
		int guyJ_communityID = findCommunityID(guyJ);

		if (guyI_communityID == guyJ_communityID) return;
		
		if (guyI_communityID < guyJ_communityID) {
			belongings[guyJ_communityID] = guyI_communityID;
			sizes[guyI_communityID]+=sizes[guyJ_communityID];
		}
		else {
			belongings[guyI_communityID] = guyJ_communityID;
			sizes[guyJ_communityID]+=sizes[guyI_communityID];
		}
	}

	int getSizeOfCommunity(int guyI) {
		int guyI_communityID = findCommunityID(guyI);
		return sizes[guyI_communityID];
	}
};






struct Query {
    char ID;
    int arg1;
    int arg2;
    void print() {
        cout << ID << " " << arg1  << " " << arg2 << endl;
    }
};

int main() {
    int N;
    cin >> N;
    int qN;
    cin >> qN; 
   
    /* Load data */
    Query* queries = new Query[qN];
    for (int i =0; i < qN; ++i) {
        char qID;
        cin >> queries[i].ID;
        if ( queries[i].ID == 'Q' ) {
            cin >> queries[i].arg1;
        }
        else {
            cin >> queries[i].arg1;
            cin >> queries[i].arg2;
        }
    }
    
    
    People people(N);
    
    /* Run queries */
    for (int i =0; i < qN; ++i) {
        //queries[i].print();
        if ( queries[i].ID == 'Q' ) {
            cout << people.getSizeOfCommunity(queries[i].arg1) << endl;
        }
        else {
            people.mergeCommunities(queries[i].arg1, queries[i].arg2);
        }
    }
    
    delete [] queries;
    
    return 0;
}

