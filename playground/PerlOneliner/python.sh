rm -f test
echo -e "head0${TAB}head1${TAB}head2${TAB}head3" >> test
echo -e "col0${TAB}col1${TAB}col2${TAB}col3" >> test
echo -e "cola${TAB}colb${TAB}colc${TAB}cold" >> test

S='
import sys

headers = {}
for il,l in enumerate(sys.stdin.readlines()):
	l = l.rstrip()
	l = l.split("\t")
	if il == 0:
		for ih,header in enumerate(l):
			headers[header] = ih
	else:
		if l[headers["head0"]] == "col0":
			print(".".join(l))
'

cat test | python3 -c ' 
import sys

headers = {}
for il,l in enumerate(sys.stdin.readlines()):
	l = l.rstrip()
	l = l.split("\t")
	if il == 0:
		for ih,header in enumerate(l):
			headers[header] = ih
	else:
		if l[headers["head0"]] == "col0":
			print(".".join(l))
' \
| perl -F'\.' -lane 'print $F[1];'

cat test | python3 -c "$S"
