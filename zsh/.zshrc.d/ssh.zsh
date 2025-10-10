#!/usr/bin/env zsh

# SSH function to auto-copy public key on the first connection.
ssh() {
    local ssh_bin="/usr/bin/ssh"

    # Silently check if public key login is already possible.
    # -o BatchMode=yes: Never ask for a password; fail immediately if the key doesn't work.
    if ! "$ssh_bin" -o PreferredAuthentications=publickey -o BatchMode=yes "$@" 'exit' &>/dev/null; then
        echo "🔑 SSH key not found. Attempting to add it..."
        
        ssh-add -L | head -n 1 | "$ssh_bin" "$@" "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

        if [[ $? -eq 0 ]]; then
            echo "✅ Key added successfully. Proceeding with login."
        else
            echo "⚠️ Could not add key automatically. You may be prompted for a password."
        fi
    fi

    "$ssh_bin" "$@"
}