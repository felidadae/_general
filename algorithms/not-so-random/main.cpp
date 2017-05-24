#include <iostream>
#include <vector>
using namespace std;
#define MAX_OUTCOMES 200



struct PossibleOutcomes {
	struct Outcome {
		int v;
		int p;
	};
	Outcome outcomes[MAX_OUTCOMES];
	unsigned s_;

	PossibleOutcomes() {s_=0;}
	void clear() { s_ = 0; }

	bool extend(Outcome o) {
		bool ifExists=false;
		for (i = 0; i < s_; ++i) {
			if (o.v == outcomes[i].v) {
				ifExists = true;
				outcomes[i].p += o.p;
			}
		}
		if (!ifExists) {
			outcomes[++s_].v = o.v;
			outcomes[++s_].p = o.p;
		}
	}

	float getExpectedValue() {
		float result=0.0f;
		for (i = 0; i < count; ++i) {
			result += outcomes.p * outcomes.v;	
		}
		return result;
	}
};
PossibleOutcomes possibleOutcomes1, possibleOutcomes2;



struct RNG {
	unsigned A, B, C;
	unsigned K;
};
RNG rng;



void computeLevel() {
	possibleOutcomes2.clear();
	for (i = 0; i < possibleOutcomes1.s_; ++i) {
		Outcome currVariant = possibleOutcomes1[i];

		Outcome consequenceA;
		consequenceA.v = currVariant.v & rng.A;
		consequenceA.p = currVariant.p * A;

		Outcome consequenceB;
		consequenceB.v = currVariant.v | rng.B;
		consequenceB.p = currVariant.p * B;

		Outcome consequenceC;
		consequenceC.v = currVariant.v ^ rng.C;
		consequenceC.p = currVariant.p * C;

		possibleOutcomes2.extend( consequenceA );	
		possibleOutcomes2.extend( consequenceB );	
		possibleOutcomes2.extend( consequenceC );	
	}	
	possibleOutcomes1 = possibleOutcomes2;
	possibleOutcomes2.clear();
}


void compute(unsigned levels) {
	 possibleOutcomes1[0]=X;
	 for (i = 0; i < N; ++i) {
		computeLevel();
	 }
	return possibleOutcomes1.getExpectedValue() 
}


int main(int argc, char const *argv[])
{
	return 0;
}

