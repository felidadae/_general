function reloadBashProfile { 
	if [[ "$__MY_SHELL__" == 'zsh' ]]; then
		source ~/.zshrc	
	else
		source ~/.bashrc	
	fi
	source $general/shellProfile/AllFatherOfAllSons.sh; 
}

alias catt="pygmentize -g"
function c { clear; }
function tree1 { tree -L 1 -C --dirsfirst; }
function tree2 { tree "$1" -L 2 -C --dirsfirst; }
function definition { whence -f $1; }
alias t2="tree2"
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
	[[ "$2" == "" ]] && con=3
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
		if [[ "$SHELL" == "/bin/bash" ]]; then
			idx=$((idx-1))
		fi
		eval "$1 ${array[$idx]}"	
	else
		if [[ ${#array[@]} == 1 ]]; then
			if [[ "$SHELL" == "/bin/bash" ]]; then
				eval "$1 ${array[0]}"
			else
				eval "$1 ${array[1]}"
			fi
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
		-path '*.git*' -prune -o \
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
# @help
function help_perl {
	echo "Non consuming groups: (?<=regex)regex(?=regex)"
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
#@Super fast

#------------
# @zsh @zsh-snippets @zsh-small-snippets
if [[ "$__MY_SHELL__" == 'zsh' ]]; then
	#	Use showkeys -a or cat to see which escape sequences needed.
	#	Autokeys should be disabled while using this.
	#	bindkey to use fast without special key to 
	#		launch snippet.
	#	Use zshnip-add for snippets which rarer used 
	#		and special key must be used to run.

	KEY_LEFT='^[[D'
	KEY_BRACKET_LEFT='^?^?{'
	ENTER='^M'
	bindkey -M viins -s '^[h' '^[[D'
	bindkey -M viins -s '^[l' '^[[C'
	bindkey -M viins -s '^[4' '^[[4~ | '

	#numeric
	bindkey -M viins -s '34' \$
	bindkey -M viins -s '1232' \!\!
	bindkey -M viins -s '89' "\""
	bindkey -M viins -s '90' "\""
	bindkey -M viins -s '890' "\"\"$KEY_LEFT"
	bindkey -M viins -s '0-' "_"
	bindkey -M viins -s '``' "~/"
	bindkey -M viins -s '```' '$general/'

	bindkey -M viins -s '^[;' "^[[4~" # go to end of the line >>M-;<<
	bindkey -M viins -s '^[g' "^[[1~" # go to the begin of the line M-g

	bindkey -M viins 'jk' vi-cmd-mode
	bindkey -M viins '^[r' history-incremental-search-backward
	bindkey -M vicmd v edit-command-line
	bindkey -M viins -s ']\' '|'
	bindkey -M viins -s '^[2' ' | '
	bindkey -M viins -s ',wc' ' | wc -l'
	bindkey -M vicmd -s '^[s' '0isudo ^[A^['
	bindkey -M viins -s ',ez' "tmux split-window \"vim + ~/.zshrc\"$ENTER"
	bindkey -M viins -s ',e,' "tmux split-window \"vim \"$KEY_LEFT"

	export TAB="\t"
	# bindkey '\ej' zshnip-expand-or-edit # Alt-J
	# bindkey '\ee' zshnip-edit-and-expand # Alt-E
	# bindkey '^[8' zshnip-list
	zshnip-add echotsv $'echo -e "col0${TAB}col1${TAB}col2${TAB}col3" | ' 0
	zshnip-add perlane $'perl -F"$TAB" -lane \'print $F[0];\' ' 4

	# @zshsnippet
fi
#------------


alias .r="reloadBashProfile"
alias .c="xclip -selection c "
function .cl { history | tail -1 | perl -ne 'print $1 if /^\s*\d+\s*(.*)$/' | .c }

function ,epo { tmux split -p 40 'vim +/@super $general/shellProfile/pocketknife.sh;'  }
function ,ev  { tmux split -p 40 'vim +/@mapping ~/.vimrc';  }

alias _f=fuzzyCall
function ,   { fuzzyCall . "vim" "$1" "$2"; }
function ,gi { fuzzyCall . "git diff" "$1" "$2"; }
function ,.  { fuzzyCall . "$1" "$2" "$3"; }
function g,  { fuzzyCall "$general" "vim" "$1" "$2"; }
function g,. { fuzzyCall "$general" "pygmentize -g" "$1" "$2"; }
function s,  { fuzzyCall "/" "vim" "$1" "$2";  }
function ,n  { notify-send --urgency=critical --expire-time=400 "$1" "$2"; }


alias diffgit="git diff --no-index"
alias _gs="git status"
alias _ga="git add"
alias _gc="git checkout"
function ,pwd { pwd | tr '\n' ' ' | .c; }

function ,se  { tmux split-window -p 50 "vim $1;"; }
function ,sc  { tmux split-window -p 30 "vim $1;"; }

function ggr  { cd $(git rev-parse --show-toplevel); }
function egr  { echo $(git rev-parse --show-toplevel); }

function ,epoa { echo "$@" " #,epoa" >> $general/shellProfile/pocketknife.sh; }  #,epoa
function ,epoa { echo "<(xclip)" " #,epoa" >> $general/shellProfile/pocketknife.sh; }  #,epoa
function ,epoc { perl -ne '/\@Super fast/ && ($m=1); $m == 1 && print;' $general/shellProfile/pocketknife.sh | pygmentize -g -l sh; }
#--------------------------------



#--------------------------------
#@--not yet ordered
function .reslow { xrandr -s 1920x1080; }
function .reshigh { xrandr -s 3840x2160; }
function .b+ { xbacklight -inc 60; }
function .b- { xbacklight -dec 60; }

function ,networkrestart { sudo service network-manager restart; }
function sk { tmux split -p 30 'showkey -a'; }
function _gcom2 { sleep 0.2; tmux send-keys "git commit -m "; }
function man2pdf { man -t $1 | ps2pdf - > $1.pdf; }  #,epoa
function clean_whitespaces_to_4spaces {
	perl -MText::Tabs -n -i -e 'BEGIN {$tabstop = 4;} print expand $_' $(git ls-files)
	perl -i -lpe 's/\s+$//' $(git ls-files)
}
#--------------------------------
