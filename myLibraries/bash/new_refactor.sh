
GREP_CONTEXT_SIZE=3 
alias grep_context="grep --color=always -n -I -A $GREP_CONTEXT_SIZE -B $GREP_CONTEXT_SIZE -r"
function ,gr { grep_context "$1" | less -Sr; export LAST_PATTERN=$1; }

#use with less -r
function refactor {
	perl -i -pe 's/last_container_id/.last_container_id/g' .gitignore
}
