import os
import subprocess

from libqtile import hook, qtile

from . import user_variables as uv
from .functions import Custom


@hook.subscribe.startup_once
def set_env_vars():
    os.environ["BROWSER"] = uv.WEB_BROWSER
    os.environ["TERM"] = uv.TERMINAL
    os.environ["EDITOR"] = uv.EDITOR
    os.environ["XCURSOR_SIZE"] = uv.CURSOR_SIZE
    os.environ["XCURSOR_THEME"] = uv.CURSOR_THEME
    os.environ["GTK_THEME"] = uv.GTK_THEME
    os.environ["QT_QPA_PLATFORMTHEME"] = uv.QT_THEME


@hook.subscribe.startup_once
def start_once():
    subprocess.call(
        [
            uv.AUTOSTART_SCRIPT,
            uv.WALLPAPERS_PATH,  # Wallpaper paths as arguments.
            uv.LOCKSCREEN_WALLPAPER_PATH,
        ]
    )


@hook.subscribe.client_new
def set_floating(window):
    floating_types = ("notification", "toolbar", "splash", "dialog")
    if (
        window.window.get_wm_transient_for()
        or window.window.get_wm_type() in floating_types
    ):
        window.floating = True
    Custom.switch_max_to_monadtall(qtile)


@hook.subscribe.client_killed
def check_windows_in_max_mode(window):
    Custom.switch_max_to_monadtall(qtile)


@hook.subscribe.client_new
def assign_app_group(client):
    d = {}
    d["1"] = [
        "Navigator",
        "Firefox",
        "Vivaldi-stable",
        "Vivaldi-snapshot",
        "Chromium",
        "Google-chrome",
        "Brave",
        "Brave-browser",
        "navigator",
        "firefox",
        "vivaldi-stable",
        "vivaldi-snapshot",
        "chromium",
        "google-chrome",
        "brave",
        "brave-browser",
    ]
    d["2"] = [
        "Atom",
        "Subl3",
        "Geany",
        "Brackets",
        "Code-oss",
        "Code",
        "TelegramDesktop",
        "Discord",
        "atom",
        "subl3",
        "geany",
        "brackets",
        "code-oss",
        "code",
        "telegramDesktop",
        "discord",
    ]
    d["3"] = [
        "Inkscape",
        "Nomacs",
        "Ristretto",
        "Nitrogen",
        "Feh",
        "inkscape",
        "nomacs",
        "ristretto",
        "nitrogen",
        "feh",
    ]
    d["4"] = ["Gimp", "gimp"]
    d["5"] = ["Meld", "meld", "org.gnome.meldorg.gnome.Meld"]
    d["6"] = ["Vlc", "vlc", "Mpv", "mpv"]
    d["7"] = [
        "VirtualBox Manager",
        "VirtualBox Machine",
        "Vmplayer",
        "virtualbox manager",
        "virtualbox machine",
        "vmplayer",
    ]
    d["8"] = [
        "pcmanfm",
        "Nemo",
        "Caja",
        "Nautilus",
        "org.gnome.Nautilus",
        "Pcmanfm",
        "Pcmanfm-qt",
        "pcmanfm",
        "nemo",
        "caja",
        "nautilus",
        "org.gnome.nautilus",
        "pcmanfm",
        "pcmanfm-qt",
    ]
    d["9"] = [
        "Evolution",
        "Geary",
        "Mail",
        "Thunderbird",
        "evolution",
        "geary",
        "mail",
        "thunderbird",
    ]
    d["0"] = [
        "Spotify",
        "Pragha",
        "Clementine",
        "Deadbeef",
        "Audacious",
        "spotify",
        "pragha",
        "clementine",
        "deadbeef",
        "audacious",
    ]
    ##########################################################
    wm_class = client.window.get_wm_class()[0]

    for i in range(len(d)):
        if wm_class in list(d.values())[i]:
            group = list(d.keys())[i]
            client.togroup(group)
            client.group.toscreen()
