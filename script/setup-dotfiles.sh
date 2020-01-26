#!/usr/bin/env sh

# Setup script (dotfiles).
# - takes one argument, `-f` or `-i`, which is passed to each linking command
# - `$base_dir` must be set in parent script
# - idempotent


# LINK

# dotfiles
# - bash_profile
# - bash_rc
# - condarc
# - inputrc
# - nanorc
# - zshrc
# - zshenv
for file in "${base_dir}"/dotfiles/{bash_profile,bashrc,condarc,inputrc,nanorc,zshrc,zshenv}; do

  [ -r "$file" ] && ln -snv "$1" "$file" ~/."$( basename $file )"

done
unset file

# - bash
# - shell
# - zsh
for dir in "${base_dir}"/dotfiles/{bash,shell,zsh}; do

  [ -r "$dir" ] && ln -snv "$1" "$dir" ~/."$( basename $dir )"

done
unset dir

# - config/git/config
if [ -r "${base_dir}"/dotfiles/config/git/config ]; then
  
  [ ! -d ~/.config/git ] && mkdir -pv ~/.config/git
  ln -snv "$1" "${base_dir}"/dotfiles/config/git/config ~/.config/git/config

fi

# - config/git/ignore
if [ -r "${base_dir}"/dotfiles/config/git/ignore ]; then
  
  [ ! -d ~/.config/git ] && mkdir -pv ~/.config/git
  ln -snv "$1" "${base_dir}"/dotfiles/config/git/ignore ~/.config/git/ignore

fi

# - local/share/nano/nano-syntax-improved
if [ -d "${base_dir}"/dotfiles/local/share/nano/nano-syntax-improved ]; then
  
  [ ! -d ~/.local/share/nano ] && mkdir -pv ~/.local/share/nano
  ln -snv "$1" "${base_dir}"/dotfiles/local/share/nano/nano-syntax-improved ~/.local/share/nano/nano-syntax-improved

fi