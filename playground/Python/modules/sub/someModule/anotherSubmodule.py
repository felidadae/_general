from .someSubmodule import printShit

def printAnotherShit():
	print("another....")
	printShit()
	import ipdb; ipdb.set_trace()
