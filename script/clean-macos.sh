#!/usr/bin/env sh

# Cleanup script (macos).
# - takes one argument, `-f` or `-i`, which is passed to each linking command
# - `$base_dir` must be set in parent script
# - idempotent


# UNSET

# macos
# - Safari
defaults write com.apple.Safari.plist UserStyleSheetEnabled 0
defaults write com.apple.Safari.plist UserStyleSheet UserStyleSheetLocationURLString "\"\""
defaults write com.apple.Safari.plist WebKitUserStyleSheetEnabledPreferenceKey 0
defaults write com.apple.Safari.plist WebKitUserStyleSheetLocationPreferenceKey "\"\""

# UNLINK

# macos
# - Services
# (Dealing with spaces in filenames is a pain!)
# (see: https://stackoverflow.com/questions/7039130)
# (see: https://stackoverflow.com/questions/21663090)
# (see: https://unix.stackexchange.com/questions/81349)
find "${base_dir}"/macos/Services \
  -name '*.workflow' \
  -exec sh -c 'rm -v "$1" ~/Library/Services/$( basename "$2" )' _ "$1" '{}' \;


# UNINSTALL

# macos
# - Terminal
