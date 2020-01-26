#!/usr/bin/env bash

# Bash configuration options file.

# Increase bash history size (allow 32^3 entries).
HISTSIZE='32768'
HISTFILESIZE="${HISTSIZE}"

# Omit duplicates and commands that begin with a space from history.
HISTCONTROL='ignoreboth'

# Use case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob

# Append to the bash history file, rather than overwriting it.
shopt -s histappend

# Autocorrect typos in path names when using `cd`.
shopt -s cdspell
