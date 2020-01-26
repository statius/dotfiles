#!/usr/bin/env bash

# Bash completions file.

# Add Homebrew bash completions.
# (see: https://docs.brew.sh/Shell-Completion)
# (includes git completions: https://github.com/git/git/tree/master/contrib/completion)
if [[ "$OSTYPE" == "darwin"* ]] && hash brew 2> /dev/null; then

  if [[ -r "$(brew --prefix)"/etc/profile.d/bash_completion.sh ]]; then

    source "$(brew --prefix)"/etc/profile.d/bash_completion.sh

  else

    for completion in "$(brew --prefix)"/etc/bash_completion.d/*; do
      [[ -r "$completion" ]] && source "$completion"
    done
    unset completion

  fi

fi

# Add other bash completions if present.
if [[ -r /etc/bash_completion ]]; then

  source /etc/bash_completion

fi
