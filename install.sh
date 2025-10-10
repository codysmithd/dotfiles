#!/bin/bash
set -e

# Function to print an error message and exit.
error_exit() {
  echo -e "\n${RED}ERROR:${RESET} $1" >&2
  exit 1
}

# Check for tput and set colors.
if ! command -v tput &>/dev/null; then
  error_exit "tput command not found, but is required for this script."
fi
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

update_submodules() {
  printf "Updating submodules..."
  # Capture output, but don't show it unless there's an error (due to set -e).
  if output=$(git submodule update --init --recursive 2>&1); then
    if [ -n "$output" ]; then
      printf "${GREEN}done.${RESET}\n"
      echo "$output" | sed 's/^/  /'
    else
      printf "${GREEN}done.${RESET} (up to date)\n"
    fi
  else
    error_exit "Failed to update submodules."
  fi
}

stow_dotfiles() {
  printf "Stowing zsh to %s..." "$HOME"
  if ! command -v stow &>/dev/null; then
    error_exit "stow not found, please install it."
  fi

  if stow_output=$(stow -v -t "$HOME" zsh 2>&1); then
    # Check if it actually did anything.
    if [ -n "$stow_output" ]; then
      printf "${GREEN}done.${RESET}\n"
      echo "$stow_output" | sed 's/^/  /'
    else
      printf "${GREEN}done.${RESET} (up to date)\n"
    fi
  else
    printf "${RED}error.${RESET}\n"
    echo "$stow_output" | sed 's/^/  /'
    error_exit "Stow command failed."
  fi
}

install_fonts() {
  local font_install_script="./fonts/install.sh"
  if [ -f "$font_install_script" ]; then
    "$font_install_script"
  else
    error_exit "Font installation script not found at $font_install_script"
  fi
}

main() {
  update_submodules
  stow_dotfiles
  install_fonts
}

main "$@"