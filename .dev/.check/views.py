
import os
import sys
from django.http import HttpResponse
from django.shortcuts import render
from django.views.decorators.csrf import csrf_exempt
from django.utils.encoding import uri_to_iri 

import subprocess
import sys
import logging
import os
import re
from xml.etree.ElementTree import Element, SubElement, Comment, tostring
import inspect
from ipware.ip import get_ip

import tifocus.core.managers.dictionaryUpdatesManager as dictionaryUpdatesManager
import tifocus.core.managers.InputManager as InputManager
import tifocus.core.managers.betaNotificationManager as betaNotificationManager
import tifocus.core.managers.suggestionsManager as suggestionsManager
import tifocus.core.managers.phentriesValidationManager as phentriesValidationManager



#******************************************************************
def cleanFaceOfUnicode(unn):
	unn = unn.replace(u'\xa0', u' ')
	unn = re.sub("\s+", " ", unn, re.UNICODE)
	unn = unn.strip()
	return unn

logger = logging.getLogger(__name__)
def myloggin(request, functionName, postfunStr):
	argumentsIn = ""
	for key in request.GET.keys():
		argumentsIn = argumentsIn + key + ": " + request.GET[key] + ", "

	logger.info( get_ip(request) + "\t" + 
		functionName + "::" + postfunStr + "\t" + "{" + argumentsIn + "}" )
#******************************************************************



#------------------------------------------------------------------
def index(request):
	return render( request,
		"tifocus/index.html"
	)
#------------------------------------------------------------------



#------------------------------------------------------------------
def chooseFile(request):
	"""
		show lists of available files
	"""

	def fun1(item1, item2):
		if item1[0] > item2[0]:
			return True
		if item1[0] < item2[0]:
			return False

		s = re.search(".*curr_R.*?\-(\d{8})", item1[1])
		if s: item1_ = s.group(1)
		s = re.search(".*curr_R.*?\-(\d{8})", item2[1])
		if s: item2_ = s.group(1)

		print item1_
		print item2_
		print int(item1_) > int(item2_)
		print "***"

		return -1*cmp(int(item1_), int(item2_))

	#[[langCode, filename], [langCode, filename] ... ]
	filesListPairs = InputManager.listAvailableFiles()
	filesListPairs.sort(cmp=fun1)

	return render( request,
		"tifocus/chooseFile.html", 
		{
			'filesListPairs': filesListPairs
		}
	)
#------------------------------------------------------------------



#------------------------------------------------------------------
def showFile(request):
	"""
		return choosen file; precisely part 0 of the file;
	"""
	choice = request.POST.get('choice', '')
	r_ = re.split("###", choice)
	languageCode = r_[0]
	fileName     = r_[1]

	#	One important thing, prepare all needed files
	#	in dictionariesContent
	dictionaryUpdatesManager.createDictionaries(languageCode)
	
	content = InputManager.getFile(
		languageCode=languageCode,
		fileName=fileName,
		partNumber=0
	)

	return HttpResponse( content )

@csrf_exempt
def showPartOfFile(request):
	""" 
		return choosen part of a file;
	"""
	languageCode = request.POST.get('languageCode', '')
	fileName 	= request.POST.get('fileName', '')
	partNumber 	= request.POST.get('partNumber', '')
	partNumber  = int(partNumber.strip())
	
	content = InputManager.getFile(
		languageCode=languageCode, 
		fileName=fileName, 
		partNumber=partNumber
	)

	return HttpResponse( content )

@csrf_exempt
def showFileWithSearchResults(request):
	languageCode = request.POST.get('languageCode', '')
	fileName 	 = request.POST.get('fileName', '')
	wordToSearch = request.POST.get('wordToFind', '')

	import ipdb; ipdb.set_trace()

	from tifocus.core.managers.XMLDividerManager import splitXML__containingWord_
	from tifocus.core.managers.HTMLRendererManager import renderDiff_oneFile
	
	XMLsearchResult = splitXML__containingWord_(languageCode, fileName, wordToSearch)
	renderDiff_oneFile(languageCode, XMLsearchResult, "tmp.html")
	os.remove(XMLsearchResult)

	import codecs
	fref = codecs.open("tmp.html", 'r', 'utf-8')
	fContent = fref.read()
	fref.close()

	return HttpResponse(fContent)
#------------------------------------------------------------------



#------------------------------------------------------------------
def editEntry(request):
	"""
		add or delete entry 
		from deletion or insertion dictionary

		state of word -> state BEFORE doing THAT operation;
		we guess what to do from its current state;

		dictionaryUpdatesManager.update
	"""
	myloggin(request, inspect.stack()[0][3], "START")

	languageCode 	= request.GET.get('languageCode', '')
	state 			= request.GET.get('state', '')
	word 			= request.GET.get('word', '')
	forms 			= request.GET.get('forms', '')
	oldForms		= request.GET.get('oldForms', '')

	forms = cleanFaceOfUnicode(forms)
	oldForms = oldForms.split("*")

	#
	#	Process word to utf8 from ansi form which do 
	#	not support utf8 
	#	for example: 
	#		u'f\xfcr' -> fr
	#
	word = uri_to_iri(word)

	#	If a form removed and wants to be reinserted
	if (state == "removed"):
	 	returnCode = \
	 		dictionaryUpdatesManager.update(
	 			languageCode, word, forms, oldForms,
	 			"deletion", "deletionDictionary")

	#	If wants to delete form
	if (state == "zero"):
	 	returnCode = \
	 		dictionaryUpdatesManager.update(
	 			languageCode, word, forms, oldForms,
	 			"insertion", "deletionDictionary")

	#	If changed mind and wants to remove added form
	if (state == "added"):
		returnCode = \
	 		dictionaryUpdatesManager.update(
	 			languageCode, word, forms, oldForms,
	 			"deletion", "insertionDictionary")

	#	If wants to add new form
	if (state == "before-adding"):
		#We want to assure that there are only
		#allowed phones;
		result = phentriesValidationManager.validateForm(forms, languageCode)
		if result[0] == False:
			return HttpResponse("I'm afraid your form cannot be added." 
				"You have used unrecognizable phone (" + result[1] + ")."
				"Check the phoneset for your language.")
		returnCode = \
	 		dictionaryUpdatesManager.update(
	 			languageCode, word, forms, oldForms,
				"insertion", "insertionDictionary")

	myloggin(request, inspect.stack()[0][3], "END__")

	return HttpResponse("OK")


def currentStateForWord(request):
	languageCode 	= request.GET.get('languageCode', 	'')
	word 			= request.GET.get('word', 			'')
	sentenceA		= request.GET.get('sentenceA',		'')
	sentenceB		= request.GET.get('sentenceB',		'')
	recordingURL 	= request.GET.get('recordingURL', 	'')

	sentenceA = cleanFaceOfUnicode(sentenceA)
	sentenceB = cleanFaceOfUnicode(sentenceB)

	m = (re.search( '(asr[^\/]*).*\/((\d|\-)+).wav', 
		recordingURL));
	corpusname = m.group(1);
	FileID     = m.group(2);

	entriesInserted = dictionaryUpdatesManager.read(
		languageCode, word.lower(), "insertionDictionary")
	entriesRemoved  = dictionaryUpdatesManager.read(
		languageCode, word.lower(), "deletionDictionary")
	BETAnotification= betaNotificationManager.checkIfNotified(
		corpusname, FileID, languageCode,
		word, sentenceA, sentenceB)

	stateXML = Element('state')
	insertedXML = SubElement(stateXML, 'inserted')
	for item in entriesInserted:
		entry = SubElement(insertedXML, 'form')
		entry.text = item
	removedXML  = SubElement(stateXML, 'removed')
	for item in entriesRemoved:
		entry = SubElement(removedXML, 'form')
		entry.text = item
	notificationXML = SubElement(stateXML, 'BETAnotification')
	entry = SubElement(notificationXML, 'ambigOrt')
	entry.text = str(BETAnotification["ambigOrt"])
	entry = SubElement(notificationXML, 'wrongRef')
	entry.text = str(BETAnotification["wrongRef"])
	entry = SubElement(notificationXML, 'mismatchRecording')
	entry.text = str(BETAnotification["mismatchRecording"])
	print tostring(stateXML)

	return HttpResponse(  tostring(stateXML)  )

def suggestions(request):
	languageCode 	= request.GET.get('languageCode', '')
	word 			= request.GET.get('word', '')

	suggestions = suggestionsManager.suggestionsFrom_enUS_enGB(
		languageCode, word
	)

	root = Element('suggestions')
	for suggestion in suggestions:
		child = SubElement(root, 'suggestion')
		child.text = suggestion

	s = tostring(root)
	return HttpResponse(s)
#------------------------------------------------------------------
		


#------------------------------------------------------------------
def chooseUpdatesToPush(request):
	return render( request,
		"tifocus/chooseLanguage.html", 
		{'langaugesAvailable': 
			dictionaryUpdatesManager.listLangaugesWithUpdates()
		}
	)

def pushUpdates(request):
	style = ("<style>" 
		+ "body {background-color:black; color: white;}" 
		+ "</style>")

	languageCode = request.POST.get('choice', '')
	if languageCode == "":
		return HttpResponse(style + "<h1>No Language choosen</h1>") 

	dictionaryUpdatesManager.push(languageCode)	
	
	return HttpResponse(style+ "<h1>Updates for " + 
		languageCode + " pushed</h1>")
#------------------------------------------------------------------



#------------------------------------------------------------------
def notifyWrongRef(request):
	"""
		SpeechDBName
		FileID
		IncorrectReference
		Corrected reference
	"""

	myloggin(request, inspect.stack()[0][3], "START")

	languageCode 	= request.GET.get('languageCode', '')
	recordingURL	= request.GET.get('fullRecordingURL', '')
	wrongRef 		= request.GET.get('wrongRef', '')
	correctedRef	= request.GET.get('correctedRef', '')
	needsVerification = request.GET.get('needsVerification', '')
	globallySafe 	  = request.GET.get('globallySafe', '')

	wrongRef= cleanFaceOfUnicode(wrongRef)
	correctedRef= cleanFaceOfUnicode(correctedRef)

	if needsVerification == "":
		needsVerification="False"
	if globallySafe == "":
		globallySafe="False"

	m = (re.search( '(asr[^\/]*).*\/((\d|\-)+).wav',
		recordingURL));
	corpusname = m.group(1);
	fileid     = m.group(2);

	betaNotificationManager.wrongRef(
		languageCode,
		corpusname,
		fileid,
		wrongRef,
		correctedRef,
		needsVerification,
		globallySafe
	)

	myloggin(request, inspect.stack()[0][3], "END__")

	return HttpResponse("OK")

def notifyMismatchRecording(request):
	"""
		If recording does not match a reference (some BETA problems);
	"""
	myloggin(request, inspect.stack()[0][3], "START")
	
	languageCode 	= request.GET.get('languageCode', '')
	recordingURL	= request.GET.get('fullRecordingURL', '')

	m = (re.search( '(asr[^\/]*).*\/((\d|\-)+).wav',
		recordingURL));
	corpusname = m.group(1);
	fileid     = m.group(2);

	betaNotificationManager.mismatchRecording(
		languageCode, corpusname, fileid)

	myloggin(request, inspect.stack()[0][3], "END__")
	return HttpResponse()

	
def notifyAmbigOrt(request):
	"""
		Variant1 
		Variant2 
		Variant3 
		...
	
		variants splitted with tab
	"""
	myloggin(request, inspect.stack()[0][3], "START")

	languageCode 	= request.GET.get('languageCode', '')
	variant0 		= request.GET.get('variant0', '')
	variants 		= request.GET.get('variants', '')

	variant0 = cleanFaceOfUnicode(variant0)
	variants = cleanFaceOfUnicode(variants)

	if (variant0 != variants) and (variant0 != "") and (variants != ""):
		betaNotificationManager.ambigOrt (
			languageCode,
			variant0,
			variants
		)

	myloggin(request, inspect.stack()[0][3], "END__")

	return HttpResponse()
#------------------------------------------------------------------



#------------------------------------------------------------------
def wordDiff_style(request):
	return render( request,
		"tifocus/mainStyle.css"
	)

def wordDiff_editEntriesJS(request):
	return render( request,
		"tifocus/editEntries.js"
	)

def getRecording(request):
	audiofile = request.GET.get('audio', '')
	fname= audiofile.replace("b:", "/mnt/b")
	fname=fname.strip()
	f = open(fname,"rb") 
	response = HttpResponse()
	response.write(f.read())
	response['Content-Type'] ='audio/wav'
	response['Content-Length'] = os.path.getsize(fname )
	return response
#------------------------------------------------------------------