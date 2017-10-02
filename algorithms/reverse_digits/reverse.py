class Solution(object):
    def reverse(self, x):
        """
        :type x: int
        :rtype: int
        """
        reversed_a = []
        tmp = x if x > 0 else -x
        while tmp != 0:
            carry = tmp % 10
            reversed_a.append(carry)
            tmp = int((tmp-carry)/10)
        
        reversed=0
        for digit in reversed_a:
            reversed = digit + reversed * 10

        reversed = reversed if x > 0 else -reversed
        return reversed

if __name__ == "__main__":
    s = Solution()
    print(s.reverse(0))
    print(s.reverse(300))
    print(s.reverse(30003))
    print(s.reverse(123))
    print(s.reverse(587))
    print(s.reverse(-587))
