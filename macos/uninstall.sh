#!/usr/bin/env bash

# macOS settings uninstallation script

if [[ "$OSTYPE" == "darwin"* ]]; then

  # get directory of script
  dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

  # directory uninstallation loop
  for file in "$dir"/*; do
    
    # for directories, run `uninstall.sh` if present
    if [ -d "$file" ]; then
      
      if [ -x "$file"/uninstall.sh ]; then
        
        "$file"/uninstall.sh "$1"

      fi

    else continue
    
    fi

  done

  unset file

  unset dir

fi

