#musicallab
source "$currlocation"/labs/musicallab.sh

#My small tasks, programming
export algorithms="$base"/Algorithms
function algorithms_newproject {
	local name=${1}

	cd "$algorithms"
	cp -r _template "$1"
	cd "$1";
	
	touch "$1".py
}