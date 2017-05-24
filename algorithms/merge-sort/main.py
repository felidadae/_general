def merge(a, b):
	#init
	ia, ib, Na, Nb, ab = (0,0,len(a), len(b), [])
	while ia < Na and ib < Nb:
		if a[ia] < b[ib]:
			ab.append(a[ia])
			ia += 1
		else:
			ab.append(b[ib])
			ib += 1
	ab.extend(a[ia:] + b[ib:])
	return ab

def mergeSort(a, lo, hi):
	if lo >= hi-1:
		return [a[lo]]
	m = int((lo+hi)/2)	#(right)middle one
	return merge( mergeSort(a, lo, m), mergeSort(a, m, hi))
	

import unittest
class Test (unittest.TestCase):
	def test_merge(self):
		self.assertEquals(
			[0,1,2,5,7,10],
			(merge([1,5,7], [0,2,10]))
		)		
		self.assertEquals(
			[0,1,2,5,7],
			(merge([1,5,7], [0,2]))
		)		
		self.assertEquals(
			[0,1],
			(merge([1], [0]))
		)		
		self.assertEquals(
			[0],
			(merge([], [0]))
		)		
		self.assertEquals(
			[],
			(merge([], []))
		)		
	def test_mergeSort(self):
		self.assertEquals(
			[1,2,3,4],
			mergeSort([3,1,2,4], 0, 4)
		)
