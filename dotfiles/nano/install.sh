#!/usr/bin/env bash

# nanorc installation script

# get directory of script
dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )";

# link `nanorc` into `$HOME`
if [[ "$OSTYPE" == "darwin"* ]]; then

  [ -f "$dir"/nanorc-macos ] && [ -r "$dir"/nanorc-macos ] && ln -snv "$1" "$dir"/nanorc-macos ~/.nanorc

elif [[ "$OSTYPE" == "linux-gnu" ]]; then

  [ -f "$dir"/nanorc-linux ] && [ -r "$dir"/nanorc-linux ] && ln -snv "$1" "$dir"/nanorc-linux ~/.nanorc

fi

# clean up
unset dir