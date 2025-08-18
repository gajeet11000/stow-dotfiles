#!/bin/bash

# Function to run a command if it's not already running
run() {
  if ! pgrep -x "$(basename "$1" | head -c 15)" >/dev/null; then
    "$@" &
  fi
}

# Check if the correct number of arguments is provided
if [ $# -ne 2 ]; then
  echo "Usage: $0 <wallpapers_path> <lockscreen_wallpapers_path>"
  exit 1
fi

# Set paths for wallpapers and lockscreen wallpapers
wallpapers_path="$1"
lockscreen_wallpapers_path="$2"

# Set a random wallpaper from the specified path using feh
feh --bg-fill -z "$wallpapers_path" &
betterlockscreen -u "$lockscreen_wallpapers_path" &

# Fix mouse cursor
xsetroot -cursor_name left_ptr &

# Start polkit agent (needed for mounting drives, network manager, etc.)
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# Start notification daemon
run dunst

# Start file manager daemon (optional: remove if not using Thunar)
run thunar --daemon

# Start network manager applet
run nm-applet

# Start power manager (optional: handles brightness, battery, lid, etc.)
run xfce4-power-manager --daemon

# Enable NumLock on startup
run numlockx on

# Start Bluetooth manager applet
run blueman-applet

# Start compositor (Picom for transparency, shadows, etc.)
run picom --config "$HOME/.config/picom/picom.conf"

# Start user applications at boot time
run copyq               # Clipboard manager
run flameshot           # Screenshot tool
run kdeconnect-indicator  # KDE Connect indicator for device integration
