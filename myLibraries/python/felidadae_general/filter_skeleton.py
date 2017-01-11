import codecs
import sys
import re

def main_filter(inN, outN):
	"""
	Usage:
	from general import main_filter, main_filter_clean

	in_, out_, params_ = main_filter(inN, outN)
	...
	main_filter_clean(in_, out_)
	"""
	in_ = []
	out_= []
	params_=[]
	argv_ = sys.argv[1:]
	for i in range(0, inN):
		in_.append(codecs.open(argv_[i], 'r', 'utf-8'))
	for i in range(inN, inN+outN):
		out_.append(codecs.open(argv_[i], 'w', 'utf-8'))
	for i in range(inN+outN, len(argv_)):
		params_.append(argv_[i])
	return (in_, out_, params_)
def readLines(fs):
	return [ f_.readline().rstrip() for f_ in fs ]
def main_filter_clean(in_, out_):
	for fs in [in_, out_]:
		for f in fs:
			f.close()
