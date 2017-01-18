




#-------------------------------------------------------------------------------
#
#	Root of bashprofile
#
#-------------------------------------------------------------------------------






#-------------------------------------------------------------------------------
#####
##	OS, Kernel, Desktop Session, Computer
##
##	Important variables set: 
##	$OS_KERNEL__ 
##	$DESKTOP_SESSION__ 
##	$ARCHITECTURE__
##	$IF_MACBOOK__ 
##	$OS__
##	$OS_VER__
#####

#@TODO check whether the computer is a macbook;
IF_MACBOOK__="0"

#to check OS
function checkSystemKernel {
	uname -s 2>/dev/null | tr "[:upper:]" "[:lower:]"
}
export OS_KERNEL__=$(checkSystemKernel)

function checkDesktopSession {
	local desktop=""

	if [ "$XDG_CURRENT_DESKTOP" = "" ]
	then
		desktop=$(echo "$XDG_DATA_DIRS" | sed 's/.*\(xfce\|kde\|gnome\).*/\1/')
	else
		desktop=$XDG_CURRENT_DESKTOP
	fi
	desktop=$(echo $desktop | tr '[:upper:]' '[:lower:]')
	echo $desktop
}
export DESKTOP_SESSION__=$(checkDesktopSession)

OS__=$(lsb_release -si)
ARCHITECTURE__=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
OS_VER__=$(lsb_release -sr)
#-------------------------------------------------------------------------------





#-------------------------------------------------------------------------------

#
##
#	Before loading any children files
#	set PATH, PS1, HIST*	
##
#


#------------------------
export PATH=~/bin:"$PATH"
export EDITOR="vim"
TERM=xterm-256color

#Promt
if [[ $__MY_SHELL__ = "bash" ]]; then
	function parse_git_branch() {
		x=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
		if [[ "$x" == "" ]]; then
			echo ""
		else
			x=${x:1:-1}
			echo " $x"
		fi
	}
	function git_color() {
		COLOR_RED="\033[0;31m"
		COLOR_YELLOW="\033[0;33m"
		COLOR_GREEN="\033[0;32m"
		COLOR_OCHRE="\033[38;5;95m"
		COLOR_BLUE="\033[0;34m"
		COLOR_WHITE="\033[0;37m"
		COLOR_RESET="\033[0m"
		local git_status="$(git status 2> /dev/null)"
		if [[ ! $git_status =~ "working directory clean" ]]; then
			echo -e $COLOR_GREEN
		elif [[ $git_status =~ "Your branch is ahead of" ]]; then
			echo -e $COLOR_YELLOW
		elif [[ $git_status =~ "nothing to commit" ]]; then
			echo -e $COLOR_GREEN
		else
			echo -e $COLOR_GREEN
		fi
	}
	function dayTime() {
		hour=`date +"%l"` 
		if (($hour > 6 && $hour < 18)); then 
			echo ""
		else
			echo ""
		fi
	}
	# alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"
	PS1='\[\e[0;33m\]`dayTime`[\W]\[\e[0;35m\]`parse_git_branch`\[\e[0m\]\[\e[0;33m\]\$\[\e[0m\] '
fi

HISTFILESIZE=
HISTSIZE=5000

if [ "$OS_KERNEL__" = "darwin" ]; 
then
	#to make port working
	export PATH=/opt/local/bin:/opt/local/sbin:"$PATH"
	PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:"
fi
#------------------------



#------------------------
export base=~/Programming
general="$base/_General"
currlocation="$general"/bashProfile
#------------------------
#-------------------------------------------------------------------------------



#-------------------------------------------------------------------------------

#
##
#	Load children files (order is important)	
#		Note on order
#		locations does not have any functions
##
#

source "$currlocation"/locations.sh
source "$currlocation"/pocketknife.sh
source "$currlocation"/pp.sh
source "$currlocation"/.tmp.sh
#
#
#
for ifile in "$currlocation"/softwareShortcuts/* ; do
	[ -e "$ifile" ] || continue
	source "$ifile" 
done
for ifile in "$currlocation"/toggling/* ; do
	[ -e "$ifile" ] || continue
	source "$ifile" 
done
#-------------------------------------------------------------------------------



#-------------------------------------------------------------------------------

#
##
# Syncing code - to push to remote
##
#


function general_sync {
	prev=$(pwd)
	cd "$general"
	if [[ "$(git status --porcelain)" != "" ]]; then 
		git add -A
		git commit -m "*** automatic sync commit ***"
	fi
	git pull origin master
	git push origin master

	git status
	cd "$prev"
}

#-------------------------------------------------------------------------------





if [[ $__MY_SHELL__ = "bash" ]]; then
	# Automatically add completion for all aliases to commands having completion functions
	function alias_completion {
		local namespace="alias_completion"

		# parse function based completion definitions, where capture group 2 => function and 3 => trigger
		local compl_regex='complete( +[^ ]+)* -F ([^ ]+) ("[^"]+"|[^ ]+)'
		# parse alias definitions, where capture group 1 => trigger, 2 => command, 3 => command arguments
		local alias_regex="alias ([^=]+)='(\"[^\"]+\"|[^ ]+)(( +[^ ]+)*)'"

		# create array of function completion triggers, keeping multi-word triggers together
		eval "local completions=($(complete -p | sed -Ene "/$compl_regex/s//'\3'/p"))"
		(( ${#completions[@]} == 0 )) && return 0

		# create temporary file for wrapper functions and completions
		rm -f "/tmp/${namespace}-*.tmp" # preliminary cleanup
		local tmp_file; tmp_file="$(mktemp "/tmp/${namespace}-${RANDOM}XXX.tmp")" || return 1

		local completion_loader; completion_loader="$(complete -p -D 2>/dev/null | sed -Ene 's/.* -F ([^ ]*).*/\1/p')"

		# read in "<alias> '<aliased command>' '<command args>'" lines from defined aliases
		local line; while read line; do
			eval "local alias_tokens; alias_tokens=($line)" 2>/dev/null || continue # some alias arg patterns cause an eval parse error
			local alias_name="${alias_tokens[0]}" alias_cmd="${alias_tokens[1]}" alias_args="${alias_tokens[2]# }"

			# skip aliases to pipes, boolean control structures and other command lists
			# (leveraging that eval errs out if $alias_args contains unquoted shell metacharacters)
			eval "local alias_arg_words; alias_arg_words=($alias_args)" 2>/dev/null || continue
			# avoid expanding wildcards
			read -a alias_arg_words <<< "$alias_args"

			# skip alias if there is no completion function triggered by the aliased command
			if [[ ! " ${completions[*]} " =~ " $alias_cmd " ]]; then
				if [[ -n "$completion_loader" ]]; then
					# force loading of completions for the aliased command
					eval "$completion_loader $alias_cmd"
					# 124 means completion loader was successful
					[[ $? -eq 124 ]] || continue
					completions+=($alias_cmd)
				else
					continue
				fi
			fi
			local new_completion="$(complete -p "$alias_cmd")"

			# create a wrapper inserting the alias arguments if any
			if [[ -n $alias_args ]]; then
				local compl_func="${new_completion/#* -F /}"; compl_func="${compl_func%% *}"
				# avoid recursive call loops by ignoring our own functions
				if [[ "${compl_func#_$namespace::}" == $compl_func ]]; then
					local compl_wrapper="_${namespace}::${alias_name}"
						echo "function $compl_wrapper {
							(( COMP_CWORD += ${#alias_arg_words[@]} ))
							COMP_WORDS=($alias_cmd $alias_args \${COMP_WORDS[@]:1})
							(( COMP_POINT -= \${#COMP_LINE} ))
							COMP_LINE=\${COMP_LINE/$alias_name/$alias_cmd $alias_args}
							(( COMP_POINT += \${#COMP_LINE} ))
							$compl_func
						}" >> "$tmp_file"
						new_completion="${new_completion/ -F $compl_func / -F $compl_wrapper }"
				fi
			fi

			# replace completion trigger by alias
			new_completion="${new_completion% *} $alias_name"
			echo "$new_completion" >> "$tmp_file"
		done < <(alias -p | sed -Ene "s/$alias_regex/\1 '\2' '\3'/p")
		source "$tmp_file" && rm -f "$tmp_file"
	}; alias_completion
fi
# clear

# init_ 3500
bind '"jk":vi-movement-mode'
# bind '"^[h":vi-backward-word'

