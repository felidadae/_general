import itertools

def is_region_surronded(ix, iy, board):
    def is_border_(node):
        (ix, iy) = node
        return ix == len(board)-1 or ix == 0 or iy == len(board[0])-1 or iy == 0
    def is_border(nodes):
        return any([ is_border_(node) for nodes in nodes])
    
    nodes = [(ix, iy)]
    while nodes:
        nodes = [ node_ for node_ in ((ix+1, iy), (ix-1, iy), (ix , iy+1), (ix, iy-1)) for (ix, iy) in nodes ]

def solve(board):
    """
    :type board: List[List[str]]
    :rtype: void Do not return anything, modify board in-place instead.
    """
    for ix, iy in itertools.product(range(len(board)), range(len(board[0]))):
        print("{}:{}".format(ix, iy))
        if board[ix][iy] == 'O':
            if is_region_surronded(ix, iy, board):
                surrond_region(ix, iy, board) 
    return board


if __name__ == "__main__":
    in_ = [['O','O','O'],['O','1','O'], ['O','O','O']]
    solve(in_)
    print(in_)
