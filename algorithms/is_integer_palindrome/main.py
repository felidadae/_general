class Solution(object):
    def isPalindrome(self, x):
        """
        :type x: int
        :rtype: bool
        """
        if x < 0:
            return False
        if x == 0:
            return True

        max = 0 
        while x / 10 ** max >= 1:
            max += 1
        max -= 1

        kmax = int ((max+1)/2)

        for k in range(0, kmax + 1):
            if int(x/10**(max-k))%10 != int(x/10**k)%10:
                return False
        return True

if __name__ == "__main__":
    s = Solution()
    print(s.isPalindrome(123))
    print(s.isPalindrome(0))
    print(s.isPalindrome(1))
    print(s.isPalindrome(121))
    print(s.isPalindrome(1222))
    print(s.isPalindrome(1221))
    print(s.isPalindrome(125521))
