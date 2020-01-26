#!/usr/bin/env sh

# Shell aliases file.


# Easier navigation: .., ..., ...., ....., and ~
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though


# Detect which `ls` flavor is in use.
if ls --color > /dev/null 2>&1; then 

  # GNU `ls`
  ls_colorflag="--color"
  export LS_COLORS='di=01;34:'` # directory
                  `'ln=01;36:'` # symbolic link
                  `'or=37:'`    # symbolic link pointing to a non-existent file (orphan)
                  `'mi=35:'`    # nonexistent file pointed to by a symbolic link 
                  `'so=01;31:'` # socket
                  `'pi=01;33:'` # pipe
                  `'ex=01;32:'` # executable
                  `'bd=33:'`    # block special file
                  `'cd=33:'`    # chararacter special file
                  `'su=01;92:'` # setuid executable
                  `'sg=01;92:'` # setgid executable
                  `'tw=01;95:'` # other-writable directory with sticky bit
                  `'ow=01;95:'` # other-writable directory without sticky bit
                  `'st=01;94:'` # directory with sticky bit
                  `'fi=00:'`    # file
                  `'no=00'      # normal (global default)

else 
  
  # macOS (BSD) `ls`
  ls_colorflag="-G"
  export LSCOLORS='Ex'` # directory
                 `'Gx'` # symbolic link
                 `'Bx'` # socket
                 `'Dx'` # pipe
                 `'Cx'` # exectutable
                 `'dx'` # block special file
                 `'dx'` # chararcter special file
                 `'cx'` # setuid executable
                 `'cx'` # setgid executable
                 `'ex'` # directory with sticky bit
                 `'ex'  # directory without sticky bit
  
fi

# List all files colorized in long format.
alias ll="ls -l ${ls_colorflag}"

# List all files colorized in long format, including dotfiles.
alias la="ls -la ${ls_colorflag}"

# List only directories.
alias ldir="ls -l ${ls_colorflag} | grep --color=never '^d'"

# Always use color output for `ls`.
alias ls="command ls ${ls_colorflag}"

unset ls_colorflag


# Always enable colored `grep` output.
# (note: `GREP_OPTIONS="--color=auto"` is deprecated, hence the alias usage)
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Enable aliases to be sudo-ed.
alias sudo='sudo '

# Reload the shell (i.e. invoke as a login shell).
alias reload="exec $SHELL -l"

# Print each `$PATH` entry on a separate line.
alias path='echo -e ${PATH//:/\\n}'
