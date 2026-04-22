#!/usr/bin/env bash

# Kill any existing daemons to start fresh
pkill -u $(id -u) -f gnome-keyring-daemon 2>/dev/null

# Ensure D-Bus is running
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval $(dbus-launch --sh-syntax)
fi

# 1. Start the daemon with specific components
# The '--unlock' flag is key for seamless login if your DM supports it
eval $(gnome-keyring-daemon --start --components=secrets,ssh,pkcs11)

# 2. Export the variables so SSH and other apps can see the keyring
export GNOME_KEYRING_CONTROL=$(ls -d /run/user/$(id -u)/keyring-* 2>/dev/null | head -n 1)
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh

# Optional: Ensure GPG/SSH keys are actually added to the agent
# if they exist in your standard folder
if [ -f "$HOME/.ssh/id_ed25519" ]; then
    ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null
fi

# Print for debugging (you can comment this out once it works)
echo "GNOME Keyring initialized. SSH_AUTH_SOCK: $SSH_AUTH_SOCK"