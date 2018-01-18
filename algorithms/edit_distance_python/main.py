costs = {'INSERT': 1, 'REPLACE': 1, 'DELETE': 1} #unmutable dictionary
call_count = {}
def notify_call_count(s1, s2):
    key = "s1={}, s2={}".format(s1,s2)
    if key in call_count:
        call_count[key] += 1
    else:
        call_count[key] = 1

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
        # self.assertTrue(edit_distance('kupa', 'dupa') == 1)
        # self.assertTrue(edit_distance('zupa', 'zua') == 1)
        # self.assertTrue(edit_distance('dupa', 'dupoa') == 1)
        # self.assertTrue(edit_distance('dupa', 'dupa') == 0)
        # self.assertTrue(edit_distance('', '') == 0)
        # self.assertTrue(edit_distance('', 'ab') == 2)
        self.assertTrue(edit_distance('kupa', 'kupkowa') == 3)
        print(call_count)

if __name__ == "__main__":
    unittest.main()
