#!/usr/bin/env zsh

# Credit: https://gist.github.com/guessi/82a73ee7eb2b1216eb9db17bb8d65dd1

regex="^(([A-Za-z0-9]+((\.|\-|\_|\+)?[A-Za-z0-9]?)*[A-Za-z0-9]+)|[A-Za-z0-9]+)@(([A-Za-z0-9]+)+((\.|\-|\_)?([A-Za-z0-9]+)+)*)+\.([A-Za-z]{2,})+$"

function validate_email_address {
  if [[ $1 =~ ${regex} ]]; then
    # Valid
    return 0
  else
    # Invalid
    return 1
  fi
}