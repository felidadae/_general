def callProcess(command):

	p = subprocess.Popen(
		re.split("\s+", command),
		stdout=subprocess.PIPE
	)
	output, err = p.communicate()
	returncode = p.returncode
	return (output, err, returncode)
print callProcess2("/bin/ls -l")[0]


