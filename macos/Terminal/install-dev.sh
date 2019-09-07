#!/usr/bin/env bash

# Terminal.app themes installation script

if [[ "$OSTYPE" == "darwin"* ]]; then

  # get directory of script
  dir="$( cd -P "$( dirname "${BASH_SOURCE[0]}" )" && pwd -P )"

  # set the theme in Terminal.app
  osascript <<EOF
tell application "Terminal"
    
    local allOpenedWindows
    local initialOpenedWindows
    local windowID
    
    (* theme names *)
    set themeName to "Base16 Light"
    set themeFiles to every file of $dir whose name extension is "terminal"
    do shell script "echo " & quoted form of themeFiles
    
    (* store the IDs of all the open terminal windows. *)
    set initialOpenedWindows to id of every window
    
    (* open the custom themes so that they get added to the list of available terminal themes *)
    (* note: this will open additional terminal windows *)
    repeat with aFile in themeFiles
        
        do shell script "open 'aFile'"
        
        (* wait a little bit to ensure that the custom theme is added *)
        delay 1
        
    end repeat
    
    (* set the custom theme as the default terminal theme *)
    set default settings to settings set themeName
    
    (* get the IDs of all the currently opened terminal windows *)
    set allOpenedWindows to id of every window
    
    repeat with windowID in allOpenedWindows
        
        (* close the additional windows that were opened when custom theme was added *)
        if initialOpenedWindows does not contain windowID then
            
            close (every window whose id is windowID)
            
        (* change the theme for the initial opened terminal windows *)
        else
            
            set current settings of tabs of (every window whose id is windowID) to settings set themeName
            
        end if
    
    end repeat
    
end tell
EOF

  unset dir

fi