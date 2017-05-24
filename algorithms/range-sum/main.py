#-----------------------------------------------------------------------------
class Node:
	childL=None
	childR=None
	parent=None
	v=None
	def __init__(self, childL, childR, v):
		self.childL=childL
		self.childR=childR
		if self.childL is not None:
			self.childL.parent = self
		if self.childR is not None:
			self.childR.parent = self
		self.v=v

def buildtree(a):
	roots = [Node(None, None, ia) for ia in a]
	while len(roots) > 1:
		nroots = []
		for i in range(0, int(len(roots)/2)):
			k=2*i; l=2*i+1;
			parent = Node(roots[k], roots[l], roots[k].v+roots[l].v)
			nroots.append(parent)
		if len(roots)%2==1:
			nroots.append(roots[-1])
		roots = nroots
	return roots
#-----------------------------------------------------------------------------


def tree_to_str(root):
	if root is None: 
		return "*"
	return (
		str(root.v) + 
		" (" + tree_to_str(root.childL) + ", " + 
		tree_to_str(root.childR) + ")")

		print (tree_to_str(buildtree([1,-1,2,-2])[0]))
print (tree_to_str(buildtree([1,-1,2,-2,3])[0]))
