IF_REDIRECT_LOGS=1

scriptPath__utilslogs="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export NC='\033[0m'

function MessageError   { printf "${RED}[Error]${NC} $1\n"; }
function MessageSuccess { printf "${GREEN}[Success]${NC} $1\n"; }
function MessageInfo    { printf "${YELLOW}[Info]${NC} $1\n"; }
function MessageWarning { printf "${YELLOW}[Warning]${NC} $1\n"; }

#PATHS
logs_dir=$scriptPath__utilslogs/../logs
MAIN_LOGS=main_logs
BUILD_LOGS=build_logs
mkdir -p $logs_dir 
rm -f $MAIN_LOGS
rm -f $BUILD_LOGS
function redirect_to {
	[ IF_REDIRECT_LOGS == 0 ] && return

	#save state
	exec 3>&1
	exec 4>&1

	exec &> $logs_dir/$1 
	# exec 2>&1
}
function redirect_to_main_logs {
	[ IF_REDIRECT_LOGS == 0 ] && return

	#save state
	exec 3>&1
	exec 4>&1

	exec &> $logs_dir/$MAIN_LOGS 
	# exec 2>&1
}
function revert_redirection {
	[ IF_REDIRECT_LOGS == 0 ] && return

	exec 1>&3
	exec 1>&4
}
