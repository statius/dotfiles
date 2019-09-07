#!/usr/bin/env bash

# macOS services installation script

# if macOS, unlink services from ~/Library/Services
if [[ "$OSTYPE" == "darwin"* ]]; then

  # get directory of script
  dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

  for file in "$dir"/*.workflow; do

    rm -v "$1" ~/Library/Services/"$( basename "$file" )"

  done

  unset file

  unset dir

fi
