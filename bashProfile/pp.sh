#
#	@Description
#		Here we put some useful bash functions
#	@Important note:
#		currPos=$(pwd); cd "$projectRoot__";
#			is to remember current position (path)
# 			and move to root dir of project;
#		cd "$currPos"
#			is to return to previous path;
#		Thanks to that we can run this commands from
#		any position;  

function pp-findRoot {
	currPos=$(pwd)
	while [[ $(ls -1a | grep ".git$") == "" ]]; do cd ..; done
	export projectRoot__=$(pwd)
	cd "$currPos" 

	echo Root set to projectRoot__=$projectRoot__
}
function pp-setRoot {
	export projectRoot__="$(pwd)"
}
function pp-r { cd $projectRoot__; }
function pp-reload {
	currPos2=$(pwd); cd "$projectRoot__"/.dev; 
	source tools.sh
	cd "$currPos2"
}

function pp-listPyFiles-flat {
	currPos=$(pwd);cd "$projectRoot__";
	find .  -name '*.py'
	cd "$currPos" 	
}

function pp-listPyFiles {
	currPos=$(pwd); cd "$projectRoot__";
	tree -P "*.py" \
		-I '*__pycache__*|*__init__.py|migrations'
	cd "$currPos" 	
}
alias ppl="pp-listPyFiles"
alias pl="pptt"

function pp-listPyFiles-main {
	currPos=$(pwd); cd "$projectRoot__";
	tree -P "*.py" \
		-I '*__pycache__*|*__init__.py|migrations'

	cd "$currPos" 
}


#
#	finishing
#
function pp-listfun {
	currPos=$(pwd); 
	[[ ! -e "$projectRoot__"/.dev ]] && return 
	for ifile in *; do
		[ -e "$ifile" ] || continue
		[[ "$ifile" == *"tools"* ]] || continue
		perl -nle 'print "$1" if /^\s*function (.*)\s*\{/' $ifile
	done
	cd "$currPos"
}
pp-listfun
