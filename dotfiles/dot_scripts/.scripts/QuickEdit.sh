#!/bin/bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Rofi menu for Quick Edit/View of Settings (SUPER E)

# Define preferred text editor and terminal
tty=kitty

# Paths to configuration directories
UserConfigs="chezmoi edit $HOME/.config/hypr/configs"

# Function to display the menu options
menu() {
    cat <<EOF
1. Edit Monitors
2. Edit Programs
3. Edit Autostart
4. Edit Environments
5. Edit Variables
6. Edit Inputs
7. Edit Keybindings 
8. Edit Window and Workspaces
EOF
}

# Main function to handle menu selection
main() {
    choice=$(menu | rofi -i -dmenu | cut -d. -f1)
    
    # Map choices to corresponding files
    case $choice in
        1) file=$UserConfigs/monitors.conf ;;
        2) file=$UserConfigs/programs.conf ;;
        3) file=$UserConfigs/autostart.conf ;;
        4) file=$UserConfigs/environment.conf ;;
        5) file=$UserConfigs/variables.conf ;;
        6) file=$UserConfigs/input.conf ;;
        7) file=$UserConfigs/keybindings.conf ;;
        8) file=$UserConfigs/window_workspaces.conf ;;
        *) return ;;  # Do nothing for invalid choices
    esac

    # Open the selected file in the terminal with the text editor
    $tty -e $file
    chezmoi apply &
}

main
