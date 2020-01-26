#!/usr/bin/env sh

# Cleanup script.
# - takes one argument, `-f` or `-i`, which is passed to each removal command
# - `$base_dir` must be set in parent script
# - idempotent


# UNINSTALL

# dotfiles
[ -r "${base_dir}"/script/clean-dotfiles.sh ] && source "${base_dir}"/script/clean-dotfiles.sh

# macos
if [ $( uname ) = "Darwin" ]; then
  [ -r "${base_dir}"/script/clean-macos.sh ] && source "${base_dir}"/script/clean-macos.sh
fi

# Mathematica
[ -r "${base_dir}"/script/clean-mathematica.sh ] && source "${base_dir}"/script/clean-mathematica.sh

# Repository directory
[ -L ~/dotfiles-local ] && rm -v "$1" ~/dotfiles-local
