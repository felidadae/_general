# you can write to stdout for debugging purposes, e.g.
# print "this is a debug message"

def solution(A, B, M, X, Y):
    # A weight,  B floor targe people
    # M floors,X people max,Y weight max elevator
    
    _weightMax = Y
    _peopleMax = X
    _floorsN   = M
    
    peopleWeights = A
    peopleTargetFloors = B
    peopleN = len(A)
    
    #result
    stopsCount = 0
    
    ip = 0         #iperson
    weightSum = 0
    peopleSum = 0
    choosenFloors = {}
    import ipdb; ipdb.set_trace()
    while ip != peopleN:
        #check if we can pack another person
        if (    peopleSum + 1 <= _peopleMax and 
                weightSum + peopleWeights[ip] <= _weightMax):
            peopleSum += 1
            weightSum += peopleWeights[ip]
            choosenFloors[peopleTargetFloors[ip]] = 1
            ip += 1
        else:
            stopsCount += len(choosenFloors.keys())+1 
            peopleSum = 0
            weightSum = 0
            choosenFloors = {}
    stopsCount += len(choosenFloors.keys())+1 
    return stopsCount
            
if __name__ == "__main__":
	print solution([60, 80, 40], [2, 3, 5], 5, 2, 200)            
            
    
    
