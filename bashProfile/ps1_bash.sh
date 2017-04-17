if [[ $__MY_SHELL__ = "bash" ]]; then
	COLOR_RED="\033[0;31m"
	COLOR_YELLOW="\033[0;33m"
	COLOR_GREEN="\033[0;32m"
	COLOR_OCHRE="\033[38;5;95m"
	COLOR_BLUE="\033[0;34m"
	COLOR_WHITE="\033[0;37m"
	COLOR_RESET="\033[0m"

	function parse_git_branch() {
		x=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'`
		if [[ "$x" == "" ]]; then
			echo ""
		else
			x=${x:1:-1}
			echo " $x"
		fi
	}
	function git_color() {
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
	function dockerContainersCounter {
		return
		#check if any container is running currently; if so light lamp
		result=$(docker ps -q)
		if [ "$result" == "" ]; then
			echo ""
		else
			docker_icon=⚓
			container_count=$(echo $result | tr ' ' '\n' | wc -l )
			echo -e "$COLOR_GREEN$docker_icon $container_count$COLOR_RESET"
		fi
	} 

	THEIP=$(ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1 }')
	# alias __git_ps1="git branch 2>/dev/null | grep '*' | sed 's/* \(.*\)/(\1)/'"
	
	# @PS1@ tag
	#full path and newline
	export PS1_A='\[\e[1;93m\]\[\e[0m\]\[\e[0;33m\][\w]\[\e[0;35m\]`parse_git_branch`\[\e[0m\]\[\e[0;33m\]\n\$\[\e[0m\] '

	#with docker
	export PS1_C='\[\e[0;33m\]`dayTime`[\w]\[\e[0;35m\]`parse_git_branch``dockerContainersCounter`\[\e[0m\]\[\e[0;33m\]\n\$\[\e[0m\]'

	#i dont know
	export PS1_D='\[\e[0;33m\]`dayTime`[\w]\[\e[0;35m\]`parse_git_branch`\[\e[0m\]\[\e[0;33m\]\n\$\[\e[0m\]'

	PS1="$PS1_A"


	#choose the default value
	# export PS1_DEFAULT="$PS1_A"
	# PS1="$PS1_DEFAULT"

	#But if you export PS1_VARIANT that will be choosed; 
	# [ "$PS1_VARIANT" != "" ] && PS1="$PS1_VARIANT"
fi

