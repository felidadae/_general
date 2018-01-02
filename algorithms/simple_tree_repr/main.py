def fun(node, is_root=False):
    if not node:
        return ""
    r = str(node.val)
    if not node.left amd node.right:
        r += "()" + fun(note.right)
    else:
        r += fun(node.left) + fun(node.right)
    if not is_root:
        r = '(' + r + ')'
    return r
