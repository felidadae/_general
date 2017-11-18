class Solution:
    self._max = 0
    def longestUnivaluePath(self, root):
        self.longest_path(root)
        return self._max
    
    def longest_path(self, root):
        if root is None:
            return 0

        open_left = self.longest_path(root.left)
        open_right = self.longest_path(root.right)

        val = root.val
        val_left = root.left.val if root.left is not None else None
        val_right = root.right.val if root.right is not None else None
        all_left = open_left + 1 if root.left is not None and root.left.val == root.val else 1
        all_right = open_right + 1 if root.right is not None and root.right.val == root.val else 1
        all_up = max(all_left, all_right)

        open_max = all_left + all_right - 1
        self._max = open_max if open_max > _max else self._max

        return all_up
