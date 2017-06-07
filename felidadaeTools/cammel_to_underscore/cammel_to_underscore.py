#!/usr/bin/python3
"""
    @Test usage:
    python3 cammel_to_underscore.py <(echo -e 'zupaDupa = 15\nmojPies = 13\nfun(zupaDupa, mojPies)')

"""

import fileinput
import tempfile
import re
import os

vars_ = []
tmp = tempfile.mktemp()
with open(tmp, 'w') as fref_tmp:
    for line in fileinput.input():
        fref_tmp.write(line)
        s = re.search("^\s*([a-zA-Z_]+)\s*=", line)
        if not s: continue
        vars_.append(s.group(1))
    fileinput.close()

def filtered(var_):
    result = ""
    for i, ch in enumerate(var_):
        if ch.isupper() and i != 0:
            result += "_" + ch.lower()
        else:
            result += ch.lower()
    return result
            
with open(tmp, 'r') as fref_tmp:
    for l in fref_tmp:
        l = l.rstrip()
        for var_ in vars_:
            l = (re.sub("(^|(?<=[\s\(]))" + var_ + "(?=[\s\.,\)])", filtered(var_), l))
        print(l)
        
os.remove(tmp)
