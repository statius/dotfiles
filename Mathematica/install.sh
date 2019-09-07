#!/usr/bin/env bash

# Wolfram Language files installation script

# get directory of script
dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"


# if macOS, link `bin/math` executable into `../bin`
if [[ "$OSTYPE" == "darwin"* ]]; then
  
  [ -x "$dir"/bin/math ] && ln -snv "$1" "$dir"/bin/math "$( dirname "$dir" )"/bin/math

fi


# set `$math_user_base_dir` (`$UserBaseDirectory`) depending on OS
if [[ "$OSTYPE" == "darwin"* ]]; then

  math_user_base_dir=~/Library/Mathematica

elif [[ "$OSTYPE" == "linux-gnu" ]]; then

  math_user_base_dir=~/.Mathematica

fi


# link packages in `Applications` into `$math_user_base_dir/Applications`
# (first create $math_user_base_dir/Applications if necessary)
if [ ! -d "$math_user_base_dir"/Applications ]; then 
  
  mkdir -p "$math_user_base_dir"/Applications

fi

for file in "$dir"/Applications/*; do

  [ -f "$file" ] && [ -r "$file" ] && ln -snv "$1" "$file" "$math_user_base_dir"/Applications/"$( basename "$file" )"
  
done

unset file


# link files in `Kernel` into `$math_user_base_dir/Kernel`
# (first create $math_user_base_dir/Kernel if necessary)
if [ ! -d "$math_user_base_dir"/Kernel ]; then 
  
  mkdir -p "$math_user_base_dir"/Kernel

fi

for file in "$dir"/Kernel/{init,path,KeyEventTranslations}.m; do

  if [ -f "$file" ] && [ -r "$file" ]; then
 
    ln -snv "$1" "$file" "$math_user_base_dir"/Kernel/"$( basename "$file" )"

  fi

done

unset file


# link `FrontEnd/FileHeaders.tr` into `$math_user_base_dir/SystemFiles/FrontEnd/TextResources/FileHeaders.tr`
# (first create `$math_user_base_dir/SystemFiles/FrontEnd/TextResources` if necessary)
if [ ! -d "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources ]; then 
  
  mkdir -p "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources

fi

if [ -f "$dir"/FrontEnd/FileHeaders.tr ] && [ -r "$dir"/FrontEnd/FileHeaders.tr ]; then

  ln -snv "$1" "$dir"/FrontEnd/FileHeaders.tr "$math_user_base_dir"/SystemFiles/FrontEnd/TextResources/FileHeaders.tr

fi


unset dir