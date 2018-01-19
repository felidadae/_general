costs = {'INSERT': 1, 'REPLACE': 1, 'DELETE': 1} #unmutable dictionary
call_count = {}
def notify_call_count(s1, s2):
    key = "s1={}, s2={}".format(s1,s2)
    if key in call_count: call_count[key] += 1
    else: call_count[key] = 1

NOT_SET=-1
def create_matrix(n,m):
    """
    n <- count of rows
    m <- count of columns
    """
    return [[NOT_SET for x in range(m)] for x in range(n)]
subresults = None

def edit_distance_dynamic(s1, s2, i1=0, i2=0, 
        costs=costs, will_notify_call_count=True):
    '''
    s1,s2 strings to compute edit distance between them
    @returns int (minimal distance between two strings, 
    not minimal could be as big as one wish)
    '''
    global subresults
    global call_count

    #first time
    if i1 == 0 and i2 == 0:
        subresults = create_matrix(len(s1)+1, len(s2)+1)
        call_count = {}

    #check if already computed
    if subresults[i1][i2] != NOT_SET:
        return subresults[i1][i2]

    # just to notify how many times called for the same arguments
    if will_notify_call_count:
        notify_call_count(s1[i1:], s2[i2:])

    #finish recursion smoothly
    if i1 >= len(s1) and i2 >= len(s2): 
        r = 0
    else:
        if i1 >= len(s1) or i2 >= len(s2): 
            r = (len(s1)-i1 if i1 < len(s1) else len(s2) - i2)
        else:
            if s1[i1] == s2[i2]:
                r = edit_distance_dynamic(s1, s2, i1+1, i2+1)
            else:
                r = min( 
                    costs['INSERT']  + edit_distance_dynamic(s1, s2, i1+1, i2),
                    costs['REPLACE'] + edit_distance_dynamic(s1, s2, i1+1, i2+1),
                    costs['DELETE']  + edit_distance_dynamic(s1, s2, i1,   i2+1) 
                )
    subresults[i1][i2] = r
    return r


def edit_distance(s1, s2, costs=costs):
    '''
    s1,s2 strings to compute edit distance between them
    @returns int (minimal distance between two strings, not minimal could be as big as one wish)
    '''
    # just to notify how many times called for the same arguments
    notify_call_count(s1, s2)

    #finish recursion smoothly
    if not s1 and not s2: return 0
    if not s1 or not s2:  return len(s1 if s1 else s2)

    if s1[0] == s2[0]:
        return edit_distance(s1[1:], s2[1:])
    else:
        return min( 
            costs['INSERT']  + edit_distance(s1[1:], s2),
            costs['REPLACE'] + edit_distance(s1[1:], s2[1:]),
            costs['DELETE']  + edit_distance(s1,     s2[1:]) 
        )

import unittest
class TestEditDistance(unittest.TestCase):

    """Test case docstring."""

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_main(self):
        for fun in (edit_distance, edit_distance_dynamic):
            self.assertTrue(fun('kupa', 'dupa') == 1)
            self.assertTrue(fun('zupa', 'zua') == 1)
            self.assertTrue(fun('dupa', 'dupoa') == 1)
            self.assertTrue(fun('dupa', 'dupa') == 0)
            self.assertTrue(fun('', '') == 0)
            self.assertTrue(fun('', 'ab') == 2)
            self.assertTrue(fun('agata', 'szymon') != 3)
            print("\n".join([str(key)+" <----" + str(value) for key,value in call_count.items()]))

if __name__ == "__main__":
    unittest.main()
