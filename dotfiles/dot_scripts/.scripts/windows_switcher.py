#!/usr/bin/env python3
import json
import os
import subprocess
import sys


def main():
    """
    Lists all Hyprland windows in a Rofi list with application icons
    and focuses the selected one.
    """
    try:
        clients_result = subprocess.run(
            ["hyprctl", "-j", "clients"], capture_output=True, text=True, check=True
        )
        active_window_result = subprocess.run(
            ["hyprctl", "-j", "activewindow"],
            capture_output=True,
            text=True,
            check=True,
        )
        clients = json.loads(clients_result.stdout)
        active_window_address = json.loads(active_window_result.stdout).get("address")
    except (
        subprocess.CalledProcessError,
        json.JSONDecodeError,
        FileNotFoundError,
    ) as e:
        print(f"Error getting data from Hyprland: {e}", file=sys.stderr)
        sys.exit(1)
    window_map = {}
    rofi_input_list = []
    for client in clients:
        if client["address"] == active_window_address or not client["title"]:
            continue
        if client["workspace"]["id"] > 0:
            address = client["address"]
            title = client["title"]
            app_class = client["class"]
            # workspace_name = client["workspace"]["name"]
            # Tabular format: app_class (30 chars), title after
            display_text = f"{app_class:<10} {title}"
            rofi_entry = f"{display_text}\0icon\x1f{app_class}"
            window_map[rofi_entry] = address
            rofi_input_list.append(rofi_entry)
    if not rofi_input_list:
        subprocess.run(["rofi", "-e", "No other windows to select."], check=False)
        sys.exit(0)
    rofi_input_str = "\n".join(sorted(rofi_input_list))
    try:
        rofi_process = subprocess.run(
            [
                "rofi",
                "-dmenu",
                "-i",
                "-p",
                "  Window > ",
                "-config",
                os.path.expanduser("~/.config/rofi/configs/window_switcher.rasi"),
            ],
            input=rofi_input_str,
            capture_output=True,
            text=True,
            check=True,
        )
        selected_window_text = rofi_process.stdout.strip()
    except subprocess.CalledProcessError:
        print("No window selected.", file=sys.stderr)
        sys.exit(0)
    selected_entry = next(
        (entry for entry in window_map if entry.startswith(selected_window_text)), None
    )
    if selected_entry and selected_entry in window_map:
        address_to_focus = window_map[selected_entry]
        subprocess.run(
            ["hyprctl", "dispatch", "focuswindow", f"address:{address_to_focus}"],
            check=False,
        )
    else:
        print(
            f"Error: Could not find a match for '{selected_window_text}'.",
            file=sys.stderr,
        )
        sys.exit(1)


if __name__ == "__main__":
    main()
