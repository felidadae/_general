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
