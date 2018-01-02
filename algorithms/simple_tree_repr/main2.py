class Solution:
    def repeatedSubstringPattern(self, s):
        """
        :type s: str
        :rtype: bool
        """
        if len(s) == 0: return False
        for pattern_length in range(1, int(len(s)/2)+1):
            if len(s)%pattern_length != 0: continue
            is_multiply_pattern = True 
            for pattern_walker in range(pattern_length):
                walker = pattern_walker + pattern_length
                while walker < len(s):
                    if s[walker] != s[pattern_walker]:
                        is_multiply_pattern = False
                        break
                    walker += pattern_length

                if not is_multiply_pattern:
                    break
            if is_multiply_pattern: return True 
        return False
        
