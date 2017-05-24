#include <Timer/helper_timer.h>
#include <iostream>

using namespace std;



void myfunction(int N) {
	// @MyCode goes here
}



int runMyFunction(int N)
{
	StopWatchInterface *timer = NULL;
	sdkCreateTimer(&timer);
	sdkStartTimer(&timer);  

	myfunction(N);

    sdkStopTimer(&timer);  
	float execution_time = sdkGetTimerValue(&timer);
	cout << execution_time << "[s]" << endl;
    return 0;
}

int main(int argc, char const *argv[])
{
	int N_0 = 16;
	int N = N_0;
	for (int i = 0; i < 5; ++i)
	{
		runMyFunction(N);
		N *= 2;
		//N += N_0
	}
	return 0;
}
