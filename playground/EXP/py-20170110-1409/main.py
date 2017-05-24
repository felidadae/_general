import subprocess
import re
def callProcess():
	fullPathToScript = '/usr/bin/notify-send'
	p = subprocess.Popen(
		[ 
			fullPathToScript,
			'--urgency=critical',
			'--expire-time=400',
			'Zrob przerwe na oczka'
		],
		stdout=subprocess.PIPE
	)
	output, err = p.communicate()
	returncode = p.returncode

def callProcess(command):
	p = subprocess.Popen(
		re.split("\s+", command),
		stdout=subprocess.PIPE
	)
	output, err = p.communicate()
	returncode = p.returncode
	return (output, err, returncode)
print callProcess2("/bin/ls -l")[0]
