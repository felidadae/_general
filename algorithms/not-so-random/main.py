import time

def myFunction(N):
	k = 8
	#@TODO

def runMyFunction(N):
	start_time = time.clock()
	myFunction(N)
	end_time = time.clock()
	print "(N, time[s]) <- " + str(N) + str(end_time - start_time) 

def main():
	N = 1
	for i in xrange(1,5):
		runMyFunction(N)
		N *= 2		

if __name__ == '__main__':
	main()

