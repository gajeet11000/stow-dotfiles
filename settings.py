import os

EXCLUDED_DIRS = {"sddm"}

ROOT_DIR = os.path.abspath(os.path.dirname(__file__))
DOTFILES_DIR = os.path.join(ROOT_DIR, "dotfiles")
HOME_DIR = os.path.expanduser("~")
SYSTEM_SDDM_THEMES_DIR = "/usr/share/sddm/themes/"
FSTAB_PATH = "/etc/fstab"
FISH_SHELL_PATH = "/usr/bin/fish"

__all__ = [
    "EXCLUDED_DIRS",
    "SYSTEM_SDDM_THEMES_DIR",
    "DOTFILES_DIR",
    "ROOT_DIR",
    "FISH_SHELL_PATH",
    "HOME_DIR",
    "FSTAB_PATH",
]
