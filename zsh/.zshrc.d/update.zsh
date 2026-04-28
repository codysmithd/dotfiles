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

_dotfiles_setup_zshrc() {
  _dotfiles_announce "Setting up .zshrc"
  local current_dir="${${(%):-%x}:A:h}"
  local zsh_dir="${current_dir:h}"
  
  local source_line="source $zsh_dir/.zshrc"
  
  # Append if not already present.
  if [[ ! -f "$HOME/.zshrc" ]] || ! grep -Fxq "$source_line" "$HOME/.zshrc"; then
    echo "$source_line" >> "$HOME/.zshrc"
  fi
  
  _dotfiles_report_success
}

_dotfiles_update_path() {
  local target_dir="$1"
  (
    cd "$target_dir" || return 1
    _dotfiles_update_repo
    _dotfiles_update_submodules
  )
}

# In interactive shells, (.zshrc sourcing .zshrc.d/) run automatically in the background to auto-update.
if [[ -o interactive ]]; then
    (
        local repo_root="${${(%):-%x}:A:h:h:h}"
        _dotfiles_update_path "$repo_root"
        _dotfiles_link
    ) &>/dev/null &!
fi
