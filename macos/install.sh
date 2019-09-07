#!/usr/bin/env bash

# macOS settings installation script

if [[ "$OSTYPE" == "darwin"* ]]; then

  # get directory of script
  dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

  # directory installation loop
  for file in "$dir"/*; do
    
    # for directories, run `install.sh` if present
    if [ -d "$file" ]; then
      
      if [ -x "$file"/install.sh ]; then
        
        "$file"/install.sh "$1"

      fi

    else continue
    
    fi

  done

  unset file

  unset dir

fi