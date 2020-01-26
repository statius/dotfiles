#!/usr/bin/env sh

# Shell exports file.

# Set XDG directories.
export XDG_CACHE_HOME="${XDG_CONFIG_HOME:-$HOME/.cache}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CONFIG_DIRS="${XDG_DATA_DIRS:='/usr/local/share/:/usr/share/'}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_DATA_DIRS="${XDG_DATA_DIRS:='/usr/local/share/:/usr/share/'}"

# Homebrew settings.
if [ $( uname ) = "Darwin" ] && command -v brew &> /dev/null; then 

  # no emoji
  export HOMEBREW_NO_EMOJI=1

  # do not permit redirects from secure HTTPS to insecure HTTP
  export HOMEBREW_NO_INSECURE_REDIRECT=1

  # abort installation of cask if no checksum is defined
  export HOMEBREW_CASK_OPTS='--require-sha'

  # set for pkg-config to find various Homebrew packages
  # export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"
  # export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"

fi

# Set nano as default (visual) editor.
# (see https://unix.stackexchange.com/questions/4859)
export EDITOR="$( command -v nano )"
export VISUAL="$( command -v nano )"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Prefer UK English and use UTF-8.
# export LANG='en_US.UTF-8'
# export LC_ALL='en_US.UTF-8'

# Don’t clear the screen after quitting a manual page.
# export MANPAGER='less -X'
