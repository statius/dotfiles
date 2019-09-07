#!/usr/bin/env bash

# dotfiles uninstallation script

# get directory of script
dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"


# define uninstallation function
function bootstrap() {

  # directory uninstallation loop
  for file in "$dir"/*; do
    
    # for directories, run uninstall.sh
    if [ -d "$file" ]; then
      
      if [ -x "$file"/uninstall.sh ]; then
        
        "$file"/uninstall.sh "$1"

      fi

    else continue

    fi

  done

  unset file

  # unlink `~/bin`
  [ -h ~/bin ] && rm -v "$1" ~/bin

  # unlink `~/$dir`
  [ -h ~/"$( basename "$dir" )" ] && rm -v "$1" ~/"$( basename "$dir" )"

}


# check for run conditions
if [ "$1" == "--force" -o "$1" == "-f" ]; then

  bootstrap -f

elif [ "$1" == "--interactive" -o "$1" == "-i" ]; then

  bootstrap -i

else

  read -p "This will delete existing links. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    
    bootstrap -f
    
  fi

fi


unset bootstrap

unset dir