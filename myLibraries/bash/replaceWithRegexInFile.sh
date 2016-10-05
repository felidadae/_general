#Perl regex engine
function replaceWithRegexInFile {
	local fileIn=${1}
	local regexSearch=${2}
	local replaceLine=${3}

	cat "$fileIn" | \
		perl -pe "s/$regexSearch/$replaceLine/" > \
		__tmp
	cat __tmp > "$fileIn"
	rm __tmp
}
