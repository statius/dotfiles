#!/usr/bin/env bash

# dotfiles uninstallation script

# get directory of script
dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

# unlink 
# 1. `bash_profile`
# 2. `bashrc`
# 3. `bash_profile`
# 4. `bash_local`
# 5. `inputrc`
# 6. `path` 
# 7. `shell_local`
# from `$HOME`
for file in ~/.{bash_profile,bashrc,bash_local,inputrc,path,shell_local}; do
  
  rm -v "$1" "$file"

done

unset file

# directory uninstallation loop
for file in "$dir"/*; do
  
  # for directories, run uninstall.sh if present, otherwise unlink
  if [ -d "$file" ]; then
    
    if [ -x "$file"/uninstall.sh ]; then
      
      "$file"/uninstall.sh "$1"

    elif [ -h ~/."$( basename "$file" )" ]; then
    
      rm -v "$1" ~/."$( basename "$file" )"

    fi

  else continue

  fi

done

unset file

unset dir