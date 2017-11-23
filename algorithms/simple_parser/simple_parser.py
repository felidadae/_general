# """
# This is the interface that allows for creating nested lists.
# You should not implement it, or speculate about its implementation
# """
#class NestedInteger:
#    def __init__(self, value=None):
#        """
#        If value is not specified, initializes an empty list.
#        Otherwise initializes a single integer equal to value.
#        """
#
#    def isInteger(self):
#        """
#        @return True if this NestedInteger holds a single integer, rather than a nested list.
#        :rtype bool
#        """
#
#    def add(self, elem):
#        """
#        Set this NestedInteger to hold a nested list and adds a nested integer elem to it.
#        :rtype void
#        """
#
#    def setInteger(self, value):
#        """
#        Set this NestedInteger to hold a single integer equal to value.
#        :rtype void
#        """
#
#    def getInteger(self):
#        """
#        @return the single integer that this NestedInteger holds, if it holds a single integer
#        Return None if this NestedInteger holds a nested list
#        :rtype int
#        """
#
#    def getList(self):
#        """
#        @return the nested list that this NestedInteger holds, if it holds a nested list
#        Return None if this NestedInteger holds a single integer
#        :rtype List[NestedInteger]
#        """

class Solution:
    def deserialize(self, s):
        """
        :type s: str
        :rtype: NestedInteger
        """
        parser = Parser()
        return parser.parse(s)
        
class Parser:
    def parse(self, s):
        self.position = 0
        self.formula = s
        self.root = None 
        self.nested_stack = []

        while self.position != len(self.formula):
            if self.formula[self.position] == '[':
                new = NestedInteger()
                if self.nested_stack:
                    self.nested_stack[-1].add(new)
                else:
                    self.root = new
                self.nested_stack.append(new)
                self.position += 1
            elif self.formula[self.position] == ']':
                self.nested_stack.pop()
                self.position += 1
            elif self.formula[self.position] == ',':
                self.position += 1
            elif self.find_integer_bound() != self.position:
                new = NestedInteger()
                right_bound = self.find_integer_bound()
                integer = int(self.formula[self.position:right_bound])
                new.setInteger(integer)
                if self.nested_stack:
                    self.nested_stack[-1].add(new)
                else:
                    self.root = new
                self.position += right_bound - self.position

        return self.root

    def find_integer_bound(self):
        pos_ = self.position
        while pos_ < len(self.formula) and re.match("[0-9-]", self.formula[pos_]):
            pos_ += 1
        return pos_
