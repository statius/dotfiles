#!/usr/bin/env zsh

# Zsh completions file.

if [[ "$OSTYPE" == "darwin"* ]]; then

  # Add Homebrew Zsh completions
  # (see https://docs.brew.sh/Shell-Completion)
  # (includes git completions: https://github.com/git/git/tree/master/contrib/completion)
  if type brew &>/dev/null; then

    FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  fi

fi

# Use case insensitive path completion.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
                                    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
                                    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
                                    'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# Use partial completion suggestions.
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix


# Initialize Zsh completion system.
autoload -Uz compinit && compinit


# Define key bindings.
bindkey $'^[[A' up-line-or-search    # up arrow
bindkey $'^[[B' down-line-or-search  # down arrow