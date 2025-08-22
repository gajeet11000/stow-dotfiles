# ~/.profile

# Start gnome-keyring-daemon with necessary components and export environment vars
if command -v gnome-keyring-daemon > /dev/null; then
    eval "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)"
    export SSH_AUTH_SOCK
    export GPG_AGENT_INFO
    export GNOME_KEYRING_CONTROL
    export GNOME_KEYRING_PID
fi

# Additional environment setups you may have

# For example, set XDG_RUNTIME_DIR if not set (usually set by systemd user session)
# if [ -z "$XDG_RUNTIME_DIR" ]; then
#     export XDG_RUNTIME_DIR="/run/user/$(id -u)"
# fi
