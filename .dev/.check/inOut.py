import codecs
import re
import os

from django.db import IntegrityError, transaction

import datetime
from django.utils import timezone

from tifocus.core.languagesList import languagesList
from tifocus.core.locations import afp__BETA_root

from django.db.models.fields import DateTimeField

from models import AmbigOrt_Word, AmbigOrt_WordsGroup
from accessors import *



#--------------------------------------------------------
#Import
@transaction.atomic
def insertWordsAmbigOrt(words, langCode):
	"""
		@Description
			insert words into database
		@Explanation of code
			1) get all wordDB which should be merged and
				get all wordGroupDB which should be deleted;
			2) create new wordsGroupDB and assign to it all needed wordDB
			3) delete not needed wordsGroupDB
		@Arg 
			@words
				array of strings
	"""
	wordDBs_toMerge = []
	wordsGroupDBs_toMerge = []
	wordDBs_new     = []

	for word in words:
		tmp = get_wordDBs_from_WordS(word, langCode)
		wordDBs_toMerge += tmp
		if len(tmp) != 0:
			for el in tmp:
				wordsGroupDBs_toMerge += (
					get_wordGroupDB_from_wordGroupID(
						el.wordsGroup_id
					)
				)
		else:
			wordDBs_new.append(AmbigOrt_Word(langCode=langCode, word=word))

	wordsGroup__db__new = AmbigOrt_WordsGroup(langCode=langCode)
	wordsGroup__db__new.save()
	
	for wordDB in wordDBs_toMerge:
		wordDB.wordsGroup_id = wordsGroup__db__new.id
		wordDB.save()
	for wordDB in wordDBs_new:
		wordDB.wordsGroup_id = wordsGroup__db__new.id
		wordDB.save()
	for wordGroupDB in wordsGroupDBs_toMerge:
		wordGroupDB.delete()


@transaction.atomic
def importAmbigOrt(fp_TSV, langCode):
	"""
		@Description
			For each line of TSV file
		@returns nothing
	"""
	
	fref = codecs.open(fp_TSV, 'r', 'utf-8')
	for line in fref:
		line = line.rstrip()
		words = re.split("\t+", line)
		insertWordsAmbigOrt(words, langCode)

	fref.close()

@transaction.atomic
def importAllAmbigOrt(fpD_TSVs=afp__BETA_root):
	files = os.listdir(fpD_TSVs)
	for file in files:
		if not "spelling-variants" in file:
			continue

		m = re.search("(\w\w\-\w\w)\.tsv$", file)
		langCode = ""
		if m: langCode = m.group(1)
		else: continue

		importAmbigOrt(fpD_TSVs + "/" + file, langCode)



#Export
@transaction.atomic
def exportAmbigOrt(fp_TSV, langCode):

	"""
		@Description
			1) find all wordsGroup
			2) for all wordsGroup find all words inside
			3) save result to a file
		@arg
		@returns
	"""	
	#(1)
	wordsGroupsDB_ = AmbigOrt_WordsGroup.objects.filter(langCode=langCode)
	if len(wordsGroupsDB_) == 0:	#	If no entries for that language return
		return 						#

	fref = codecs.open(fp_TSV, 'w+', 'utf-8')

	for wordsGroupDB in wordsGroupsDB_:
		#(2)
		words = get_wordGroupS_from_wordsGroupDB(wordsGroupDB)
		for iword, word in enumerate(words):
			#(3)
			if iword == len(words)-1: fref.write(word + "\n")
			else: fref.write(word + "\t")	
	fref.close()

@transaction.atomic
def exportAllAmbiqOrt(fpD_TSVs=afp__BETA_root):
	if not os.path.isdir(fpD_TSVs):
		os.makedirs(fpD_TSVs)
	
	for langCode in languagesList:
		exportAmbigOrt(fpD_TSVs + "/spelling-variants-" + langCode + ".tsv", langCode)			



#Clear
@transaction.atomic
def clearAmbigOrt(langCode):
	"""
		@Description
			Deletes all db rows for a given language
	"""
	wordGroupsDB = getall_wordGroups(langCode)

	for wordGroupDB in wordGroupsDB:
		wordsDB = get_wordDB_from_wordsGroupDB(wordGroupsDB)
		for wordDB in wordsGroup:
			wordDB.delete()
		wordGroupDB.delete()

@transaction.atomic
def clearAllAmbigOrt():
	"""
		@Description
			deletes all rows in db
	"""
	AmbigOrt_Word.objects.all().delete()
	AmbigOrt_WordsGroup.objects.all().delete()
#--------------------------------------------------------




#--------------------------------------------------------
#
#	Code here is general to be used for any table,
#	not containing foreign keys
#

@transaction.atomic
def genericTSVExport(ORMclass, fp_TSV):
	"""
		@Arg
			@ORMclass 
				Class for a DB table created
				in models.py
			@fp_TSV
				path to save exported TSV file
		@Requirements
			-> ORMclass should contain field
			>>exportNames<< being tuple with structure as:
			exportNames = (
				("<fieldName>",  "<TSVcolumnName>" ),
				("<fieldName2>", "<TSVcolumnName2>"),
			)
			Order of columns is the same as in exportNames
			-> Table hasn't got any foreign keys
	"""
	fref = codecs.open(fp_TSV, 'w+', 'utf-8')
	
	fref.write( unicode("\t".join([j for k,j in ORMclass.exportNames]) + "\n", 'utf8') )

	DBobjects = ORMclass.objects.order_by("time_stamp")
	for dbo in DBobjects:
		s = unicode("", 'utf8')
		for f,_ in ORMclass.exportNames:
			#We cover here two cases: str or datetime.datetime
			if type( getattr(dbo, f) ) == datetime.datetime:
				t = getattr(dbo, f)
				timestamp = datetime.datetime.strftime(t, '%Y%m%d%H%M')
				s += unicode(timestamp, 'utf8') + unicode("\t", 'utf8')			
			else:
				s += unicode(getattr(dbo, f)) + unicode("\t", 'utf8')
		s = s[:-1]
		fref.write(s + unicode("\n", 'utf8'))
	fref.close()

@transaction.atomic
def genericTSVImport(ORMclass, fp_TSV, additionalArgs={}, omitFields=[]):
	"""
		@Arg
			@ORMclass 
				Class for a DB table created
				in models.py
			@fp_TSV
				path where save TSV file
			@additionalArgs 
				if some other args are needed but are not located in a TSV file;
		@Requirements
			-> ORMclass should contain field
			>>exportNames<< being tuple with structure as:
			exportNames = (
				("<fieldName>",  "<TSVcolumnName>" ),
				("<fieldName2>", "<TSVcolumnName2>"),
			)
			Order of columns is the same as in exportNames
			-> Table hasn't got any foreign keys
	"""
	fref = codecs.open(fp_TSV, 'r', 'utf-8')

	iline = 0
	for line in fref:
		if iline == 0: 
			iline += 1
			continue

		line = line.rstrip()
		
		splitted = re.split("\t", line )
		i_f=0
		i_s=0
		args = {}
		for f,_ in ORMclass.exportNames:
			if i_f in omitFields:
				i_f = i_f + 1
				continue
			
			if type(ORMclass._meta.get_field(f)) == DateTimeField:
				datefield = datetime.datetime(
					year=int(splitted[i_s][:4]), month=int(splitted[i_s][4:6]), day=int(splitted[i_s][6:8]),
					hour=int(splitted[i_s][8:10]), minute=int(splitted[i_s][10:12]))
				args[f] = datefield
			else:
				args[f] = splitted[i_s]

			i_s = i_s + 1
			i_f = i_f + 1
		
		args.update(additionalArgs)
		newelement = ORMclass( **args )
		newelement.save()
			
	fref.close()

@transaction.atomic
def genericClearAll(ORMclass):
	"""
		@Description
			deletes all rows in db
	"""
	ORMclass.objects.all().delete()
#--------------------------------------------------------


#--------------------------------------------------------
@transaction.atomic
def genericTSVExportForLang(ORMclass, fp_TSV, langCode):
	"""
		@Arg
			@ORMclass 
				Class for a DB table created
				in models.py
			@fp_TSV
				path to save exported TSV file
		@Requirements
			-> ORMclass should contain field
			>>exportNames<< being tuple with structure as:
			exportNames = (
				("<fieldName>",  "<TSVcolumnName>" ),
				("<fieldName2>", "<TSVcolumnName2>"),
			)
			Order of columns is the same as in exportNames
			-> Table hasn't got any foreign keys
	"""
	fref = codecs.open(fp_TSV, 'w+', 'utf-8')
	
	fref.write( unicode("\t".join([j for k,j in ORMclass.exportNames]) + "\n", 'utf8') )

	DBobjects = ORMclass.objects.filter(langCode=langCode).order_by("time_stamp")
	for dbo in DBobjects:
		s = unicode("", 'utf8')
		for f,_ in ORMclass.exportNames:
			#We cover here two cases: str or datetime.datetime
			if type( getattr(dbo, f) ) == datetime.datetime:
				t = getattr(dbo, f)
				timestamp = datetime.datetime.strftime(t, '%Y%m%d%H%M')
				s += unicode(timestamp, 'utf8') + unicode("\t", 'utf8')			
			else:
				s += unicode(getattr(dbo, f)) + unicode("\t", 'utf8')
		s = s[:-1]
		fref.write(s + unicode("\n", 'utf8'))
	fref.close()

@transaction.atomic
def genericTSVExportForAllLang(ORMclass, fp, prefix):
	for lang in languagesList:
		if len(ORMclass.objects.filter(langCode=lang)) > 0:
			genericTSVExportForLang(
				ORMclass, fp + "/" + prefix + lang + ".tsv", lang)

@transaction.atomic
def genericTSVImportForAllLang(ORMclass, fp, prefix):
	def listFunctionsInDirWithPrefix(rootDir, prefix):
		import os
		files = os.listdir(rootDir)
		def fun11 (item):
			if prefix in item:
				return True
			else:
				return False
		filter(fun11, files)
		return files

	paths = listFunctionsInDirWithPrefix(fp, prefix)
	for path in paths:
		genericTSVImport(ORMclass, fp + "/" + path)
#--------------------------------------------------------



#---------------------------------------------------------
@transaction.atomic
def genericClearForLang(ORMclass, langCode):
	"""
		@Description
			deletes all rows in db
	"""
	ORMclass.objects.filter(langCode=langCode).delete()
#---------------------------------------------------------