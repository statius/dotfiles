#!/usr/bin/env bash

# bash exports

# increase Bash history size. Allow 32^3 entries (the default is 500).
export HISTSIZE='32768';
export HISTFILESIZE="${HISTSIZE}";
# omit duplicates and commands that begin with a space from history.
export HISTCONTROL='ignoreboth';
