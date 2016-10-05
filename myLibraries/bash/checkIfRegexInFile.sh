function checkIfLineInFile {
	local line=${1}
	grep -Fxq "$line" "${2}"
}

function checkIfRegexInFile {
	#Use perl regex
	local regex=${1}
	grep -Pq "$regex" "${2}"	
}