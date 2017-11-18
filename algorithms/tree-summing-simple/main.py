class TreeNode:
    def __init__(self, val):
        self.val = val
        self.left = None
        self.right = None
    def __repr__(self):
        left_child = self.left.val if self.left else "X"
        right_child = self.right.val if self.right else "X"
        return "Val {}. Child left {}. Child right {}.".format(
            self.val, left_child, right_child)


def build_tree(expr):
    #[5,4,8,11,null,13,4,7,2,null,null,5,1]
    root = TreeNode(expr[0])
    leafs = [root]
    counter = 0
    for e in expr[1:]:
        if e is not None:
            leafs.append(TreeNode(e))

        if counter == 0:
            if e is not None:
                leafs[0].left = leafs[-1]
        else:
            if e is not None:
                leafs[0].right = leafs[-1]
            leafs.pop(0)

        counter = (counter+1) % 2
    
    return root


def print_tree(root):
    leafs = [root]
    while leafs:
        oldest_leaf = leafs.pop(0)
        if oldest_leaf.left is not None:  leafs.append(oldest_leaf.left)
        if oldest_leaf.right is not None: leafs.append(oldest_leaf.right)
        print(oldest_leaf)
    return


class Solution:
    def pathSum(self, root, sum):
        n = 0
        v = root.val if root else None
        stack = [([], root)]
        while stack:
            sums_, node_ = stack.pop()
            if node_ != None:
                v = node_.val
                sums_ = [el + v for el in sums_] + [v]
                if sum in sums_:
                    n += sums_.count(sum)
                stack.append( (list(sums_), node_.left ) )
                stack.append( (list(sums_), node_.right) )
        return n


if __name__ == "__main__":
    root = build_tree([5, 4, 8, 11, None, 13, 4, 7, 2, None, None, 5, 1])
    s = Solution()
    ret = s.pathSum(root, 22)
    print(ret)
