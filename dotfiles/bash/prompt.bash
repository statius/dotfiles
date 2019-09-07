#!/usr/bin/env bash

# shell prompt loosely based on the Solarized and base16 themes.
# heavily inspired by @mathiasbynens prompt: https://github.com/mathiasbynens/dotfiles
# Terminal -> Preferences -> Profiles -> Text -> use 12pt Source Code Pro with 0.9 vertical spacing.
# Terminal -> Preferences -> Profiles -> Text -> use 11pt SF Mono with 1.1 vertical spacing.

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then

  export TERM='gnome-256color'

elif infocmp xterm-256color >/dev/null 2>&1; then

  export TERM='xterm-256color'

fi

prompt_git() {
  local s=''
  local branchName=''

  # check if the current directory is in a Git repository.
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

    # check if the current directory is in .git before running git checks
    if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

      # ensure the index is up to date.
      git update-index --really-refresh -q &>/dev/null

      # check for uncommitted changes in the index.
      if ! $(git diff --quiet --ignore-submodules --cached); then

        s+='+'

      fi

      # check for unstaged changes.
      if ! $(git diff-files --quiet --ignore-submodules --); then

        s+='!'

      fi

      # check for untracked files.
      if [ -n "$(git ls-files --others --exclude-standard)" ]; then

        s+='?'

      fi

      # check for stashed files.
      if $(git rev-parse --verify refs/stash &>/dev/null); then

        s+='$'

      fi

    fi

    # get the short symbolic ref.
    # if HEAD isn’t a symbolic ref, get the short SHA for the latest commit
    # otherwise, just give up.
    branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
      git rev-parse --short HEAD 2> /dev/null || \
      echo '(unknown)')"

    [ -n "${s}" ] && s=" [${s}]"

    echo -e "${1}${branchName}${2}${s}"

  else return

  fi
}

reset="\e[0m"
black="\e[30m"
blue="\e[34m"
cyan="\e[36m"
green="\e[32m"
orange="\e[33m"
magenta="\e[35m"
red="\e[31m"
violet="\e[35m"
white="\e[37m"
yellow="\e[33m"
boldBlack="\e[1;30m"
boldBlue="\e[1;34m"
boldCyan="\e[1;36m"
boldGreen="\e[1;32m"
boldOrange="\e[1;33m"
boldMagenta="\e[1;35m"
boldRed="\e[1;31m"
boldViolet="\e[1;35m"
boldWhite="\e[1;37m"
boldYellow="\e[1;33m"

# highlight the user name when logged in as root.
if [[ "${USER}" == "root" ]]; then

  userStyle="${boldRed}"

else

  userStyle="${boldBlack}"

fi

# highlight the hostname when connected via SSH.
if [[ "${SSH_TTY}" ]]; then

  hostStyle="${boldOrange}"

else

  hostStyle="${boldBlack}"

fi

# Set the terminal title and prompt.
PS1="\[\033]0;\u\007\]" # user base name
PS1+="\[${bold}\]\n" # newline
PS1+="\[${userStyle}\]\u" # username
PS1+="\[${white}\] @ "
PS1+="\[${hostStyle}\]\h" # host
PS1+="\[${white}\] in "
PS1+="\[${boldGreen}\]\w" # working directory full path
PS1+="\$(prompt_git \"\[${white}\] on \[${boldViolet}\]\" \"\[${boldBlue}\]\")" # Git repository details
PS1+="\n"
PS1+="\[${black}\]\$ \[${reset}\]" # ``$ '' (and reset color)
export PS1

PS2="\[${yellow}\]→ \[${reset}\]"
export PS2
