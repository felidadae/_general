import subprocess
import codecs
import re
import os



def processFile(filePath, choice):
	"""
		choice <- "Group" or "*"
	"""

	fref = codecs.open(filePath, 'r', 'utf-8')
	fContent = fref.read()
	fref.close()

	lines = re.split("\n", fContent )
	il=0
	while not "CDATA" in lines[il]:
		il=il+1
	il2=il
	while not "]]></content>" in lines[il2]:
		il2=il2+1

	snippetContent = "\n".join(lines[il+1:il2])

	# find tabTrigger
	il3=il2
	while not "<tabTrigger>" in lines[il3]:
		il3=il3+1
	regexResult = re.search("<tabTrigger>\s*(.*)\s*</tabTrigger>", lines[il3])
	if regexResult: 
		tabTrigger = regexResult.group(1)
	
	# find scope
	il3=il2
	while not "<scope>" in lines[il3]:
		il3=il3+1
	regexResult = re.search("<scope>\s*.*?\.(.*?)\s*</scope>", lines[il3])
	if regexResult: 
		scope = regexResult.group(1)
	
	# print snippetContent
	# print tabTrigger
	# print scope

	#prepare the whole result string
	resultString=(
		"snippet " + tabTrigger + " \"\" b\n" + 
		snippetContent + 
		"\nendsnippet\n\n")

	if not os.path.isdir(".result/" + scope):
		os.makedirs(".result/" + scope)

	if choice == "Group":
		fref = codecs.open(".result/" + scope + "/" + "main.snippets", 
			'a+', 'utf-8')
	else:	
		fref = codecs.open(".result/" + scope + "/" + tabTrigger + ".snippets", 
			'w+', 'utf-8')
	fref.write(resultString)
	fref.close()





p = subprocess.Popen(
	["find", 
		".",
		"-name",
		"*.sublime-snippet"
	],
	stdout=subprocess.PIPE
)
output, err = p.communicate()
returncode = p.returncode

import shutil
shutil.rmtree(".result/")
if not os.path.isdir(".result/"):
	os.makedirs(".result/")

for i, sfp in enumerate(re.split("\n", output )):
	if sfp == "": continue
	processFile(sfp, "Group")
