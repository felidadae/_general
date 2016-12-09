def increasingPairs(m_):
	for limit in range(m_):
		for i in range(limit):
			yield (limit, i)
			yield (i, limit)
		yield (limit, limit)

def wdiff(s1, s2):
	result = []

	N1, N2 = (len(s1), len(s2))
	it1, it2 = (0,0)
	while it1 < N1 and it2 < N2:
		if s1[it1] == s2[it2]:
			it1 += 1
			it2 += 1
			result.append(s1[it1])
			continue

		for offset1, offset2 in increasingPairs():
			if s1[it1+offset1] == s2[it2+offset2]:
				result.append( (DEL, item) )
				it1 += offset1
				it2 += offset2
				break


	
	
import unittest
from wdiff import *

class Testwdiff (unittest.TestCase):
	def test_main(self):
		increasingPairs()	
