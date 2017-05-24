# you can write to stdout for debugging purposes, e.g.
# print "this is a debug message"

def solution(A):
    if len(A) < 3:
        return 0
    
    #return -1 if result is more than 10^9
    
    I = [] #intervals
    for ia, a in enumerate(A):
        if ia == 0:
            continue
        I.append(long(A[ia]-A[ia-1]))
    # should have N-1 elements, so 2...
    
    #
    R = []
    ir_begin = 0
    for ii in xrange(1,len(I)):
        #if last element
        if ii == len(I)-1 and I[ii] == I[ir_begin] and ii > ir_begin:
            R.append( ii-ir_begin + 1 )
            continue
        
        if I[ii] == I[ir_begin]:
            continue
        else:
            if ii - ir_begin > 1:
                R.append( ii-ir_begin )
            ir_begin = ii
    
    def pairs(n):
        return long(n*(n-1)/2)
    
    R_ = [pairs(r) for r in R]
    sum = long(0)
    for r_ in R_:
        sum = long(sum + r_)
        if sum > 1000000000:
            return long(-1)
    
    return sum
        
if __name__ == "__main__":
	print solution([1]*10)    
        
        
    
