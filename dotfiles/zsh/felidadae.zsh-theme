# ZSH Theme - Preview: http://gyazo.com/8becc8a7ed5ab54a0262a470555c3eed.png 

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"


if [[ $UID -eq 0 ]]; then
    local user_host='%{$fg[red]%}%n@%m%{$reset_color%}'
    local user_symbol='#'
else
    local user_host='%{$fg[blue]%}%n@%m%{$reset_color%}'
    local user_symbol='$'
fi

local current_dir='%{$fg[yellow]%}‹%~›%{$reset_color%}'
local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='%{$fg[red]%}‹$(rvm-prompt i v g)›%{$reset_color%}'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='%{$fg[red]%}‹$(rbenv version | sed -e "s/ (set.*$//")›%{$reset_color%}'
  fi
fi
local git_branch='$(git_prompt_info)%{$reset_color%}'

if [[ "$CONDA_DEFAULT_ENV" != "" ]]; then
	local python_env='%{$fg[blue]%}‹ conda: $(echo $CONDA_DEFAULT_ENV)›%{$reset_color%}'
else
	local python_env='%{$fg[blue]%}‹ ve: $(basename $VIRTUAL_ENV)›%{$reset_color%}'
fi
local current_dir_=%(4~|.../%3~|%~)
PROMPT="╭─${current_dir}
*  ${git_branch} ${python_env} 
╰─%B${user_symbol}%b "
RPS1="%B${return_code}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[red]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
