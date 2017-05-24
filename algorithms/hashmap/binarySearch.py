import unittest



def binarySearch(x, a, lo, hi):
    # lo - left index
    # hi - one after right index
    # if exists return index of element,
    # if not index that after is bigger before smaller
    if len(a) == 0: 
        return (False, 0)

    if lo+1 == hi:
        if a[lo] == x:
            return (True, lo)
        if a[lo] > x:
            return (False, lo) 
        else:
            return (False, lo+1)

    m = lo+(hi-lo-1)/2
    if x > a[m]:
        return binarySearch(x, a, m+1, hi)
    else:
        return binarySearch(x, a, lo, m+1)

def binarySearch2(x, a, lo, hi ):
    if len(a) == 0: 
        return (False, 0)

    while 1+lo != hi:
        m = lo + (hi-lo-1)/2
        if x > a[m]:
            lo=m+1
        else:
            hi=m+1
    
    if x > a[lo]:
        return (False, lo+1)
    elif x == a[lo]:
        return (True, lo)
    else:
        return (False, lo)
    

def test_per(u, fun):
    u.assertEquals(
        (False, 5),
        fun(8, [1,2,3,4,5], 0, 5)
    )
    u.assertEquals(
        (True, 2),
        fun(3, [1,2,3,4,5], 0, 5)
    )
    u.assertEquals(
        (True, 0),
        fun(1, [1,2,3,4,5], 0, 5)
    )
    u.assertEquals(
        (False, 0),
        fun(0, [1,2,3,4,5], 0, 5)
    )
    u.assertEquals(
        (False, 0),
        fun(0, [1], 0, 1)
    )
    u.assertEquals(
        (False, 0),
        fun(0, [], 0, 0)
    )



class TestBinarySearch(unittest.TestCase):
    def test_main(self):
        test_per(self, binarySearch)
        test_per(self, binarySearch2)

if __name__ == "__main__":
    unittest.main()
