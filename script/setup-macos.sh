#!/usr/bin/env sh

# Setup script (macos).
# - takes one argument, `-f` or `-i`, which is passed to each linking command
# - `$base_dir` must be set in parent script
# - idempotent


# SET

# macos
# - Safari
defaults write com.apple.Safari.plist UserStyleSheetEnabled 1
defaults write com.apple.Safari.plist UserStyleSheetLocationURLString "\"${base_dir}/macos/Safari/safari.css\""
defaults write com.apple.Safari.plist WebKitUserStyleSheetEnabledPreferenceKey 1
defaults write com.apple.Safari.plist WebKitUserStyleSheetLocationPreferenceKey "\"${base_dir}/macos/Safari/safari.css\""


# LINK

# macos
# - Services
# (Dealing with spaces in filenames is a pain!)
# (see: https://stackoverflow.com/questions/7039130)
# (see: https://stackoverflow.com/questions/21663090)
# (see: https://unix.stackexchange.com/questions/81349)
find "${base_dir}"/macos/Services \
  -name '*.workflow' \
  -exec sh -c 'ln -snv "${1}" "${2}" ~/Library/Services' _ "${1}" '{}' \;

# old_ifs="$IFS"
# while IFS= read -r -d $'\0' file; do 
#   ln -s "${file}" ~/Library/Services/
# done < <( find "${base_dir}"/macos/Services -name '*.workflow' -print0 )
# unset file
# IFS="$old_ifs"
# unset old_ifs


# INSTALL

# macos
# - Terminal
# osascript <<EOF
# tell application "Terminal"
    
#     local allOpenedWindows
#     local initialOpenedWindows
#     local windowID
    
#     (* Set theme names. *)
#     set themeName to "Base16 Light"
#     set themeFiles to every file of $base_dir/macos/Terminal whose name extension is "terminal"
#     do shell script "echo " & quoted form of themeFiles
    
#     (* Store the IDs of all the open terminal windows. *)
#     set initialOpenedWindows to id of every window
    
#     (* Open the custom themes so that they get added to the list of available terminal themes. *)
#     (* note: this will open additional terminal windows *)
#     repeat with aFile in themeFiles
        
#         do shell script "open 'aFile'"
        
#         (* wait a little bit to ensure that the custom theme is added *)
#         delay 1
        
#     end repeat
    
#     (* Set the custom theme as the default terminal theme. *)
#     set default settings to settings set themeName
    
#     (* Get the IDs of all the currently opened terminal windows. *)
#     set allOpenedWindows to id of every window
    
#     repeat with windowID in allOpenedWindows
        
#         (* Close the additional windows that were opened when custom theme was added. *)
#         if initialOpenedWindows does not contain windowID then
            
#             close (every window whose id is windowID)
            
#         (* Change the theme for the initial opened terminal windows. *)
#         else
            
#             set current settings of tabs of (every window whose id is windowID) to settings set themeName
            
#         end if
    
#     end repeat
    
# end tell
# EOF