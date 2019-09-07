#!/usr/bin/env bash

# dotfiles installation script

# get directory of script
dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

# link 
# 1. `bash_profile`
# 2. `bashrc`
# 3. `bash_profile`
# 4. `bash_local`
# 5. `inputrc`
# 6. `path` 
# 7. `shell_local`
# into `$HOME`
for file in "$dir"/{bash_profile,bashrc,bash_local,inputrc,path,shell_local}; do
  
  [ -f "$file" ] && [ -r "$file" ] && ln -snv "$1" "$file" ~/."$( basename "$file" )"

done

unset file

# directory installation loop
for file in "$dir"/*; do
  
  # for directories, run install.sh if present, otherwise link with "."
  if [ -d "$file" ]; then
    
    if [ -x "$file"/install.sh ]; then
      
      "$file"/install.sh "$1"

    else
    
      ln -snv "$1" "$file" ~/."$( basename "$file" )"

    fi

  else continue

  fi

done

unset file

unset dir