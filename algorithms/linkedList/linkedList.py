class Node:
	def __init__(self, value = None, next = None):
		self.value = value
		self.next = next
	def __str__ (self):
		return str(self.value)

def displayList(node):
	#pre
	itnode = node
	print itnode
	#loop
	while itnode.next != None:
		itnode = itnode.next
		print itnode



class List:
	def __init__(self, head = None):
		self.head = head
		
	def __str__(self):
		result = ""
		result += "List: \n"

		#pre
		itnode = self.head
		result += str(itnode) + "\n"
		#loop
		while itnode.next != None:
			itnode = itnode.next
			result += str(itnode) + "\n"
		result += "\n"
		return result

	def reverse(self):
		if not self.head:
			return

		stack = []
		it = self.head
		while it != None:
			stack.append(it)
			it = it.next

		#pre
		it = stack.pop()
		self.head = it

		while len(stack) > 1:
			it.next = stack[-1]
			it = stack.pop()

		#post
		it.next = stack[0]
		it.next.next = None



if __name__ == '__main__':
	node0 = Node(0)
	node0.next = Node(1)
	node0.next.next = Node(2)

	myList = List(node0)
	print myList
	myList.reverse()
	print myList

	


