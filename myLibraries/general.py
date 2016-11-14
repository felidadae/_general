import codecs
import sys
import re

def readFileIntoList(fp):
	"""
	read lines with stripped left right whitespaces into list  
	fp <- path to file
	"""
	f_ = codecs.open(fp, 'r', 'utf-8')
	ls = []
	for l in f_:
		l = l.rstrip('\n')
		if l != "":
			ls.append(l.rstrip().lstrip())
	f_.close()
	return ls

def saveListOfListsToTSV(fpout, data):
	"""
	fpout <- file path to out file
	data <- [["..", ".."],..]
	"""
	fout_ = codecs.open(fpout, 'w', 'utf-8')
	for row in data:
		fout_.write("\t".join(row) + "\n")
	fout_.close()

def saveListToFile(fpout, data):
	"""
	fpout <- file path to out file
	data <- ["..", ..]
	"""
	fout_ = codecs.open(fpout, 'w', 'utf-8')
	for row in data:
		fout_.write(row + "\n")
	fout_.close()

def writeLineToFile(f_, l):
	f_.write(str(l)+"\n")

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
