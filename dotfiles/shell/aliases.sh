#!/usr/bin/env bash

# easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"


# detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then 

  # GNU `ls`
  colorflag="--color"
  export LS_COLORS='no=00:fi=00:di=01;34:ow=34:tw=34:ln=01;36:mi=35:or=36:hl=01;35:pi=01;33:so=01;31:bd=33:cd=33:ex=01;32:su=32:sg=32'

else 
  
  # macOS `ls`
  colorflag="-G"
  export LSCOLORS='ExGxBxDxCxdxdxcxcxexex'
  
fi

# list all files colorized in long format
alias ll="ls -l ${colorflag}"

# list all files colorized in long format, including dot files
alias la="ls -la ${colorflag}"

# list only directories
alias ldir="ls -l ${colorflag} | grep --color=never '^d'"

# always use color output for `ls`
alias ls="command ls ${colorflag}"

# always enable colored `grep` output
# note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage.
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# use homebrew nano, if available
# note: macOS nano can't find homebrew sytax coloring files
if [[ "$OSTYPE" == "darwin"* ]] && [ -x /usr/local/bin/nano ]; then

  alias nano="/usr/local/bin/nano"

fi

# enable aliases to be sudo-ed
alias sudo='sudo '

# reload the shell (i.e. invoke as a login shell)
alias reload="exec $SHELL -l"

# print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'
