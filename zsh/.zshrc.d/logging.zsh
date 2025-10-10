#!/usr/bin/env zsh

autoload -U colors && colors

# Add italics.
if tput sitm &>/dev/null; then
   _italics=$(tput sitm)
   _reset_italics=$(tput ritm)
else
  _italics=''
  _reset_italics=''
fi

# Announces a task.
#
# @param $1 The message to display.
_dotfiles_announce() {
  printf "%s..." "$1"
}

# Reports success for the previously announced task.
#
# @param $1 Optional success message.
_dotfiles_report_success() {
  printf "${fg[green]}done.${reset_color} ${_italics}%s${reset_color}\n" "$1"
}

# Reports an error for the previously announced task.
#
# @param $1 Error message.
_dotfiles_report_error() {
  printf "${fg[red]}ERROR.${reset_color} %s\n" "$1"
}
