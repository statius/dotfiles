#!/usr/bin/env bash

# Wolfram Language files uninstallation script

# get directory of script
dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"


# unlink `../bin/math`
if [ -h "$( dirname "$dir" )"/bin/math ]; then
  
  rm -v "$1" "$( dirname "$dir" )"/bin/math

fi


# set `$math_user_base_dir` (`$UserBaseDirectory`) depending on OS
if [[ "$OSTYPE" == "darwin"* ]]; then

  math_user_base_dir=~/Library/Mathematica/Applications

elif [[ "$OSTYPE" == "linux-gnu" ]]; then

  math_user_base_dir=~/.Mathematica

fi


# unlink packages in `$math_user_base_dir/Applications`
for file in "$math_user_base_dir"/Applications/*; do

  rm -v "$1" "$file"
  
done

unset file


# unlink `init.m`, `path.m`, and `KeyEventTranslations/m` from `$math_user_base_dir/Kernel`
for file in "$math_user_base_dir"/Kernel/{init,path,KeyEventTranslations}.m; do

  [ -h "$file" ] && rm -v "$1" "$file"

done

unset file


# unlink `$math_user_base_dir/SystemFiles/FrontEnd/TextResources/FileHeaders.tr`
if [ -h "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources/FileHeaders.tr ]; then

  rm -v "$1" "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources/FileHeaders.tr

fi


# clean up
unset dir