k = (1,2,3)
k.index(2)

class Dupa:
    k = 18
    def __init__(self):
        self.a = 8
        self.b = 10
        self.c = 12

    @staticmethod
    def get_shit():
        return "zupeczka"

    def get_all(my_name):
        return my_name

d = Dupa()
print(d.a)
print(d.b)

k = (1,2,3,4)
a,b,*c,d,e,f = k

kk = [ ("zupa", 8), ("abc", 88), ("bcd", 58), ("abc", 58) ]
kk.sort(key=lambda el: (el[1], el[0]), reverse=False)
print(kk)

kkk = [ "abc", "dupa", "ziemia", "moj pan" ]
kkk.sort()

import bisect
a = [0,1,2,3,5,6]
el = 4
index = bisect.bisect_left(a, 4)
print(bisect.bisect_left(a, 10))
a.insert(index, 4)
print(a)
print(a[index])

k = [1,2]
k.insert(1, 0)
print(k)

import array
a = array.array('f', [1.0, 2.0, 3.0, 4.0])

import re
import reprlib
RE_WORD = re.compile('\w+')

class Sentence:
    def __init__(self, text):
        self.text = text
        self.words = RE_WORD.findall(text)

    def __repr__(self):
        return 'Sentence(%s)' % reprlib.repr(self.text)

    def __iter__(self):
        for word in self.words:
            yield word
        return

s = Sentence("pan marian ma sixy")
for word in s:
    print(word)
