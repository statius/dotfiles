#!/usr/bin/env bash

# dotfiles installation script

# get directory of script
dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"


# define installation function
function bootstrap() {

  # directory installation loop
  for file in "$dir"/*; do
  
    # for directories, run install.sh
    if [ -d "$file" ]; then
    
      if [ -x "$file"/install.sh ]; then
      
        "$file"/install.sh "$1"

      fi

    else continue

    fi

  done

  unset file

  # link `bin` into `$HOME`
  [ -d "$dir"/bin ] && ln -snv "$1" "$dir"/bin ~/bin

  # link `$dir` into `$HOME`
  ln -snv "$1" "$dir" ~/"$( basename "$dir" )"

}


# check for run conditions
if [ "$1" == "--force" -o "$1" == "-f" ]; then

  bootstrap -f

elif [ "$1" == "--interactive" -o "$1" == "-i" ]; then

  bootstrap -i

else

  read -p "This may overwrite existing files. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    
    bootstrap -f
    
  fi

fi

unset bootstrap

unset dir