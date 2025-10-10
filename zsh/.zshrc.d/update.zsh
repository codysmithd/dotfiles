#!/usr/bin/env zsh

source "${0:A:h}/logging.zsh"

# Pull changes to the repo.
_dotfiles_update_repo() {
    # Only pull if on `main` and there are no uncommitted changes.
    if [[ "$(git rev-parse --abbrev-ref HEAD)" == "main" ]] && [[ -z "$(git status --porcelain)" ]]; then
        git pull --ff-only
    fi
}

_dotfiles_update_submodules() {
  _dotfiles_announce "Updating submodules"
  # Capture output, but don't show it unless there's an error.
  if output=$(git submodule update --init --recursive 2>&1); then
    if [ -n "$output" ]; then
      _dotfiles_report_success
      echo "$output" | sed 's/^/  /'
    else
      _dotfiles_report_success "(up to date)"
    fi
  else
    _dotfiles_report_error "Failed to update submodules."
    return 1
  fi
}

_dotfiles_stow() {
  _dotfiles_announce "Stowing zsh to ${HOME}"
  if ! command -v stow &>/dev/null; then
    _dotfiles_report_error "Stow not found, please install it."
    return 1
  fi

  if stow_output=$(stow -v -t "$HOME" zsh 2>&1); then
    # Check if it actually did anything.
    if [ -n "$stow_output" ]; then
      _dotfiles_report_success
      echo "$stow_output" | sed 's/^/  /'
    else
      _dotfiles_report_success "(up to date)"
    fi
  else
    _dotfiles_report_error "Stow command failed."
    echo "$stow_output" | sed 's/^/  /' # Show stow's error output.
    return 1
  fi
}

# In interactive shells, (.zshrc sourcing .zshrc.d/) run automatically in the background to auto-update.
if [[ -o interactive ]]; then
    (
        cd ${${(%):-%x}:A:h:h:h} # (Absolute) repo root directory.
        _dotfiles_update_repo
        _dotfiles_update_submodules
        _dotfiles_stow
    ) &>/dev/null &!
fi