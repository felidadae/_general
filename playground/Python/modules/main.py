import os
# print("Curr directory:" + os.getcwd()) 
pathToCurrFile  = (os.path.dirname(os.path.abspath(__file__)))
os.chdir(pathToCurrFile)
import sys
sys.path.append("sub")
# from someModule.someSubmodule import printShit
# printShit()
# import someModule.someSubmodule
# someModule.someSubmodule.printShit()
# import someModule.anotherSubmodule
# someModule.anotherSubmodule.printAnotherShit()
# import ipdb; ipdb.set_trace()
import ipdb; ipdb.set_trace()
printShit()
