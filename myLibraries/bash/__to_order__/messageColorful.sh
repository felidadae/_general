export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export NC='\033[0m'

function MessageError   { printf "${RED}[Error]${NC} $1\n"; }
function MessageSuccess { printf "${GREEN}[Success]${NC} $1\n"; }
function MessageInfo    { printf "${YELLOW}[Info]${NC} $1\n"; }