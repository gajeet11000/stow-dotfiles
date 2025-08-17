import os

SUPER = "mod4"
ALT = "mod1"
CTRL = "control"
SHIFT = "shift"
LEFT_CLICK = "Button1"
MIDDLE_CLICK = "Button2"
RIGHT_CLICK = "Button3"
TERMINAL = "ghostty"
WALLPAPERS_PATH = "/mnt/Storage/PHOTOS/Wallpapers"
LOCKSCREEN_WALLPAPER_PATH = WALLPAPERS_PATH + "/archlinux4k.jpg"
WEB_BROWSER = "zen-browser"
FILE_MANAGER = "thunar"
STORAGE_DRIVE = "Storage"
HOME = os.path.expanduser("~")
AUTOSTART_SCRIPT = os.path.join(HOME, ".config", "qtile", "scripts", "autostart.sh")
PAVUCONTROL = "pavucontrol -t 4"
