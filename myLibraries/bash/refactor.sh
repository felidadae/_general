tmp=________tmp

function refactor {
	local file=${1}
	local pattern=${2}

	cat "$file" | perl -pe "$pattern" > $tmp
	cat $tmp > "$file"
	rm $tmp
}

function deleteLinesFromFile {
	local file=${1}
	local il1=${2}
	local il2=${3}

	sed -i -e "${il1},${il2}d;" "$file"
}

function copyLinesFromFile {
	local file=${1}
	local il1=${2}
	local il2=${3}

	sed -n "${il1},${il2}p;" "$file" > CLIPBOARD
}

function cutLinesFromFile {
	local file=${1}
	local il1=${2}
	local il2=${3}

	sed -n "${il1},${il2}p;" "$file" > CLIPBOARD
	sed -i -e "${il1},${il2}d;" "$file"
}

function pasteLinesToFile {
	local fileFrom=${1}
	local fileTo=${2}
	local il1=${3}

	cat "$fileTo" | perl -e "my \$i=0; while(<>){   if(\$i == $il1-1 ){ system(\"cat $fileFrom\") };   print $_; \$i++;   }" > $tmp
	cat $tmp > "$fileTo"
	rm $tmp
}

function cutAndPasteBetweenFiles {
	local fileFrom=${1}
	local from__il1=${2}
	local from__il2=${3}
	#
	local fileTo=${4}
	local to__il=${5}
	#
	local expr=${6}

	cutLinesFromFile "$fileFrom" $from__il1 $from__il2
	if [[ "$expr" != "" ]]; then refactor CLIPBOARD "$expr"; fi
	
	pasteLinesToFile CLIPBOARD "$fileTo" $to__il
}

function copyDeletePaste {
	local fileFrom=${1}
	local from__il1=${2}
	local from__il2=${3}

	local fileTo=${4}
	local to__il1=${5}
	local to__il2=${6}

	copyLinesFromFile "$fileFrom" $from__il1 $from__il2
	deleteLinesFromFile "$fileTo" $to__il1 $to__il2
	pasteLinesToFile CLIPBOARD "$fileTo" $to__il1
}

function replaceLine {
	local file=${1}
	local il1=${2}
	local replace="$3"

	deleteLinesFromFile "$file" $il1 $il1
	echo "$replace" > CLIPBOARD
	pasteLinesToFile CLIPBOARD "$file" $il1
}