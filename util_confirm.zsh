#!/usr/bin/env zsh

function confirm() {
  local prompt default response
 
  if [ "$1" ]; then prompt="$1"; else prompt="Are you sure"; fi
  prompt="$prompt [y/N]?"
 
  # Loop forever until the user enters a valid response (Y/N or Yes/No).
  while true; do
    read "response?$prompt "
    case "$response" in
      [y])
        return 0
        ;;
      [N])
        return 1
        ;;
      *) # Anything else (including a blank) is invalid.
        ;;
    esac
  done
} 