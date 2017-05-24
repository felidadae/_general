#include <Timer/helper_timer.h>
#include <iostream>

using namespace std;

void myfunction (unsigned N);

int allocate(unsigned N)
{
	StopWatchInterface *timer = NULL;
	sdkCreateTimer(&timer);
	sdkStartTimer(&timer);  

	myfunction(N);

    sdkStopTimer(&timer);  
	float execution_time = sdkGetTimerValue(&timer);
	cout << "memory: " << N << "[B];" << " execution time: "  << execution_time << "[s];" << endl;
    return 0;
}

void myfunction (unsigned N) {
	// @MyCode goes here
	char* data = new char[N];
	for (int i = 0; i < N; ++i)
	{
		data[i] = i;
	}
	delete [] data;
}

int main(int argc, char const *argv[])
{
	unsigned N = 1024*32;
	for (int i = 0; i < 5; ++i)
	{		
		allocate(N); 
		N *= 2;
	}
	return 0;
}