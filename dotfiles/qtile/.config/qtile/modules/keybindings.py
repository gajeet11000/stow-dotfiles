from functools import partial

from libqtile.config import Key
from libqtile.lazy import lazy

from . import user_variables as uv
from .functions import Custom


def init_keybindings(groups):
    keybindings = [
        #  _____ _   _ _   _  ____ _____ ___ ___  _   _ ____
        # |  ___| | | | \ | |/ ___|_   _|_ _/ _ \| \ | / ___|
        # | |_  | | | |  \| | |     | |  | | | | |  \| \___ \
        # |  _| | |_| | |\  | |___  | |  | | |_| | |\  |___) |
        # |_|    \___/|_| \_|\____| |_| |___\___/|_| \_|____/
        #
        Key([uv.SUPER, uv.SHIFT], "f", lazy.function(Custom.float_to_front)),
        Key(
            [uv.SUPER, uv.ALT],
            "f",
            lazy.function(Custom.maximize_by_switching_layout),
            desc="toggle maximize",
        ),
        Key([uv.SUPER], "t", lazy.function(Custom.toggle_current_minimized_groups)),
        Key(
            [uv.SUPER],
            "u",
            lazy.function(Custom.minimize_others),
            desc="Minimize all except master and focused window",
        ),
        Key(
            [uv.SUPER, uv.SHIFT],
            "u",
            lazy.function(Custom.clear_minimized_group),
            lazy.function(Custom.minimize_others),
            desc="clear group then minimize there",
        ),
        Key(
            [uv.SUPER],
            "r",
            lazy.function(Custom.toggle_window_original_restore),
            desc="send window to restore to original and vice-versa",
        ),
        Key(
            [uv.SUPER],
            "d",
            lazy.function(Custom.minimize_all),
            desc="Toggle minimization",
        ),
        #                _       _
        #  ___  ___ _ __(_)_ __ | |_ ___
        # / __|/ __| '__| | '_ \| __/ __|
        # \__ \ (__| |  | | |_) | |_\__ \
        # |___/\___|_|  |_| .__/ \__|___/
        #                 |_|
        Key(
            [uv.SUPER, uv.SHIFT],
            "q",
            lazy.spawn(
                "rofi -show power-menu -modi power-menu:"
                + uv.HOME
                + "/.config/rofi/scripts/rofi-power-menu.sh"
            ),
        ),
        Key(
            [uv.SUPER],
            "s",
            lazy.spawn(
                "rofi -show Home -config "
                + uv.HOME
                + "/.config/rofi/themes/search-config.rasi"
            ),
        ),
        Key(
            [uv.SUPER, uv.SHIFT],
            "s",
            lazy.spawn(
                "rofi -show Home -config "
                + uv.HOME
                + "/.config/rofi/themes/open-terminal-config.rasi"
            ),
        ),
        Key(
            [uv.ALT],
            "space",
            lazy.spawn("bash " + uv.HOME + "/.config/rofi/scripts/rofi-web-search.sh"),
        ),
        Key(
            [uv.SUPER, uv.ALT],
            "b",
            lazy.spawn("bash " + uv.HOME + "/.config/rofi/scripts/rofi-set-bg.sh"),
        ),
        #     _                _ _           _   _
        #    / \   _ __  _ __ | (_) ___ __ _| |_(_) ___  _ __  ___
        #   / _ \ | '_ \| '_ \| | |/ __/ _` | __| |/ _ \| '_ \/ __|
        #  / ___ \| |_) | |_) | | | (_| (_| | |_| | (_) | | | \__ \
        # /_/   \_\ .__/| .__/|_|_|\___\__,_|\__|_|\___/|_| |_|___/
        #         |_|   |_|
        #
        Key([uv.SUPER], "e", lazy.spawn(uv.FILE_MANAGER)),
        Key(
            [uv.SUPER], "space", lazy.spawn("rofi -sort -sorting-method fzf -show drun")
        ),
        Key([uv.SUPER, uv.ALT], "d", lazy.spawn(uv.FILE_MANAGER + " Downloads")),
        Key([uv.SUPER], "Escape", lazy.spawn("xkill")),
        Key([uv.SUPER], "Return", lazy.spawn(uv.TERMINAL)),
        Key([uv.SUPER], "a", lazy.spawn(uv.FILE_MANAGER + " /mnt/" + uv.STORAGE_DRIVE)),
        Key([uv.SUPER], "f", lazy.spawn(uv.WEB_BROWSER)),
        Key([], "Print", lazy.spawn("flameshot gui")),
        #
        #  ____            _
        # / ___| _   _ ___| |_ ___ _ __ ___
        # \___ \| | | / __| __/ _ \ '_ ` _ \
        #  ___) | |_| \__ \ ||  __/ | | | | |
        # |____/ \__, |___/\__\___|_| |_| |_|
        #        |___/
        #
        # INCREASE/DECREASE BRIGHTNESS
        Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s +5%")),
        Key([uv.SUPER], "x", lazy.spawn("brightnessctl s +5%")),
        Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%-")),
        Key([uv.SUPER], "z", lazy.spawn("brightnessctl s 5%-")),
        # INCREASE/DECREASE/MUTE VOLUME
        Key([], "XF86AudioMute", lazy.spawn("amixer -q set Master toggle")),
        Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -q set Master 5%-")),
        Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -q set Master 5%+")),
        Key([uv.SUPER], "m", lazy.spawn("amixer -q set Master toggle")),
        Key([uv.SUPER], "semicolon", lazy.spawn("amixer -q set Master 5%-")),
        Key([uv.SUPER], "apostrophe", lazy.spawn("amixer -q set Master 5%+")),
        # MEDIA PLAYER CONTROL
        Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
        Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
        Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
        Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
        # SWITCH BETWEEN WINDOWS(Vim bindings)
        Key([uv.SUPER], "h", lazy.layout.left(), desc="Move focus to left"),
        Key([uv.SUPER], "l", lazy.layout.right(), desc="Move focus to right"),
        Key([uv.SUPER], "j", lazy.layout.down(), desc="Move focus down"),
        Key([uv.SUPER], "k", lazy.layout.up(), desc="Move focus up"),
        # SWITCH BETWEEN WINDOWS(Arrow keys)
        Key([uv.SUPER], "Left", lazy.layout.left(), desc="Move focus to left"),
        Key([uv.SUPER], "Right", lazy.layout.right(), desc="Move focus to right"),
        Key([uv.SUPER], "Down", lazy.layout.down(), desc="Move focus down"),
        Key([uv.SUPER], "Up", lazy.layout.up(), desc="Move focus up"),
        # MOVE WINDOWS AROUND(Vim bindings)
        Key(
            [uv.SUPER, uv.SHIFT],
            "h",
            lazy.layout.shuffle_left(),
            desc="Move window to the left",
        ),
        Key(
            [uv.SUPER, uv.SHIFT],
            "l",
            lazy.layout.shuffle_right(),
            desc="Move window to the right",
        ),
        Key(
            [uv.SUPER, uv.SHIFT],
            "j",
            lazy.layout.shuffle_down(),
            desc="Move window down",
        ),
        Key([uv.SUPER, uv.SHIFT], "k", lazy.layout.shuffle_up(), desc="Move window up"),
        # RESIZE WINDOWS(Vim bindings)
        Key(
            [uv.SUPER, uv.CTRL],
            "h",
            lazy.function(partial(Custom.resize_window, key="h")),
        ),
        Key(
            [uv.SUPER, uv.CTRL],
            "l",
            lazy.function(partial(Custom.resize_window, key="l")),
        ),
        Key(
            [uv.SUPER, uv.CTRL],
            "j",
            lazy.function(partial(Custom.resize_window, key="j")),
        ),
        Key(
            [uv.SUPER, uv.CTRL],
            "k",
            lazy.function(partial(Custom.resize_window, key="k")),
        ),
        Key([uv.SUPER], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
        Key(
            [uv.SUPER, uv.SHIFT],
            "n",
            lazy.layout.reset(),
            desc="Reset all window sizes",
        ),
        # TOGGLE BETWEEN DIFFERENT LAYOUTS AS DEFINED BELOW
        Key([uv.SUPER], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
        Key([uv.SUPER, uv.CTRL], "r", lazy.reload_config(), desc="Reload the config"),
        Key([uv.SUPER], "c", lazy.window.kill()),
        # TOGGLE FLOATING LAYOUT
        Key([uv.SUPER, uv.SHIFT], "space", lazy.window.toggle_floating()),
        # TOGGLE NEXT AND PREVIOUS WORKSPACE
        Key([uv.SUPER], "comma", lazy.function(Custom.custom_prev_group)),
        Key([uv.SUPER], "period", lazy.function(Custom.custom_next_group)),
        Key(
            [uv.SUPER, uv.SHIFT],
            "comma",
            lazy.function(Custom.regular_custom_prev_group),
        ),
        Key(
            [uv.SUPER, uv.SHIFT],
            "period",
            lazy.function(Custom.regular_custom_next_group),
        ),
    ]

    for group in groups:
        keybindings.extend(
            [
                # SUPER + letter of group = switch to group
                Key(
                    [uv.SUPER],
                    group.name,
                    lazy.group[group.name].toscreen(),
                    desc="Switch to group {}".format(group.name),
                ),
                # SUPER + SHIFT + letter of group = move focused window to group
                Key(
                    [uv.SUPER, uv.SHIFT],
                    group.name,
                    lazy.window.togroup(group.name, switch_group=False),
                    desc="Move focused window to group {}".format(group.name),
                ),
            ]
        )
    return keybindings
