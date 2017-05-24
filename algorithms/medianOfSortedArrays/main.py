def solution(a, b):
	#
	# checkIfEmpty or sth
	#

	if a.len() > b.len():
		bigger  = a
		smaller = b
	else:
		bigger = b
		smaller= a

	# find median
	# 7; 3 1 3; 7/2=3 a[3]; a/2;
	# 8; 3 2 3; 8/2=4 a[3], a[4]; len(a)/2-1. len(a)/2;
	# even 2n
	# odd 2n+1
	#	even: l/2-1, l/2
	#	odd:  l/2
	# ..... m1 m2 .......
	# .. m1 ..
	# 
	medianBigger = bigger[bigger.len()/2]

	
	 
import unittest
class TestClass(unittest.TestCase):
	def setUp(self):
		pass
	def tearDown(self):
		pass
	def test_name(self):
		self.assertEquals(solution([0,2,4,6,8], [1,3,5,7]), 4)
		self.assertEquals(solution([0,2,4,6,8], [1,3,5]), 4)
