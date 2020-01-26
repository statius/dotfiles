#!/usr/bin/env sh

# Setup script (Mathematica).
# - takes one argument, `-f` or `-i`, which is passed to each linking command
# - `$base_dir` must be set in parent script
# - idempotent


# Set `$math_user_base_dir` (`$UserBaseDirectory`) depending on OS.
if [ $( uname ) = "Darwin" ]; then
  math_user_base_dir=~/Library/Mathematica
elif [ $( uname ) = "Linux" ]; then
  math_user_base_dir=~/.Mathematica
fi


# LINK

# Mathematica
# - Applications
[ ! -d "$math_user_base_dir"/Applications ] && mkdir -pv "$math_user_base_dir"/Applications

for file in "${base_dir}"/Mathematica/Applications/*; do

  [ -r "$file" ] && ln -snv "$1" "$file" "$math_user_base_dir"/Applications/"$( basename $file )"
  
done
unset file

# - bin/math
if [ $( uname ) = "Darwin" ] && [ -x "${base_dir}"/Mathematica/bin/math ]; then
  
  [ ! -d ~/bin ] && mkdir -pv ~/bin
  ln -snv "$1" "${base_dir}/"Mathematica/bin/math ~/bin/math

fi

# - FrontEnd
if [ -r "${base_dir}"/Mathematica/FrontEnd/FileHeaders.tr ]; then

  if [ ! -d "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources ]; then 
    mkdir -vp "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources
  fi

  ln -snv "$1" \
    "${base_dir}"/Mathematica/FrontEnd/FileHeaders.tr \
    "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources/FileHeaders.tr

fi

# - Kernel
[ ! -d "$math_user_base_dir"/Kernel ] && mkdir -p "$math_user_base_dir"/Kernel

for file in "${base_dir}"/Mathematica/Kernel/{init,KeyEventTranslations}.m; do

  [ -r "$file" ] && ln -snv "$1" "$file" "$math_user_base_dir"/Kernel/"$( basename $file )"

done
unset file


# Clean up.
unset math_user_base_dir