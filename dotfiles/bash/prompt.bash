#!/usr/bin/env bash

# Bash prompt configuration file.
# Inspired by 
# - @mathiasbynens: https://github.com/mathiasbynens/dotfiles
# - @sindresorhus: https://github.com/sindresorhus/pure


# Color codes.
color_reset="\[$( tput sgr0 )\]"
color_bold="\[$( tput bold )\]"

color_black="${color_reset}\[$( tput setaf 0 )\]"
color_red="${color_reset}\[$( tput setaf 1 )\]"
color_green="${color_reset}\[$( tput setaf 2 )\]"
color_yellow="${color_reset}\[$( tput setaf 3 )\]"
color_blue="${color_reset}\[$( tput setaf 4 )\]"
color_magenta="${color_reset}\[$( tput setaf 5 )\]"
color_cyan="${color_reset}\[$( tput setaf 6 )\]"
color_white="${color_reset}\[$( tput setaf 7 )\]"

color_bold_black="${color_bold}\[$( tput setaf 0 )\]"
color_bold_red="${color_bold}\[$( tput setaf 1 )\]"
color_bold_green="${color_bold}\[$( tput setaf 2 )\]"
color_bold_yellow="${color_bold}\[$( tput setaf 3 )\]"
color_bold_blue="${color_bold}\[$( tput setaf 4 )\]"
color_bold_magenta="${color_bold}\[$( tput setaf 5 )\]"
color_bold_cyan="${color_bold}\[$( tput setaf 6 )\]"
color_bold_white="${color_bold}\[$( tput setaf 7 )\]"

color_light_black="${color_reset}\[$( tput setaf 8 )\]"
color_light_red="${color_reset}\[$( tput setaf 9 )\]"
color_light_green="${color_reset}\[$( tput setaf 10 )\]"
color_light_yellow="${color_reset}\[$( tput setaf 11 )\]"
color_light_blue="${color_reset}\[$( tput setaf 12 )\]"
color_light_magenta="${color_reset}\[$( tput setaf 13 )\]"
color_light_cyan="${color_reset}\[$( tput setaf 14 )\]"
color_light_gray="${color_reset}\[$( tput setaf 15 )\]"

color_bold_light_black="${color_bold}\[$( tput setaf 8 )\]"
color_bold_light_red="${color_bold}\[$( tput setaf 9 )\]"
color_bold_light_green="${color_bold}\[$( tput setaf 10 )\]"
color_bold_light_yellow="${color_bold}\[$( tput setaf 11 )\]"
color_bold_light_blue="${color_bold}\[$( tput setaf 12 )\]"
color_bold_light_magenta="${color_bold}\[$( tput setaf 13 )\]"
color_bold_light_cyan="${color_bold}\[$( tput setaf 14 )\]"
color_bold_light_gray="${color_bold}\[$( tput setaf 15 )\]"


# Load `__git_ps1` function.
# (see: https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh)
[[ -r ~/.bash/git-prompt.bash ]] && source ~/.bash/git-prompt.bash


prompt_set_title() {

  # Terminal title function.

  # Emacs terminal does not support settings the title.
  if [[ "${EMACS}" ]] || [[ "${INSIDE_EMACS}" ]]; then
    return
  fi

  # Don't set title over serial console.
  case $TTY in
    /dev/ttyS[0-9]*) 
      return 
      ;;
  esac

  # Set title atomically in one print statement so that it works when XTRACE is enabled.
  echo "\u @ \h in \w"
}


prompt_seconds_to_human_time() {

  # Turn seconds into human readable time.
  # (165392 => 1d 21h 56m 32s)

  local human total_seconds=$1
  local days=$(( total_seconds / 60 / 60 / 24 ))
  local hours=$(( total_seconds / 60 / 60 % 24 ))
  local minutes=$(( total_seconds / 60 % 60 ))
  local seconds=$(( total_seconds % 60 ))

  (( days > 0 )) && human+="${days}d "
  (( hours > 0 )) && human+="${hours}h "
  (( minutes > 0 )) && human+="${minutes}m "
  human+="${seconds}s"

  echo $human

}


prompt_cmd_timer() {

  # Saves a timestamp to `$prompt_cmd_timestamp`.
  # (see: https://tylercipriani.com/blog/2016/01/19/Command-Timing-Bash-Prompt/)

  # Do nothing if completing.
  [[ -n "$COMP_LINE" ]] && return

  # Don't cause a preexec for `$PROMPT_COMMAND`.
  [[ "$BASH_COMMAND" == "$PROMPT_COMMAND" ]] && return

  prompt_cmd_timestamp=${prompt_cmd_timestamp:-$SECONDS}

}


prompt_cmd_exec_time() {

  # Print execution time of previous command if it exceeds threshold:
  # 5 seconds or `$PROMPT_CMD_MAX_EXEC_TIME`, if set.

  local exec_time="$(( $SECONDS - $prompt_cmd_timestamp ))"
  
  if (( $exec_time > ${PROMPT_CMD_MAX_EXEC_TIME:-5} )); then

    # local exec_time_string="\n"
    local exec_time_string="${color_white}> "
    local exec_time_string+="${color_bold_light_red}$( prompt_seconds_to_human_time $exec_time )"
    local exec_time_string+="${color_white} <<<"
    exec_time_string+="\n"

  fi

  echo "$exec_time_string"

}


prompt_user_style() {

  # Highlight the user name when logged in as root.
  # (see: https://stackoverflow.com/questions/18215973)

  if [[ $( id -u ) -eq 0 ]]; then
    echo "${color_bold_red}"
  else
    echo "${color_bold_black}"
  fi

}


prompt_ssh_q() {

  # Determine if session is remote.

  # SSH session if at least one of 
  # - `$SSH_TTY`
  # - `$SSH_CONNECTION`
  # - `$SSH_CLIENT`
  # is set.
  if [[ $SSH_TTY ]] || [[ $SSH_CONNECTION ]] || [[ $SSH_CLIENT ]]; then
    return 0
  fi

  # The `$SSH_*` environmental variables may not be set if using sudo.
  # Recursively test for `sshd` daemon parent process.
  # (see: https://unix.stackexchange.com/questions/9605)
  
  local p=${1:-$PPID}
  local pid name ppid

  read pid name ppid < <( ps -o pid= -o comm= -o ppid= -p $p )

  [[ "$name" =~ sshd ]] && return 0
  [[ "$ppid" -le 1 ]] && return 1

  prompt_ssh_q $ppid

}


prompt_host_style() {

  # Highlight the hostname when connected via SSH.

  if prompt_ssh_q; then
    echo "${color_bold_yellow}"
  else
    echo "${color_bold_black}"
  fi

}


prompt_git() {

  # Git status prompt function.
  # Constructs the git status from the output of the function `__git_ps1`.

  local git_ps1="$( __git_ps1 )"
  local git_regex='^ \(([^ <>=]+)( )?(\*)?(\+)?(#)?(%)?(<)?(>)?(=)?\)$'

  if [[ "${git_ps1}" =~ $git_regex ]]; then

    local git_branch="${BASH_REMATCH[1]}"
    local git_unstaged="${BASH_REMATCH[3]}"
    local git_uncommitted="${BASH_REMATCH[4]}"
    local git_untracked="${BASH_REMATCH[6]}"
    local git_upstream_ahead="${BASH_REMATCH[7]}"
    local git_upstream_behind="${BASH_REMATCH[8]}"

    # Construct repo status string.
    # (include untracked files with unstaged files)
    if [[ -n "${git_untracked}" ]]; then
      local git_status="*${git_uncommitted}"
    else
      local git_status="${git_unstaged}${git_uncommitted}"
    fi

    # Construct upstream information string and translate symbols.
    local git_upstream="${git_upstream_ahead//</⇣}${git_upstream_behind//>/⇡}"

    # Construct git prompt.

    git_ps1="${color_white} on "

    # Color git status differently if repo is dirty.
    if [[ -z "${git_status}" ]]; then
      git_ps1+="${color_bold_cyan}${git_branch}"
    else
      git_ps1+="${color_bold_magenta}${git_branch}${color_bold_light_magenta}${git_status}"
    fi

    # Add upstream information.
    [[ -n "${git_upstream}" ]] && git_ps1+=" ${color_bold_blue}${git_upstream}"

  fi

  echo "$git_ps1"

}


prompt_venv() {

  # Format string specifying Python virtual environment.
  # (see: https://stackoverflow.com/questions/42481726)

  [[ -n $CONDA_PROMPT_MODIFIER ]] && echo "${color_white}(${CONDA_PROMPT_MODIFIER}) "

}


prompt_symbol_style() {

  # Highlight the prompt symbol if argument is nonzero.

  if [[ "$1" -eq 0 ]]; then
    echo "${color_bold_black}"
  else 
    echo "${color_bold_red}"
  fi

}


prompt_symbol() {

  # Reverse the prompt symbol if vi editing enabled.
  # (see: https://unix.stackexchange.com/questions/484997)

  if [[ -o vi ]]; then
    echo "❮"
  else 
    echo "❯"
  fi

}


prompt_command() {

  # Prompt command function.
  
  local exit_code="$?" 

  # Set terminal title.
  PS1="\[\e]0;\]$( prompt_set_title )\a"

  # Set prompt.
  PS1+="$( prompt_cmd_exec_time )"
  PS1+="\n"
  PS1+="$( prompt_user_style )\u"
  PS1+="${color_white} @ "
  PS1+="$( prompt_host_style )\h"
  PS1+="${color_white} in "
  PS1+="${color_bold_green}\w"
  PS1+="$( prompt_git )"
  PS1+="\n"
  PS1+="$( prompt_venv )"
  PS1+="$( prompt_symbol_style $exit_code )$( prompt_symbol ) ${color_reset}"

  # Reset command timestamp.
  unset prompt_cmd_timestamp
  
}


prompt_setup() {

  # Set trap for command timing
  # (see: https://stackoverflow.com/questions/1862510)
  trap 'prompt_cmd_timer' DEBUG

  # Set continuation prompt.
  PS2="${color_light_yellow}→ ${color_reset}"

  # Set options for Git prompt
  GIT_PS1_SHOWDIRTYSTATE=1
  # GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUNTRACKEDFILES=1
  GIT_PS1_SHOWUPSTREAM="auto"

  # Set `$PROMPT_COMMAND`.
  PROMPT_COMMAND=prompt_command

}

prompt_setup
