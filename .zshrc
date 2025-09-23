# Absolute path of the current file.
local _ZSHRC_DIR=${${(%):-%x}:A:h}

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

_source_if_exists() {
  [[ ! -f "$1" ]] || source "$1"
}

# zsh-defer for faster startup.
_source_if_exists "${_ZSHRC_DIR}/third_party/zsh-defer/zsh-defer.plugin.zsh"

# Source all files in .zshrc.d
for file in $HOME/.zshrc.d/*.zsh(N); do
  _source_if_exists "$file"
done

# To customize prompt, run `p10k configure` or edit ~/.zshrc.d/.p10k.zsh.
_source_if_exists "${_ZSHRC_DIR}/third_party/powerlevel10k/powerlevel10k.zsh-theme"
_source_if_exists "$HOME/.zshrc.d/.p10k.zsh"

# zsh-syntax-highlighting
_source_if_exists "${_ZSHRC_DIR}/third_party/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

unset _ZSHRC_DIR _source_if_exists