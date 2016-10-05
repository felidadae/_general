import os

ls = os.listdir(".")

for l in ls:
	if "@3x" in l:
		l2 = l.replace("@3x", "")
		os.remove(l2)
		os.rename(l, l2)
