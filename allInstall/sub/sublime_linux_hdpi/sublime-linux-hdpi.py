import os

ls = os.listdir(".")

for l in ls:
	if "@2x" in l:
		if "folder" in l:
			l2 = l.replace("@2x", "")
			os.remove(l2)
			os.rename(l, l2)
		if "icon" in l:
			l2 = l.replace("@2x", "")
			os.remove(l2)
			os.rename(l, l2)
		if "tab-close" in l:
			l2 = l.replace("@2x", "")
			os.remove(l2)
			os.rename(l, l2)
		if "group-" in l:
			l2 = l.replace("@2x", "")
			os.remove(l2)
			os.rename(l, l2)
		if "tabset-list" in l:
			l2 = l.replace("@2x", "")
			os.remove(l2)
			os.rename(l, l2)
		if "fold-" in l:
			l2 = l.replace("@2x", "")
			os.remove(l2)
			os.rename(l, l2)
		if "tab-highlight-" in l:
			l2 = l.replace("@2x", "")
			os.remove(l2)
			os.rename(l, l2)
		if "tab-dirty" in l:
			l2 = l.replace("@2x", "")
			os.remove(l2)
			os.rename(l, l2)
		if "tabset-" in l:
			l2 = l.replace("@2x", "")
			os.remove(l2)
			os.rename(l, l2)
			