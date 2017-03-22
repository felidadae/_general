function reloadBashProfile { source $general/bashProfile/AllFatherOfAllSons.sh; }

alias catt="pygmentize -g"
function c { clear; }
function tree1 { tree -L 1 -C --dirsfirst; }
function tree2 { tree "$1" -L 2 -C --dirsfirst; }
alias t2="tree2"
alias ls="ls --color"
alias lss="ls -1a --color"
alias lsd="LC_COLLATE=C ls -1a --group-directories-first --color"
alias tmux="tmux -2"
alias cd.="cd .."

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
function .grep {
	[ "$2" == "" ] && con=3
	grep -rn -A $con -B $con --color=always "$1"
}
function grepp {
	ps aux | grep "$1"
}
alias processFind1Pattern=grepp
function cpu_usage_get {
	lscpu | grep "CPU MHz"
}
function process_find__arg1port {
	netstat -tulpn | grep "$1"
}
function process_find__arg1name {
	ps aux | grep $1
}
function swprm {
	rm $(find . -name "*.swp")
	rm $(find . -name "*.swo")
}
function jobskill {
	kill $(jobs -p)
}
function portCheckWhatProcessIsListening_1Port {
	netstat -tulpn | grep "$1"
}
#apt get repos
if [ "$OS_KERNEL__" = "linux" ]; 
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
	if [ "$OS_KERNEL__" = "darwin" ]; 
	then
		#MAC OS X
		otool -L "$1"
	else
		ldd "$1"
	fi
}
printdocument=lpr
function momentusjob() { echo "`date`" >> ~/momentusjob.txt; general_sync; }
function ,momentusjob() { catt ~/momentusjob.txt; }
# @extend


#--------------------------------
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
if [ "$OS_KERNEL__" = "darwin" ]; 
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

if [ "$OS_KERNEL__" = "darwin" ]; 
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
function _arrayChoice {
	# 1 <- app
	# 2 <- idx of array
    # 0 <- As global array	
	if [[ "$2" != "" ]]; then
		idx="$2"
		idx=$((idx-1))
		eval "$1 ${array[$idx]}"	
	else
		if [[ ${#array[@]} == 1 ]]; then
			eval "$1 ${array[0]}"
		else
			printf '%s\n' "${array[@]}" | cat -n	
		fi
	fi
}
function fuzzyCall {
	array=()
	while IFS=  read -r -d $'\0'; do
		array+=("$REPLY")
	done < <(find "$1" -follow \
		-path .git -prune -o \
		-iname "*$3*" \
		-not -name "*.swp" -not -name "*.swo" \
		-not -type d -print0)

	_arrayChoice "$2" "$4"  
}
function chooseDir {
	array=()
	while IFS=  read -r -d $'\0'; do
		array+=("$REPLY")
	done < <(find . -maxdepth $1 -follow \
		-path *.git* -prune -o \
		-type d -print0)

	_arrayChoice "cd" "$2"
}
#Its done?
# function fastTest {
# 	tmux new-window -n 'Experimental'	
# 	tmux split-window -t 'Experimental' -h	
# 	tmux send-keys -t 'Experimental' "vim $1.py" Enter	
# 	tmux select-window -t 'Experimental'	
# 	tmux select-pane -t 2	
# 	tmux send-keys 'echo dupa'	
# }
function experimentCode {
	local lang=${1}		# cpp, py, java
	[[ $lang == "" ]] && echo "usage: arg1=lang" && return 

	local today=`date +%Y%m%d-%H%M`
	
	local source=$skeletons/$lang
	[[ ! -d $playground/EXP ]] && mkdir -p $playground/EXP
	[[ ! -d $playground/EXP_stable ]] && mkdir -p $playground/EXP_stable
	local destiny=$playground/EXP/$lang-$today
	cp -r $source $destiny

	window_name=EXP
	tmux new-window -n "$window_name";
	tmux split -t :"$window_name" "cd $destiny; vim main.$lang"; 
	tmux send-keys -t :"$window_name".1 "cd $destiny" Enter "c" Enter "pwd" Enter
}
function experimentCode__clear { rm -r $playground/EXP/*; }
function experimentCode__mv {
	local currpos=$(pwd)
	cd ..;
	mv $currpos "$1"
	cd "$1"
}
alias ,exp=experimentCode
function refactor {
	echo "Use perl -pi.pre_refactor -e 's///g' $(find . -)"
}
function restore_refactor {
	for f in $(find . -name '*.pre_refactor'); do
		mv $f "${f%.*}"
	done	
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
#Some variables which i will use
#--------------------------------


#--------------------------------
#Super fast
alias .r="reloadBashProfile"
alias .c="xclip -selection c"
function ,re { make clean; make; ./main; }

function ,epo { vim $general/bashProfile/pocketknife.sh;  }
function ,ev  { vim ~/.vimrc;  }
###---
function ,  { fuzzyCall . "vim" "$1" "$2"; }
function ,gi { fuzzyCall . "git diff" "$1" "$2"; }
function ,. { fuzzyCall . "$1" "$2" "$3"; }
###---
function g,  { fuzzyCall "$general" "vim" "$1" "$2"; }
function g,. { fuzzyCall "$general" "pygmentize -g" "$1" "$2"; }
###---
function s,  { fuzzyCall "/" "vim" "$1" "$2";  }
function ,n  { notify-send --urgency=critical --expire-time=400 "$1" "$2"; }
alias _f=fuzzyCall

function .b+ { xbacklight -inc 60; }
function .b- { xbacklight -dec 60; }
function .reslow { xrandr -s 1920x1080; }
function .reshigh { xrandr -s 3840x2160; }

function ,gc { printf 'git add -A; git commit -m "Cleaning; git push origin master;"' | .c;}
alias _gls="git_listFilesIn1Commit"
alias diffgit="git diff --no-index"
alias _gs="git status"
alias _ga="git add"
alias _gc="git checkout"
alias tsk="tmux send-keys"
function _gcom2 { sleep 0.2; tmux send-keys "git commit -m "; }
alias _gd="git diff"
alias _gl="git log"
alias _gb="git branch"
alias _gpo="git push origin"
alias _gall="git status; git branch;"
function ,te { trans pl: "$1"; }
function ,pwd { pwd | .c;  }
function ,commandoriumsave { xclip -selection c -o >> $general/commandorium.sh; }
function ,keys { vim $general/keyboardShortcuts.keymap; }

#@Fast prototyping
# function ,fast { fastTest  } 
function ,py { export LAST_SCRIPT=$1.py; touch $1.py; vim $1.py;  } 
function ,py,c { python $LAST_SCRIPT; }
function ,py,m { mv $LAST_SCRIPT "$1"; }

function ,books { _f $general/mybooks "xdg-open" pdf $1; }
function ,ytandroid { google-chrome --app=https://www.youtube.com/playlist?list=PLGLfVvz_LVvSPjWpLPFEfOCbezi6vATIh; }
function ,networkrestart { sudo service network-manager restart; }

function ,s { tmux split-window -p 50 "vim $1;"; }
function ,ta { tmux split-window -p 30 "vim $notus/tablica.todo;"; }
function ,gr { cd $(git rev-parse --show-toplevel); }

#@--fast
