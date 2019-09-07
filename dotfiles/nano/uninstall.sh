#!/usr/bin/env bash

# nanorc uninstallation script

# remove `~/.nanorc` symlink
[ -h ~/.nanorc ] && rm -v "$1" ~/.nanorc