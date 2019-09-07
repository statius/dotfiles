#!/usr/bin/env bash

# Safari stylesheet installation script

# if macOS set stylesheet
# see Ask Different Stack Exchange question https://apple.stackexchange.com/questions/56201
if [[ "$OSTYPE" == "darwin"* ]]; then

  # get directory of script
  dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

  defaults write com.apple.Safari.plist UserStyleSheetEnabled 1
  defaults write com.apple.Safari.plist UserStyleSheetLocationURLString "\"$dir/safari.css\""
  defaults write com.apple.Safari.plist WebKitUserStyleSheetEnabledPreferenceKey 1
  defaults write com.apple.Safari.plist WebKitUserStyleSheetLocationPreferenceKey "\"$dir/safari.css\""

  unset dir

fi
