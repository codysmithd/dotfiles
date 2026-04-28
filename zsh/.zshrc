local current_dir="${${(%):-%x}:A:h}"
_third_party="${current_dir:h}/third_party"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# zsh-defer for faster startup.
source "${_third_party}/zsh-defer/zsh-defer.plugin.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source "${_third_party}/powerlevel10k/powerlevel10k.zsh-theme"
source "${current_dir}/.p10k.zsh"

# Function to source all .zsh files in a directory
_dotfiles_source_dir() {
  local dir="$1"
  local file
  for file in "$dir"/*.zsh(N); do
    [[ -f "$file" ]] && source "$file"
  done
}

# Source configs
_dotfiles_source_dir "$current_dir/.zshrc.d"

# Zsh syntax highlighting (defered)
zsh-defer source "${_third_party}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

unset _third_party
