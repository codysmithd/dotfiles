#!/bin/bash
set -e

error_exit() {
  echo -e "\n${RED}ERROR:${RESET} $1" >&2
  exit 1
}

if ! command -v tput &>/dev/null; then
  error_exit "tput command not found, but is required for this script."
fi

GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
RESET=$(tput sgr0)

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
      error_exit "Unsupported OS: $(uname)"
      ;;
  esac

  printf "Installing fonts..."

  local copied_fonts=()
  local font_file
  while IFS= read -r -d '' font_file; do
    local font_name
    font_name=$(basename "$font_file")
    local dest_file="$dest_dir/$font_name"
    if [ ! -f "$dest_file" ]; then
      if ! cp "$font_file" "$dest_dir"; then
        error_exit "Failed to copy $font_file to $dest_dir"
      fi
      copied_fonts+=("$font_name")
    fi
  done < <(find "$(dirname "$0")" -type f -name "*.ttf" -print0)

  # Update font cache on Linux if fonts were copied
  if [[ "$(uname)" == "Linux" ]] && [ ${#copied_fonts[@]} -gt 0 ]; then
    if ! command -v fc-cache &>/dev/null; then
      error_exit "fc-cache command not found, but is required to update the font cache."
    fi
    if ! fc-cache -f; then
      error_exit "fc-cache -f failed."
    fi
  fi

  if [ ${#copied_fonts[@]} -gt 0 ]; then
    printf "${GREEN}Done${RESET}.\n"
    echo "Installed ${#copied_fonts[@]} new font(s):"
    for font in "${copied_fonts[@]}"; do
      echo "  - $font"
    done
  else
    printf "${GREEN}Done${RESET}. (up to date)\n"
  fi
  exit 0
}
main "$@"
