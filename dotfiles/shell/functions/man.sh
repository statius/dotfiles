#!/usr/bin/env sh

# Use colored man pages.
# (see: https://unix.stackexchange.com/questions/108699)
# (see: https://unix.stackexchange.com/questions/119)
man() {

  # Set `$LESS_TERMCAP_*` environmental variables for `man`.

  env LESS_TERMCAP_mb="$( tput bold; tput setaf 1 )" \
      LESS_TERMCAP_md="$( tput bold; tput setaf 0 )" \
      LESS_TERMCAP_me="$( tput sgr0 )" \
      LESS_TERMCAP_so="$( tput bold; tput setaf 9 )" \
      LESS_TERMCAP_se="$( tput sgr0 )" \
      LESS_TERMCAP_us="$( tput smul; tput setaf 3 )" \
      LESS_TERMCAP_ue="$( tput rmul; tput sgr0 )" \
      man "$@"

}
