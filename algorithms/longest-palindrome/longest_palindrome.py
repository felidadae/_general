class Solution(object):
    def longestPalindrome(self, s):
        """
        :type s: str
        :rtype: str
        """
        if len(s) == 0:
            return ""

        max_l = 1
        max_v = s[0]
        cmax = 0 #curr_max

        for ic in range(1, len(s)-1):
            for ilb in range(1, min(ic+1, len(s)-ic)):
                if s[ic - ilb] == s[ic + ilb]:
                    cmax_l = 1 + 2*ilb
                    if cmax_l > max_l:
                        max_l = cmax_l
                        max_v = s[ic-ilb:ic+ilb+1]
                else:
                    break

        for ic in range(0, len(s)-1):
            for ilb in range(0, min(ic+1, len(s)-ic-1)):
                if s[ic - ilb] == s[ic + 1 + ilb]:
                    cmax_l = 2 + 2*ilb
                    if cmax_l > max_l:
                        max_l = cmax_l
                        max_v = s[ic-ilb:ic+1+ilb+1]
                else:
                    break

        return max_v 



if __name__ == "__main__":
    s = Solution()
    print(s.longestPalindrome("bb"))
    print(s.longestPalindrome("ccc"))
    print(s.longestPalindrome("b"))
    print(s.longestPalindrome("bb"))
