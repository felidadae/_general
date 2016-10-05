#--------------------------------
function pocketknife__see {
	local scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	pygmentize -g "$scriptPath"/pocketknife.sh
}

alias catt="pygmentize -g"
function c { clear; }
function tree1 { tree -L 1 -C --dirsfirst; }
function tree2 { tree "$1" -L 2 -C --dirsfirst; }
alias t2="tree2"
alias lss="ls -1a --color"
alias lsd="LC_COLLATE=C ls -1a --group-directories-first --color"
alias tmux="tmux -2"

#Reload bashprofile
if [ "$OS_KERNEL__" == "darwin" ]; 
then
	function reloadBashProfile { source ~/.bash_profile; }
else
	function reloadBashProfile { source ~/.bashrc; }
fi

function howManyFiles { ls -1 "$1" | wc -l; }

function modifiedFilesIn {
	find . -mtime -1 -ls
}

function listSize {
	for i in "$1"*; do
		[ ! -d "$i" ] && continue
		du -sh "$i"
	done
}
function lsInMB {
  ls -s --block-size=1048576 $1 | cut -d' ' -f1
}
function mls {
  ls -lfd _* [!_]* -1 --color=auto
}
function moveWithPattern {
	local pattern=${1}
	local destinationmovedir=${2}
	find . | grep -E "$pattern" | xargs -J {} mv {} "$destinationmovedir"/
}
function grepBase {
	grep --colour=auto -r "$1" "$base"
}
function grepMyCodeWithExtension_1Pattern_2extension {
	myCodeDirs[0]="$base"
	for item in ${myCodeDirs[*]}
	do
		grep --group-separator "\n\n\n" -B 3 -A 2 -n -r "$1" --include \*."$2" $item
	done
}
alias finder="xdg-open ."
alias grepc="grep -B 3 -A 2"
alias ls='ls -G'

function grepp {
	ps aux | grep "$1"
}
alias processFind1Pattern=grepp
function cpu_usage_get {
	lscpu | grep "CPU MHz"
}

#network
function portCheckWhatProcessIsListening_1Port {
	netstat -tulpn | grep "$1"
}

#apt get repos
if [ "$OS_KERNEL__" == "linux" ]; 
then
	function apt_repos_see {
		sudo cat /etc/apt/sources.list > rec
		sudo ls /etc/apt/sources.list.d/ >> rec 
		echo "Written to >>rec<<"
	}
	function apt_repos_go {
		cd /etc/apt/sources.list.d/
		clear
		pwd
	}
fi

function dynamicLibraryRequirements {
	if [ "$OS_KERNEL__" == "darwin" ]; 
	then
		#MAC OS X
		otool -L "$1"
	else
		ldd "$1"
	fi
}

export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export NC='\033[0m'

function MessageError   { printf "${RED}[Error]${NC} $1\n"; }
function MessageSuccess { printf "${GREEN}[Success]${NC} $1\n"; }
function MessageInfo    { printf "${YELLOW}[Info]${NC} $1\n"; }

function perlRegexSplitTest {
	perlExp='@r=split /\s+|(?=[^\[])-(?=[^\]])/, $_;'
	perlExp+='foreach (@r) { print $_ . "\n" }'
	echo "ah t'es sous les corps-à-corps" | \
		perl -pe "$perlExp" 
}
function perlRegexTest {
	return 0
}
function djangoTemplateTest {
	return 0
}
#--------------------------------



#--------------------------------
if [ "$OS_KERNEL__" == "darwin" ]; 
then
	#MAC OS X
	function ff { osascript -e 'tell application "Finder"'\
		-e "if (${1-1} <= (count Finder windows)) then"\
		-e "get POSIX path of (target of window ${1-1} as alias)"\
		-e 'else' -e 'get POSIX path of (desktop as alias)'\
		-e 'end if' -e 'end tell'; 
	}
	function cdff { cd "`ff $@`"; };

	function notify {
		local title=${1}
		local text=${2}
		osascript -e "display notification \"$text\" with title \"$title\"" \
			&& afplay /System/Library/Sounds/Blow.aiff
	}
fi

if [ "$OS_KERNEL__" == "darwin" ]; 
then
	#MAC OS X
	function bd { osascript "$general"/tools/brightness/bb.AppleScript; } 
	function bu { osascript "$general"/tools/brightness/b.AppleScript; } 
fi
#--------------------------------


#--------------------------------
#
#	GIT system
#

function git_help {
	echo "git diff-tree --no-commit-id --name-only -r COMMIT"
	echo "git log --diff-filter=A -- SOURCE_FILE"
}

function git_listFilesIn1Commit {
	git diff-tree --no-commit-id --name-only -r "$1"
}
#--------------------------------



#--------------------------------
function process_find__arg1port {
	netstat -tulpn | grep "$1"
}
function process_find__arg1name {
	ps aux | grep $1
}
function swprm {
	rm $(find . -name "*.swp")
}
function fuzzyCall {
	availableFiles=$(find . -iname "*$2*" -not -name "*.swp" -not -name "*.swo" -not -type d )
	array=($availableFiles)

	if [[ $3 != "" ]]; then
		idx=$3
		idx=$((idx-1))
		eval "$1 ${array[$idx]}"	
	else
		if [[ ${#array[@]} == 1 ]]; then
			eval "$1 $availableFiles"
		else
			echo -e "$availableFiles" | cat -n	
		fi
	fi
}

#--------------------------------



#--------------------------------
#Vim subtools
function vim_newsyntax {
	local nameOfSyntax=${1}
	local filesEndings=${2}

	p=~/.vim/syntax/${nameOfSyntax}.vim	
	touch $p
	echo "if exists('b:current_syntax') | finish|  endif" > $p
	echo "" >> $p
	echo "let b:current_syntax = '$nameOfSyntax'" >> $p
	vim $p
}
#--------------------------------



#--------------------------------
#screen
function .b+ {
	xbacklight -inc 60
}
function .b- {
	xbacklight -dec 60
}
#--------------------------------


#--------------------------------
#Super fast
alias _r="reloadBashProfile"
alias .c="xclip -selection c"

function ,epo { vim $general/bashProfile/pocketknife.sh;  }
function ,ev  { vim ~/.vimrc;  }
function , { p=$(pwd); cd $general; fuzzyCall "$1" "$2" "$3"; cd "$p"; }
function ,. { p=$(pwd); cd $general; fuzzyCall "vim" "$1" "$2"; cd "$p"; }
function ,,. { fuzzyCall "vim" "$1" "$2"; }
function ,., { p=$(pwd); cd $general; fuzzyCall "pygmentize -g" "$1" "$2"; cd "$p"; }
function ,n { notify-send --urgency=critical --expire-time=400 "$1" "$2"; }
alias _f=fuzzyCall

alias _gls="git_listFilesIn1Commit"
alias diffgit="git diff --no-index"
alias _gs="git status"
alias _ga="git add"
alias _gc="git checkout"
alias _gcom="git commit -m"
alias _gd="git diff"
alias _gl="git log"
alias _gb="git branch"
alias _gpo="git push origin"
alias _gall="git status; git branch;"
#--------------------------------
