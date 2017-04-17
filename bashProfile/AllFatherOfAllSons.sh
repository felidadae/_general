




#-------------------------------------------------------------------------------
#
#	Root of bashprofile
#
#-------------------------------------------------------------------------------




#-------------------------------------------------------------------------------
# move current working path; source config
if [[ $__MY_SHELL__ = "bash" ]]; then
	script_path__allfather="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
else
	script_path__allfather=${0:a:h}
fi
source $script_path__allfather/.config/_config.sh
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
source $script_path__allfather/ps1_bash.sh

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
for ifile in "$currlocation"/softwareShortcuts/*.sh ; do
	[ -e "$ifile" ] || continue
	source "$ifile" 
done
for ifile in "$currlocation"/toggling/*.sh ; do
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
	local ifPushVimTmuxConf="${1}"

	prev=$(pwd)
	cd "$general"
	if [[ "$(git status --porcelain)" != "" ]]; then 
		git add -A
		if [[ "$ifPushVimTmuxConf" == "--nvt" ]]; then
			git rm --cached "configurationFiles/tmux/tmux.conf"
			git rm --cached "configurationFiles/vim/vimrc"
		fi
		git commit -m "*** automatic sync commit ***"
	fi
	git pull origin master
	git push origin master

	git status
	cd "$prev"
}

#-------------------------------------------------------------------------------



#-------------------------------------------------------------------------------

#
##
# Readline bash vim mode 
##
#

if [[ $__MY_SHELL__ = "bash" ]]; then
	bind '"jk":vi-movement-mode'
fi
#-------------------------------------------------------------------------------



#-------------------------------------------------------------------------------

#
##
# Add completion for bash 
##
#

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

for i in $currlocation/external/*; do
	source $i
done
