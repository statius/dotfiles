#!/usr/bin/env bash

# shell completions

# add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
if [ -e "$HOME/.ssh/config" ]; then

  complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

fi

if [[ "$OSTYPE" == "darwin"* ]]; then

  # tab completion for `defaults read|write NSGlobalDomain`
  complete -W "NSGlobalDomain" defaults

  # add `killall` tab completion for common apps
  complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal" killall

fi
