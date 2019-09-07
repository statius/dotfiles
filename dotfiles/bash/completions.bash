#!/usr/bin/env bash

# bash completions

if [[ "$OSTYPE" == "darwin"* ]]; then

  # add Homebrew bash tab completion
  # see https://docs.brew.sh/Shell-Completion
  if type brew &>/dev/null; then

    if [[ -r "$(brew --prefix)"/etc/profile.d/bash_completion.sh ]]; then

      source "$(brew --prefix)"/etc/profile.d/bash_completion.sh

    else

      for COMPLETION in "$(brew --prefix)"/etc/bash_completion.d/*; do

        [[ -r "$COMPLETION" ]] && source "$COMPLETION"

      done

      unset COMPLETION

    fi

  fi

# add other bash completions if present
elif [ -f /etc/bash_completion ]; then

  source /etc/bash_completion

fi
