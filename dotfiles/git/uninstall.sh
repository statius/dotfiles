#!/usr/bin/env bash

# git uninstallation script

# remove `~/.gitconfig` and `~/.gitignore-global` symlinks
for file in ~/.{gitconfig,gitconfig-local,gitignore-global}; do

  [ -h "$file" ] && rm -v "$1" "$file"

done

# clean up
unset file
