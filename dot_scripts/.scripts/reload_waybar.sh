#!/bin/bash

# Kill all running waybar processes
killall -q waybar

# Wait until the processes have been terminated
while pgrep -x waybar >/dev/null; do sleep 1; done

# Restart waybar
waybar &
