#!/bin/bash

# check_dependencies: verifies that jq and rofi are installed before proceeding
check_dependencies() {
    for cmd in jq rofi hyprctl; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            echo "Error: '$cmd' is not installed or not in PATH." >&2
            exit 1
        fi
    done
}

# get_clients_json: fetches the current list of open windows from hyprctl in JSON format
get_clients_json() {
    hyprctl clients -j
}

# get_active_window_address: fetches the address of the currently focused window, used to exclude it from the list
get_active_window_address() {
    hyprctl activewindow -j | jq -r '.address // empty'
}

# build_window_list: parses the clients JSON into "title<TAB>pid" lines, skipping special workspaces and the active window
build_window_list() {
    local clients_json="$1"
    local active_address="$2"
    echo "$clients_json" | jq -r --arg active "$active_address" \
        '.[] | select((.workspace.name | startswith("special") | not) and (.address != $active)) | "\(.title)\t\(.pid)"'
}

# show_rofi_menu: displays window titles in rofi and returns the line the user selected
show_rofi_menu() {
    local window_list="$1"
    local config="$HOME/.config/rofi/configs/window_switcher.rasi"
    echo "$window_list" | cut -f1 | rofi -dmenu -i -no-custom -config "$config" -p "Switch Window"
}

# get_pid_for_title: looks up the PID matching the title selected in rofi
get_pid_for_title() {
    local window_list="$1"
    local selected_title="$2"
    echo "$window_list" | awk -F'\t' -v title="$selected_title" '$1 == title {print $2; exit}'
}

# focus_window: dispatches a focus command to hyprctl for the given PID
focus_window() {
    local pid="$1"
    hyprctl dispatch "hl.dsp.focus({window = \"pid:$pid\"})"
}

# main: orchestrates the full flow, fetching windows, showing the menu, and focusing the selection
main() {
    check_dependencies

    local clients_json
    clients_json="$(get_clients_json)"

    local active_address
    active_address="$(get_active_window_address)"

    local window_list
    window_list="$(build_window_list "$clients_json" "$active_address")"

    if [[ -z "$window_list" ]]; then
        echo "No open windows found." >&2
        exit 1
    fi

    local selected_title
    selected_title="$(show_rofi_menu "$window_list")"

    # exit quietly if the user cancelled rofi (Esc or empty selection)
    if [[ -z "$selected_title" ]]; then
        exit 0
    fi

    local pid
    pid="$(get_pid_for_title "$window_list" "$selected_title")"

    if [[ -z "$pid" ]]; then
        echo "Error: could not resolve PID for selected window." >&2
        exit 1
    fi

    focus_window "$pid"
}

main