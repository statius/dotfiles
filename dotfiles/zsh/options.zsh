#!/usr/bin/env zsh

# Zsh configuration options file.

# Set Zsh history file.
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# Increase Zsh history size (allow 32^3 entries).
HISTSIZE=32768
SAVEHIST="${HISTSIZE}"

# Case-insensitive globbing (used in pathname expansion).
setopt no_case_glob

# Add leading cd to path names if missing.
setopt auto_cd

# Add timestamp information to Zsh history file.
setopt extended_history

# Share history across multiple Zsh sessions.
setopt share_history

# Append to Zsh history file, rather than overwriting it.
setopt append_history

# Add commands as they are typed, not at shell exit.
setopt inc_append_history

# Do not store duplicate commands in history.
setopt hist_ignore_dups

# Remove blank lines from history.
setopt hist_reduce_blanks

# Verify history substitution.
setopt hist_verify

# Enable command correction.
setopt correct
# setopt correct_all
