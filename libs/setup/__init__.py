from .docker import docker_setup
from .fstab import add_windows_storage_fstab
from .nwg_look import export_nwg_looks_settings
from .sddm import sddm_theme_config
from .shell import change_shell, set_fish_colorscheme

__all__ = [
    "docker_setup",
    "add_windows_storage_fstab",
    "export_nwg_looks_settings",
    "sddm_theme_config",
    "change_shell",
    "set_fish_colorscheme",
]