from collections import deque

##-------------------------------------------
class Hashmap(object):
    """
    Lacks code to resize hashmap
    should check always when addItem
    if currSize_/allocatedSize_ > 2/3
        realocate memory and realocate elements
    """
    def __init__(self):
        self.size_ = 100
        self.data_=[]
        for i in range(self.size_):
            self.data_.append(deque())

    def myhash(self, k):
        """string"""
        result=0
        for c in k:
            result += ord(c)-ord('a')
        return result % self.size_

    def getItem(self, k):
        cell = self.data_[self.myhash(k)]
        if len(cell):
            for el in cell:
                if el[0] == k:
                    return (True, el[1]) 
            return (False, None)
        else:
            return (False, None)

    def addItem(self, k, v):
        idx = self.myhash(k)
        cell = self.data_[idx]
        if len(cell):
            for el in cell:
                if el[0] == k:
                   el[1] = v #update 
        cell.append((k, v)) 

    def cellLen(self,i):
        return len(self.data_[i])
##-------------------------------------------

        

import random, string
def randomword(length):
   return ''.join(random.choice(string.lowercase) for i in range(length))
def randomElement():
    return (randomword(5), random.randint(0, 149)) 
def test():
    h1 = Hashmap()
    for i in range(900):
        h1.addItem(*randomElement())
    
    import matplotlib.pyplot as plt
    import numpy as np
    x = np.arange(0, h1.size_-1) #to have integer values
    y = np.array([h1.cellLen(x_) for x_ in x]) #to call your own function 
    plt.plot(x, y)
    plt.xlabel('x')
    plt.ylabel('y')
    plt.title('Plot of function ')
    plt.grid(False)
    plt.xlim( x.min() - 0.01, x.max() + 0.01 )
    plt.ylim( y.min() - 0.01, y.max() + 0.01 )
    plt.show()

test()
