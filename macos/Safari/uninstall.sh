#!/usr/bin/env bash

# Safari stylesheet uninstallation script

# if macOS set stylesheet
if [[ "$OSTYPE" == "darwin"* ]]; then

  # get directory of script
  dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

  defaults write com.apple.Safari.plist UserStyleSheetEnabled 0
  defaults write com.apple.Safari.plist UserStyleSheet UserStyleSheetLocationURLString "\"\""
  defaults write com.apple.Safari.plist WebKitUserStyleSheetEnabledPreferenceKey 0
  defaults write com.apple.Safari.plist WebKitUserStyleSheetLocationPreferenceKey "\"\""
  
  unset dir

fi