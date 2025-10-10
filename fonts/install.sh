#!/usr/bin/env zsh

source "${0:A:h:h}/zsh/.zshrc.d/logging.zsh"

main() {
  # Determine the destination directory based on the OS
  local dest_dir
  case "$(uname)" in
    "Darwin")
      dest_dir="$HOME/Library/Fonts"
      ;;
    "Linux")
      dest_dir="$HOME/.local/share/fonts"
      mkdir -p "$dest_dir"
      ;;
    *)
      _dotfiles_report_error "Unsupported OS: $(uname)" && exit 1
      ;;
  esac

  _dotfiles_announce "Installing fonts"

  local copied_fonts=()
  local script_dir=${0:A:h}
  for font_file in "$script_dir"/**/*.ttf(.N); do
    local font_name=${font_file:t} # basename
    local dest_file="$dest_dir/$font_name"
    if [[ ! -f "$dest_file" ]]; then
      if ! cp "$font_file" "$dest_dir"; then
        _dotfiles_report_error "Failed to copy $font_file to $dest_dir" && exit 1
      fi
      copied_fonts+=("$font_name")
    fi
  done

  if (( #copied_fonts )); then
    _dotfiles_report_success "${#copied_fonts[@]} new font(s) installed."
    for font in "${copied_fonts[@]}"; do
      print "  - $font"
    done
  else
    _dotfiles_report_success "(up to date)"
  fi

  # Update font cache on Linux if fonts were copied
  if [[ "$(uname)" == "Linux" ]] && (( #copied_fonts )); then
    _dotfiles_announce "Updating font cache"
    if ! command -v fc-cache &>/dev/null; then
      _dotfiles_report_error "fc-cache command not found, but is required to update the font cache." && exit 1
    fi
    if ! fc-cache -f; then
      _dotfiles_report_error "fc-cache -f failed." && exit 1
    fi
    _dotfiles_report_success ""
  fi
}

main "$@"