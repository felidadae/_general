pk="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
function reloadBashProfile { 
	if [[ "$__MY_SHELL__" == 'zsh' ]]; then
		source ~/.zshrc	
	else
		source ~/.bashrc	
	fi
	source $general/shellProfile/AllFatherOfAllSons.sh; 
}

# make tap to click
[ -x "$(command -v synclient)" ] && synclient TapButton1=1 TapButton2=3 TapButton3=2

alias catt="pygmentize -g"
function c { clear; }
function tree1 { tree -L 1 -C --dirsfirst; }
function tree2 { tree "$1" -L 2 -C --dirsfirst; }
function definition { whence -f $1; }
alias m="man"
alias s-s="sudo systemctl status"
alias s-r="sudo systemctl restart"
alias s-stop="sudo systemctl stop"
alias j-="sudo journalctl --since \"5minutes ago\" -u"
alias v-"vim -"
alias t2="tree2"
alias lss="ls -1a --color"
alias lsd="LC_COLLATE=C ls -1a --group-directories-first --color"
alias tmux="tmux -2"
alias tmuxa="tmux attach-sesion -t"
alias gre=grep
alias .get="sudo apt-get install"
alias .remove="apt-get uninstall"
alias lynx='lynx -accept_all_cookies -lss=lynx.lss'
function up_system {
	sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove
}
alias cham="chmod +x"
alias open="xdg-open"
alias spotify="spotify --force-device-scale-factor=2.5"
alias cd.="cd .."
alias df_gb="df --block-size=GB"

function howManyFiles { ls -1 "$1" | wc -l; }
function modifiedFilesIn {
	find . -mtime -1 -ls
}
function list_size {
	for i in "$1"*; do
		[ ! -d "$i" ] && continue
		du -sh "$i"
	done
}
function ls_in_mb {
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
# @language @tre @fast-trans
function tr_ { 
	trans pl:en "$1"
	trans pl:es "$1"
}
function translate_and_read_en2es {
	local sentence_to_translate="${1}"
	trans en:es "$sentence_to_translate"
	trans en:es "$sentence_to_translate" \
		| tail -1 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" \
		| perl -pe 's/^\s+//' \
		| xargs -n1 -I_sentence -d '\n' sh -c \
			'echo "[Reading] _sentence" && \
			gtts-cli.py "_sentence" -l es -o zupa.mp3 \
				&& play -q zupa.mp3 && rm zupa.mp3'
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

function help_git_ {
	echo "git diff-tree --no-commit-id --name-only -r COMMIT"
	echo "git log --diff-filter=A -- SOURCE_FILE"
}
function help_git_listFilesIn1Commit {
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
	tmux new-window -c "$destiny" -n "$window_name";
	tmux split -t :"$window_name" "cd $destiny; vim *.$lang"; 
	# tmux send-keys -t :"$window_name".1 "cd $destiny" Enter "c" Enter "pwd" Enter
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
function split_or_full {
	app="$1"
	percentage="$2"

	[ -z "$percentage" ] && percentage=50
	if [ "$percentage" != f ]; then 
		tmux split -p "$percentage" "$app"
	else
		eval "$app"
	fi
}
function experiment_java {
	cat <<'EOF' > Experiment.java 
import java.util.*;

public class Experiment{
	public static void main(String[] args){
		System.out.println("Happy Coding!");
	}
}
EOF
	echo "Type run_java"
}
function run_java {
	javac Experiment.java
	java Experiment 
}
function move_to_tmp_dir {
	pushd .
	local __tmp__=$(mktemp -d)
	cd "$__tmp__"
}
#--------------------------------


#--------------------------------
# @help
function help_perl {
	echo "Non consuming groups: (?<=regex)regex(?=regex)"
}
function help_gnome_extensions {
	echo "Gnome extensions are located in two places:"
	echo "  user   <- ~/.local/share/gnome-shell/extensions"
	echo "  system <- /usr/share/gnome-shell/extensions/"
}
function help_system_clipboard_piping {
	echo "to pipe into clipboard >> xclip -selection c"
}
function help_nvidia_tearing_screen {
    echo "Finally fixed for ubuntu 16.04 !!!"
    echo ""
    echo "read https://devtalk.nvidia.com/default/topic/957814/linux/prime-and-prime-synchronization/"
    echo "in file /etc/modprobe.d/nvidia-graphics-drivers.conf set 'options nvidia_*_drm modeset=1'"
    echo ""
    echo "read https://wiki.archlinux.org/index.php/NVIDIA_Optimus#Tearing.2FBroken_VSync"
    echo "part of the article:"
    echo "This requires xorg-server 1.19 or higher, linux kernel 4.5 or higher, and"
    echo "nvidia 370.23 or higher. Then enable DRM kernel mode setting, which will in"
    echo "turn enable the PRIME synchronization and fix the tearing."
}
function help_perlregexbehind {
	echo '(?=) - Positive look ahead assertion foo(?=bar) matches foo when followed by bar'
	echo '(?!) - Negative look ahead assertion foo(?!bar) matches foo when not followed by bar'
	echo '(?<=) - Positive look behind assertion (?<=foo)bar matches bar when preceded by foo'
	echo '(?<!) - Negative look behind assertion (?<!foo)bar matches bar when NOT preceded by foo'
	echo '(?>) - Once-only subpatterns (?>\d+)bar Performance enhancing when bar not present'
	echo '(?(x)) - Conditional subpatterns'
	echo '(?(3)foo|fu)bar - Matches foo if 3rd subpattern has matched, fu if not'
	echo '(?#) - Comment (?# Pattern does x y or z)'
}
function help_checkspace {
	echo 'Use tools: du, df, ncdu'
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
function zshsnippet_save {
	export LAST_COMMAND=$(tail -1 ~/.zshnip); 
	EPO=$general/shellProfile/pocketknife.sh
	perl -i -ne '
		BEGIN { 
			$wrong_input_data=0;
			$wrong_input_data = 1 unless $ENV{LAST_COMMAND} =~ /^zshnip-add\s*(.*?)\s/; 
			$name = $1; $inside=0; $changed=0; 
			$wrong_input_data = 1 if "$name" eq "";
			$begin_r = "^(\s*)#\s*\@zshsnippet_begin";
			$end_r = "^(\s*)#\s*\@zshsnippet_end";
		}
		if ($wrong_input_data == 1) { print; next; }
	 
		if (/^(\s*)#\s*\@zshsnippet_begin/) { $inside=1; }

		if ($inside == 0) { print; next; }

		if (/^(\s*)zshnip-add $name/) {
			print "$1$ENV{LAST_COMMAND}\n";
			$changed = 1;
			next;
		}

		if (/^(\s*)#\s*\@zshsnippet_end/)   { 
			$inside=0; 
			if ($changed == 0) {
				print "$1$ENV{LAST_COMMAND}\n$1alias $name=\"\"\n$_";
			} else {print;}
			next;
		}
		print;

		' "$EPO"
	unset LAST_COMMAND
}
#--------------------------------





#--------------------------------
#@Super fast

#------------
# @zsh @zsh-snippets @zsh-small-snippets
if [[ "$__MY_SHELL__" == 'zsh' ]]; then

    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
	#	Use showkeys -a or cat to see which escape sequences needed.
	#	Autokeys should be disabled while using this.
	#	bindkey to use fast without special key to 
	#		launch snippet.
	#	Use zshnip-add for snippets which rarer used 
	#		and special key must be used to run.

	KEY_LEFT='^[[D'
	KEY_BRACKET_LEFT='^?^?{'
	ENTER='^M'
    TAB='9'
    BACK_SPACE='^?'


    # main in blood
	bindkey -M viins 'jk' vi-cmd-mode
	bindkey -M viins -s '^D' "$BACK_SPACE"
	bindkey -M viins '^[r' history-incremental-search-backward
	bindkey -M viins '^R' history-incremental-search-backward
    bindkey -M vicmd v edit-command-line

    # apostrophe
	bindkey -M viins -s ";\'" "\"\""$KEY_LEFT

    # deprecated: too much problem while inserting text
	# numeric
	# bindkey -M viins -s '34' \$
	# bindkey -M viins -s '1232' \!\!
	# bindkey -M viins -s '89' "\""
	# bindkey -M viins -s '78' "*"
	# bindkey -M viins -s '90' "\""
	# bindkey -M viins -s '890' "\"\"$KEY_LEFT"
	# bindkey -M viins -s '0-' "_"

    # alt + nmeric
	bindkey -M viins -s '^[2' ' | '
    bindkey -M viins -s '^[3' "\$()$KEY_LEFT"

    # ctrl + nmeric
	bindkey -M viins -s '^@' "ls$ENTER" # ctrl+2
	bindkey -M viins -s '^[' "tig --all$ENTER" # ctrl+3

    # temporary

    # tylda
	bindkey -M viins -s '``' "~/"
	bindkey -M viins -s '```' '$general/'
	bindkey -M viins -s '````' 'cd $general'"$ENTER"

    # beginning with characters
	bindkey -M viins -s '0tiga' "tig --all $ENTER"
	bindkey -M viins -s '0lsl' "ls $ENTER"
	bindkey -M viins -s '0gs' "git status$ENTER"
	bindkey -M viins -s '0tta' "tmux attach-session -t "
	bindkey -M viins -s '0gd' "git diff$ENTER"
	bindkey -M viins -s '0gdd' "git diff --cached $ENTER"
	bindkey -M viins -s '0gda' "git add -u"
	bindkey -M viins -s '0gca' "git commit --amend"
	bindkey -M viins -s '^[m' "list_mappings_$TAB"

    # translate
    bindkey -M vicmd -s 'tre' "itrans pl:en ''$KEY_LEFT"
    bindkey -M vicmd -s 'ytr' "itrans -p en:es ''$KEY_LEFT"
    bindkey -M vicmd -s 'gtr' "igtts-cli.py -l es -o zupa.mp3 ''$KEY_LEFT"
    bindkey -M vicmd -s 'ptr' "iplay zupa.mp3$ENTER"
    bindkey -M vicmd -s 'atr' "itrans -p es:en ''$KEY_LEFT"

    # sudo all
	function _sudo-all { zle beginning-of-line; LBUFFER="sudo "; }
	zle -N _sudo-all 
    bindkey '\es\es' _sudo-all #Alt-s Alt-s

    function list_mappings_zsh_insert {
        grep -P '^\s*bindkey' "$general/shellProfile/pocketknife.sh" | perl -pe 's/^\s+//g' | grep bindkey
    }
    #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


	bindkey '\ej' zshnip-expand-or-edit # Alt-J
	bindkey '\ee' zshnip-edit-and-expand # Alt-E
    alias snipl=zshnip-list

	# @zshsnippet_begin
	zshnip-add echotsv $'echo -e "col0${TAB}col1${TAB}col2${TAB}col3" | ' 0
	alias echotsv=''
	zshnip-add perlane $'perl -F"$TAB" -lane \'print $F[0];\' ' 4
	alias perlane=''
	zshnip-add perlne $'perl -ne \'print "$1" if //;\' ' 4
	alias perlne=''
	zshnip-add perln $'perl -ne \'print "$." if //;\' ' 4
	alias perlne=''
	zshnip-add perli $'perl -i -pe \'s///g\' *' 6
	alias perli=""
	zshnip-add find. $'find . -name \' \'' 6
	alias perli=""
	# @zshsnippet_end
fi
#------------


alias .r="reloadBashProfile"
# important fix: working without x11
if [ "$DISPLAY" != ""  ]; then
    alias .c="tr '\n' ' ' | xclip -selection c"
else
    alias .c="tr '\n' ' ' > ~/.shared_buffer"
fi
function .cl { history | tail -1 | perl -ne 'print $1 if /^\s*\d+\s*(.*)$/' | .c; }

function ,epo { 
	vim +/@super $general/shellProfile/pocketknife.sh;
}
function ,ev  { vim +/@mapping ~/.vimrc; }

alias _f=fuzzyCall
#mini lang
function ,.  { fuzzyCall . "$1" "$2" "$3"; }
function ,   { fuzzyCall . "vim" "$1" "$2"; }
function ,gd { fuzzyCall . "git diff" "$1" "$2"; }
function g,  { fuzzyCall "$general" "vim" "$1" "$2"; }
function v,  { fuzzyCall "$vim_" "vim" "$1" "$2"; }
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

function .ggr  { cd   $(git rev-parse --show-toplevel); }
function .pgr  { echo $(git rev-parse --show-toplevel); }

function ,epoa { echo "$@" " #,epoa" >> $general/shellProfile/pocketknife.sh; }  #,epoa
function ,epoa { echo "<(xclip)" " #,epoa" >> $general/shellProfile/pocketknife.sh; }  #,epoa
function ,epoc { perl -ne '/\@Super fast/ && ($m=1); $m == 1 && print;' $general/shellProfile/pocketknife.sh | pygmentize -g -l sh; }
#--------------------------------



#--------------------------------
#@--not yet ordered
function .reslow { xrandr -s 1920x1080; }
alias r=ranger
alias v=vim
alias h=history
function .reshigh { xrandr -s 3840x2160; }
function .b+ { xbacklight -inc $1; }
function .b- { xbacklight -dec $1; }
function sk { tmux split -p 30 'showkey -a'; }
function man2pdf { man -t $1 | ps2pdf - > $1.pdf; }  #,epoa
function clean_whitespaces_to_4spaces {
	FILES=$(git ls-files | grep '.sh\|.py' | tr '\n' ' ')
	perl -MText::Tabs -n -i -e 'BEGIN {$tabstop = 4;} print expand $_' $FILES
	perl -i -lpe 's/\s+$//' $FILES
}
function print_header { head -1 $1 | tr '\t' '\n' | cat -n; }
function touch_sample_tsv {
	echo "Touching file sample.htsv"
	echo -e "col_name_0${TAB}col_name_1${TAB}col_name_2${TAB}col_name_3" >> sample.htsv
	echo -e "col_val_row0_col0${TAB}col_val_row0_col1${TAB}col_val_row0_col2${TAB}col_val_row0_col3" >> sample.htsv
	echo -e "col_val_row1_col0${TAB}col_val_row1_col1${TAB}col_val_row1_col2${TAB}col_val_row1_col3" >> sample.htsv
}
function touch_script_sh {
	touch "$1.sh"
	chmod +x "$1.sh"
	echo "#!/bin/bash -e" > "$1.sh"
}
#--------------------------------
