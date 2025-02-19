#!/bin/bash

# Check if correct arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <website_without_protocol> <workspace_name>"
  exit 1
fi

# Assign arguments to variables for readability
window_title=$1
workspace_name=$2

# Check if a window with the given title is already open
window=$(hyprctl clients | grep -i "$window_title")

# If the window is not open, launch the application (specific URLs or commands can be added as needed)
if [ -z "$window" ]; then
  $SCRATCHPAD_BROWSER --app="https://$window_title" &
fi

# Toggle the special workspace for the specified application
hyprctl dispatch togglespecialworkspace "$workspace_name"
