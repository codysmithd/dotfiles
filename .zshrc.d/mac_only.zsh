# Applies to Mac's only.
if [[ "$(uname -s)" != "Darwin" ]]; then
    return 0
fi

# Idempotently modify a default & track changes.
changed=0
function change_defaults() {
    local domain="$1" key="$2" type="$3" value="$4"
    local current_value=$(defaults read "$domain" "$key" 2>/dev/null)
    if [[ "$current_value" != "$value" ]]; then
        defaults write "$domain" "$key" $type "$value"
        ((changed++))
    fi
}


# Dock on the left. 
change_defaults com.apple.dock orientation -string left

# Show/hide the dock *much* faster.
change_defaults com.apple.dock autohide-time-modifier -float 0.1
change_defaults com.apple.dock autohide-delay -float 0


if (( changed > 0 )); then
    # Needed for changes to take effect.
    killall Dock
fi
unset -f change_defaults
unset changed