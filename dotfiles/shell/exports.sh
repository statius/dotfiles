#!/usr/bin/env bash

# shell exports

# Homebrew
if [[ "$OSTYPE" == "darwin"* ]]; then 

  # no emoji
  export HOMEBREW_NO_EMOJI=1

  # set for pkg-config to find various Homebrew packages
  # export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
  # export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"

fi

# set nano as default visual editor
export VISUAL="$( which nano )"

# make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8';

# prefer US English and use UTF-8.
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';

# prefer UK English and use UTF-8.
# export LANG='en_US.UTF-8';
# export LC_ALL='en_US.UTF-8';

# don’t clear the screen after quitting a manual page.
# export MANPAGER='less -X';
