local M = {}

M.HOME = os.getenv("HOME")
M.SCRIPTS_DIR = M.HOME .. "/.scripts"
M.STORAGE_DIR = "/mnt/Storage/"

M.EDITOR = "nvim"
M.TERMINAL = "kitty"
M.FILE_MANAGER = "thunar"
M.LAUNCHER = string.format(
    'rofi -show drun -config "%s/.config/rofi/configs/application_launcher.rasi"',
    M.HOME
)
M.BROWSER = "zen-browser"
M.SCRATCHPAD_BROWSER = "chromium"
M.CALCULATOR = "gnome-calculator"
M.LOGOUT = "wlogout"

M.REFRESH_MIRRORS = M.SCRIPTS_DIR .. "/refresh_mirrors.sh"
M.RELOAD_WAYBAR = M.SCRIPTS_DIR .. "/reload_waybar.sh"
M.SET_RANDOM_WALLPAPER = M.SCRIPTS_DIR .. "/ChangeWallpaper.sh"
M.WATCH_VSCODE_WORKSPACE = M.SCRIPTS_DIR .. "/WatchForVSCodeWorkspace.sh"
M.VOLUME = M.SCRIPTS_DIR .. "/Volume.sh"
M.BRIGHTNESS = M.SCRIPTS_DIR .. "/Brightness.sh"
M.WINDOWS_SWITCHER = M.SCRIPTS_DIR .. "/windows_switcher.py"

M.WHATSAPP_SPECIAL =
    M.SCRIPTS_DIR .. "/web_scratchpads.sh web.whatsapp.com Whatsapp"
M.SPOTIFY_SPECIAL =
    M.SCRIPTS_DIR .. "/web_scratchpads.sh music.youtube.com Music"
M.CLIPBOARD_SPECIAL = 
    M.SCRIPTS_DIR .. "/app_scratchpads.sh copyq Clipboard copyq show"

M.CLIPBOARD = "copyq show"
M.TOGGLE_NOTIFICATION_CENTER = "swaync-client -t"
M.SCREENSHOT = "env XDG_CURRENT_DESKTOP=Sway flameshot gui"

M.CURSOR_SIZE = "24"
M.CURSOR_THEME = "Bibata-Rainbow-Modern"
M.GTK_THEME = "catppuccin-mocha-mauve-standard+default"

return M