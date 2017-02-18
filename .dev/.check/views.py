"""
	In this file we call real functionalities
	from Managers; here we just prepare arguments;
"""
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



#******************************************************************
def cleanFaceOfUnicode(unn):
	unn = unn.replace(u'\xa0', u' ')
	unn = re.sub("\s+", " ", unn, re.UNICODE)
	unn = unn.strip()
	unn = uri_to_iri(unn)
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

	#[[langCode, filename], [langCode, filename] ... ]
    #Note: already sorted;
	filesListPairs = InputManager.listAvailableFiles()

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

	from tifocus.core.managers.XMLDividerManager import splitXML__containingWord_
	from tifocus.core.managers.HTMLRendererManager import renderDiff_oneFile, renderWStat_oneFile
	
	XMLsearchResult = splitXML__containingWord_(languageCode, fileName, wordToSearch)

	if "diff" in fileName:
		renderDiff_oneFile(
			languageCode, XMLsearchResult, "tmp.html",  0,1,
			{"includePageControllerOnBottom": 0, "includeSearchField": 0}
		)
	else:
		renderWStat_oneFile(
			languageCode, XMLsearchResult, "tmp.html", 0,1,
			{"includePageControllerOnBottom": 0, "includeSearchField": 0}
		) 

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
		possible states are:
		- before-adding
			add new form not existing before
		- removed
			want to reinstert removed form 
			(from g2p snapshot/oldforms)
		- added
			if changed mind and want to remove
			added form
		- zero
			wants to delete form from 
			g2p snapshot/oldforms
	"""
	myloggin(request, inspect.stack()[0][3], "START")

	langCode	 	= request.GET.get('languageCode', '')
	state 			= request.GET.get('state', '')
	word 			= request.GET.get('word', '')
	form 			= request.GET.get('forms', '')
	oldForms		= request.GET.get('oldForms', '')

	form = cleanFaceOfUnicode(form)
	oldForms = oldForms.split("*")
	word = word.lower()

	#
	#	Process word to utf8 from ansi form which do 
	#	not support utf8 
	#	for example: 
	#		u'f\xfcr' -> fr
	#
	word = uri_to_iri(word)

	dictionaryUpdatesManager.update(langCode, word, form, oldForms, state)

	myloggin(request, inspect.stack()[0][3], "END__")
	return HttpResponse("OK")

def editBlacklist(request):
	languageCode 	= request.GET.get('languageCode', '')
	word 			= request.GET.get('word', '')
	forms 			= request.GET.get('forms', '')
	action			= request.GET.get('action', '')

	forms = cleanFaceOfUnicode(forms)
	word = word.lower()

	returnValue = (
		dictionaryUpdatesManager.updateBlacklist(
			languageCode, word, forms, action))

	return HttpResponse("OK")

def currentStateForWord(request):
	langCode	 	= request.GET.get('languageCode', 	'')
	word 			= request.GET.get('word', 			'')
	sentenceA		= request.GET.get('sentenceA',		'')
	sentenceB		= request.GET.get('sentenceB',		'')
	recordingURL 	= request.GET.get('recordingURL', 	'')

	sentenceA = cleanFaceOfUnicode(sentenceA)
	sentenceB = cleanFaceOfUnicode(sentenceB)
	word = cleanFaceOfUnicode(word)

	if recordingURL != "":
		m = (re.search( '(asr[^\/]*).*\/((\d|\-)+).wav', 
			recordingURL));
		corpusname = m.group(1);
		FileID     = m.group(2);
		stateXML = dictionaryUpdatesManager.getCurrentStateForWord(
			langCode, word, sentenceA, sentenceB,
			corpusname, FileID)
	else:
		stateXML = dictionaryUpdatesManager.getCurrentStateForWord(
			langCode, word)

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

	wrongRef	= cleanFaceOfUnicode(wrongRef)
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

def notifyIncomprehensibleRecording(request):
	"""
		If recording 
	"""

	myloggin(request, inspect.stack()[0][3], "START")
	
	languageCode 	= request.GET.get('languageCode', '')
	recordingURL	= request.GET.get('fullRecordingURL', '')

	m = (re.search( '(asr[^\/]*).*\/((\d|\-)+).wav',
		recordingURL));
	corpusname = m.group(1);
	fileid     = m.group(2);

	betaNotificationManager.incomprehensibleRecording(
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
