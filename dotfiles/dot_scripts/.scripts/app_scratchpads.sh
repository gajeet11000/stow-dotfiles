#!/usr/bin/env bash

if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <window_class> <workspace_name> <command...>"
    exit 1
fi

window_class="$1"
workspace_name="$2"
shift 2

# Launch if not already running
if ! hyprctl clients | grep -iq "^\\s*class: $window_class$"; then
    # Lauch
    "$@" &

    # Move it to the special workspace
    hyprctl dispatch "hl.dsp.window.move({workspace=\"special:$workspace_name\", window=\"class:^$window_class$\"})"
fi

# Toggle the special workspace
hyprctl dispatch "hl.dsp.workspace.toggle_special(\"$workspace_name\")"