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
currlocation="$general"/shellProfile
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

if [[ $__MY_SHELL__ = "zsh" ]]; then

fi
#-------------------------------------------------------------------------------
