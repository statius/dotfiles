#!/usr/bin/env bash

# create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_";
}
