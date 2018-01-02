import bisect 

class Solution:
    def nextGreatestLetter(self, letters, target):
        """
        :type letters: List[str]
        :type target: str
        :rtype: str
        """
        return letters[bisect.bisect_right(letters, target)] if letters[-1] >= target else letters[0]
