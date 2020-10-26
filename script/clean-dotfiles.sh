#!/usr/bin/env sh

# Cleanup script (dotfiles).
# - takes one argument, `-f` or `-i`, which is passed to each linking command
# - idempotent


empty_dir_q() {

  # Tests if argument is an empty directory.
  # (see: https://unix.stackexchange.com/questions/202243)

  local files

  [ -d "${1}" ] && files=$( ls -qAL -- "${1}" ) && [ -z "${files}" ]

}


# UNLINK

# dotfiles
# - bash_profile
# - bash_rc
# - condarc
# - inputrc
# - nanorc
# - zshrc
# - zshenv
for file in ~/.{bash_profile,bashrc,condarc,inputrc,nanorc,zshrc,zshenv}; do

  [ -L "${file}" ] && rm -v "${1}" "${file}"

done
unset file

# - bash
# - shell
# - zsh
for dir in ~/.{bash,shell,zsh}; do

  [ -L "${dir}" ] && rm -v "${1}" "${dir}"

done
unset dir

# - config/git/config
# - config/git/ignore
[ -L ~/.config/git/config] && rm -v "${1}" ~/.config/git/config
[ -L ~/.config/git/ignore] && rm -v "${1}" ~/.config/git/ignore

if [ -d ~/.config/git ] && empty_dir_q ~/.config/git; then
  rm -rv "${1}" ~/.config/git
fi

# - local/share/nano/nano-syntax-improved
[ -L ~/.local/share/nano/nano-syntax-improved] && rm -v "${1}" ~/.local/share/nano/nano-syntax-improved

if [ -d ~/.local/share/nano ] && empty_dir_q ~/.local/share/nano; then
  rm -rv ~/.local/share/nano
fi


# Clean up.
unset empty_dir_q