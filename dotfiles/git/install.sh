#!/usr/bin/env bash

# git files installation script

# get directory of script
dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

# link `gitconfig` and `gitconfig-local` into `$HOME`
for file in "$dir"/{gitconfig,gitconfig-local}; do

  [ -f "$file" ] && [ -r "$file" ] && ln -snv "$1" "$file" ~/."$( basename "$file" )"

done


# link `gitignore-global` into `$HOME`
if [[ "$OSTYPE" == "darwin"* ]]; then

  if [ -f "$dir"/gitignore-global-macos ] && [ -r "$dir"/gitignore-global-macos ]; then
  
    ln -snv "$1" "$dir"/gitignore-global-macos ~/.gitignore-global

  fi

elif [[ "$OSTYPE" == "linux-gnu" ]]; then

  if [ -f "$dir"/gitignore-global-linux ] && [ -r "$dir"/gitignore-global-linux ]; then
  
    ln -snv "$1" "$dir"/gitignore-global-linux ~/.gitignore-global

  fi

fi

# clean up
unset dir