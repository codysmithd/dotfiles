# Option to make pressing up and down arrow keys searches history with what's been typed.
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Configure history
# https://zsh.sourceforge.io/Doc/Release/Options.html#History
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000
setopt extended_history       # Record timestamp of command in HISTFILE.
setopt hist_expire_dups_first # Delete duplicates first when HISTFILE size exceeds HISTSIZE.
setopt hist_ignore_dups       # Ignore duplicated commands history list.
setopt hist_ignore_space      # Ignore commands that start with space.
setopt hist_verify            # Show command with history expansion to user before running it.
setopt share_history          # Share command history data
