def findCountryRegion(x,y, visited, A, colorIn = -1):
	""" returns 0 already visited, 1 if not visited"""

	if x < 0 or y < 0 or x >= len(visited) or y >= len(visited[0]):
		return 0

	if visited[x][y]:
		return 0
	else:
		visited[x][y] = True
		color = A[x][y]
		if colorIn == color or colorIn == -1:
			findCountryRegion(x+1,y, visited, A, color)
			findCountryRegion(x-1,y, visited, A, color)
			findCountryRegion(x,y+1, visited, A, color)
			findCountryRegion(x,y-1, visited, A, color)
		return 1

def printLine(): 
	print ""
def print2D(A):
    for row in A:
		print (row)
	printLine()

def solution(A):
    visited = []
    for row in A:
        _row = []
        for element in row:
            _row.append( False )
        visited.append(_row)
	
	NCountry = 0
	for x, row in enumerate(A):
		for y, element in enumerate(row):
			ifNew = findCountryRegion(x,y, visited, A)
			NCountry += ifNew 
			if ifNew == 1:
				print2D(visited)
			
    
    return NCountry 

if __name__ == "__main__":
	print solution([[5, 4, 4], [4, 3, 4], [3, 2, 4], [2, 2, 2], [3, 3, 4], [1, 4, 4], [4, 1, 1]])
