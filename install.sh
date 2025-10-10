#!/usr/bin/env zsh
set -e

main() {
  source ./zsh/.zshrc.d/update.zsh
  _dotfiles_update_submodules
  _dotfiles_stow
  
  ./fonts/install.sh
}

main "$@"