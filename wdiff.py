import re

COMMON=0
DELETED=1
INSERTED=2
BEFORE_FIRST=-1

def increasingPairs(m_):
	for limit in range(m_):
		for i in range(limit):
			yield (limit, i)
			yield (i, limit)
		yield (limit, limit)

def compare(s1, s2, resultRepr="I", splittingRegex="\s+"):
	"""
	s1, s2 strings in
	resultRepr <- {"string", "I", "G"}
		I (type, word)
		G (type, [word,word..])
		string "[- deleted -] common common {+ inserted +}"
	"""
	s1 = re.split(splittingRegex, s1 )
	s2 = re.split(splittingRegex, s2 )
	result = []

	N1, N2 = (len(s1), len(s2))

	i1, i2 = (0,0)
	while i1 < N1 and i2 < N2:
		if s1[i1] == s2[i2]:
			result.append((COMMON, s1[i1]))
			i1 += 1
			i2 += 1
			continue

		ifEnd = True
		for offset1, offset2 in increasingPairs(min(N1-i1, N2-i2)):
			if s1[i1+offset1] == s2[i2+offset2]: 
				deleted = ((DELETED,      item) for item in s1[i1:i1+offset1])
				inserted= ((INSERTED, item) for item in s2[i2:i2+offset2])
				result.extend(deleted)
				result.extend(inserted)
				i1 += offset1
				i2 += offset2
				ifEnd = False
				break
		if ifEnd:
			deleted = ((DELETED,      item) for item in s1[i1:])
			inserted= ((INSERTED, item) for item in s2[i2:])
			result.extend(deleted)
			result.extend(inserted)
			break

	if resultRepr=="I":
		return result
	elif resultRepr=="G":
		return cast_I_to_G(result)
	else:
		return cast_G_to_string(
			cast_I_to_G(result))

def cast_I_to_G(I_repr):
	groups = []
	group = (0, []) 
	prev_t=BEFORE_FIRST
	for t, w in I_repr:
		if t != BEFORE_FIRST and t != prev_t:
			#close the group and open a new one
			groups.append(group)
			group = (t, [w])
		else:
			group[1].append(w)
		prev_t=t
	return groups

def cast_G_to_string(G_repr):
	result = unicode("", 'utf8')
	for group in G_repr:
		typew, words = group 
		if typew == COMMON:
			result += " ".join(words)
		elif typew == INSERTED:
			result += "{+" + " ".join(words) + "+}"
		elif typew == DELETED:
			result += "[-" + " ".join(words) + "-]"
		else:
			pass
	return result




if __name__ == "__main__":
	print(	compare("man je drozdze", "man je drozdze")  )
	print(	compare("man je drozdze", "man je kupe")  )
	print(	compare("", "")  )
	print(	compare("man je drozdze ale dobra dupa", "man je zupe ale dobra zupa")  )
	print(	compare("je drozdze ale dobra dupa", "man je zupe ale dobra zupa")  )
