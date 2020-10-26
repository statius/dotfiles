#!/usr/bin/env sh

# Setup script.
# - takes one argument, `-f` or `-i`, which is passed to each linking command
# - `$base_dir` must be set in parent script
# - idempotent


# BOOTSTRAP

[ -r "${base_dir}"/script/bootstrap.sh ] && source "${base_dir}"/script/bootstrap.sh


# LINK

# dotfiles
[ -r "${base_dir}"/script/setup-dotfiles.sh ] && source "${base_dir}"/script/setup-dotfiles.sh

# macos
if [ $( uname ) = "Darwin" ]; then
  [ -r "${base_dir}"/script/setup-macos.sh ] && source "${base_dir}"/script/setup-macos.sh
fi

# Mathematica
[ -r "${base_dir}"/script/setup-mathematica.sh ] && source "${base_dir}"/script/setup-mathematica.sh

# Repository directory
ln -snv "${1}" "${base_dir}" ~/"$( basename ${base_dir} )"