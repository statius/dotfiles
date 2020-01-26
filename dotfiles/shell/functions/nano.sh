#!/usr/bin/env sh

# Use Homebrew `nano`, if available.
if [ $( uname ) = "Darwin" ] && [ -x "$( brew --prefix )/bin/nano" ]; then

  function nano {

    # Call Homebrew `nano`.

    "$( brew --prefix )"/bin/nano "$@"
  
  }

fi