from collections import namedtubple
Edge = namedtubple('Edge', ['vbegin', 'vend', 'weight']
class Graph(object):
	neighbours_ = None
	def __init__(self, NV):
		neighbours_ = [ [] ] * NV # or 
		# neighbours_ = [ {} ] * NV

	def getEdge(v1, v2) -> (Bool, _):
		pass
	
	def setEdge(v1, v2, w):
		pass
	
def bfs(graph: Graph):
	pass
def construct(edges: [Edge]) -> Graph:
	pass
