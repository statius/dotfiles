#!/usr/bin/env sh

# Setup script (Mathematica).
# - takes one argument, `-f` or `-i`, which is passed to each linking command
# - `$base_dir` must be set in parent script
# - idempotent


empty_dir_q() {

  # Tests if argument is an empty directory.
  # (see: https://unix.stackexchange.com/questions/202243)

  local files

  [ -d "${1}" ] && files=$( ls -qAL -- "${1}" ) && [ -z "${files}" ]

}


# Set `$math_user_base_dir` (`$UserBaseDirectory`) depending on OS.
if [ $( uname ) = "Darwin" ]; then
  math_user_base_dir=~/Library/Mathematica
elif [ $( uname ) = "Linux" ]; then
  math_user_base_dir=~/.Mathematica
fi


# UNLINK

# Mathematica
# - Applications
for file in "${base_dir}"/Mathematica/Applications/*; do

  [ -L "${file}" ] && rm -v "${1}" "${file}"
  
done
unset file

# - bin/math
[ -L ~/bin/math ] && rm -v ~/bin/math
  
if [ ! -d ~/bin ] && empty_dir_q ~/bin; then
  rm -rv ~/bin
fi

# - FrontEnd
if [ -L "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources/FileHeaders.tr ]; then
  rm -v "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources/FileHeaders.tr
fi

if [ ! -d "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources ] && \
  empty_dir_q "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources
then
  rm -rv "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources
fi

# - Kernel
[ ! -d "$math_user_base_dir"/Kernel ] && mkdir -p "$math_user_base_dir"/Kernel

for file in "$math_user_base_dir"/Kernel/{init,KeyEventTranslations}.m; do

  [ -L "${file}" ] && rm -v "${1}" "${file}"

done
unset file


# Clean up.
unset math_user_base_dir