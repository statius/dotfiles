#!/usr/bin/env bash

# autoenv activation
if [[ "$OSTYPE" == "darwin"* ]]; then 

  [ -f /usr/local/opt/autoenv/activate.sh ] && source /usr/local/opt/autoenv/activate.sh

fi
