#!/usr/bin/env zsh

# This makes sure all of the scripts we need to load are loaded from
# the executing script folder so they can be found
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
#pushd $DIR >/dev/null 2>&1
. ./util_confirm.zsh
. ./util_validate_email_address.zsh
#popd >/dev/null 2>&1

function get_email_address {
  read "email?$1 "

  validate_email_address $email
  if [[ "$?" == "1" ]]; then
    echo "$fg_bold[red]Email address is invalid. Aborting.$reset_color"
    return 1
  fi
  return 0
}

function get_user_name {
  read "username?Enter name: "

  if [ -z "$username" ]; then
    echo "$fg_bold[red]Username is null or blank. Aborting.$reset_color"
    return 1
  fi
  return 0
}

# This sets up my git config

autoload colors; colors

echo "$fg_bold[yellow]git config --global settings setup$reset_color"

echo
echo "$fg[yellow]Current git config --global settings:$reset_color"

echo
git config -l

# cyan - start
echo $fg_bold[cyan]

# Ask if we should continue...
confirm "Continue and alter git config"
confirm_results=$?

if [[ "$confirm_results" == "1" ]]; then  
  echo "$fg_bold[red]Exiting. No changes were made.$reset_color"
  exit 1
fi

# Get email address...
get_email_address "Enter email address:"
if [[ "$?" == "1" ]]; then exit 1; fi
email_address=$email

# Get confirmation email address...
get_email_address "Confirm email address:"
email_address_confirm=$email

if [[ "$email_address" != "$email_address_confirm" ]]; then
  echo "$fg_bold[red]Email addresses do not match! Aborting.$reset_color"
  exit 1
fi

# Get username...
get_user_name
if [[ "$?" == "1" ]]; then exit 1; fi

# cyan - end
echo $reset_color

# Last confirm...
echo "$fg_bold[magenta]Using:
  Name: $username
  Email: $email_address$reset_color"

echo $fg_bold[cyan]
confirm "Use the above values to alter git config --global settings"
echo $reset_color
confirm_results=$?

if [[ "$confirm_results" == "1" ]]; then  
  echo "$fg_bold[red]Exiting. No changes were made.$reset_color"
  exit 1
fi

echo "$fg[green]Changing git config --global settings...$reset_color"

git config --global user.email $email_address
git config --global user.name $username

# TODO: prompt for this
git config --global init.defaultBranch main

git config --global pager.blame false
git config --global pager.branch false
git config --global pager.config false
git config --global pager.diff false
git config --global pager.log false
git config --global pager.stash false

echo
echo "$fg[green]New git config --global settings:$reset_color"

echo
git config -l

echo
echo "$fg_bold[green]Done.$reset_color"

exit 0
