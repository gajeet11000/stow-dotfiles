from libqtile import bar, qtile, widget
from libqtile.config import Screen

from . import user_variables as uv


def init_screens():
    return [
        Screen(
            top=bar.Bar(
                widgets=get_bar_widgets(),
                size=30,
                border_color="#282738",
            ),
        ),
    ]


def get_bar_widgets():
    return [
        widget.GroupBox(
            font="FontAwesome Regular",
            fontsize=24,
            borderwidth=3,
            highlight_method="block",
            active="#E0B0FF",
            block_highlight_text_color="#00ff00",
            highlight_color="#4B427E",
            inactive="#282738",
            foreground="#4B427E",
            background="#353446",
            this_current_screen_border="#353446",
            this_screen_border="#353446",
            other_current_screen_border="#353446",
            other_screen_border="#353446",
            urgent_border="#353446",
            rounded=True,
            disable_drag=True,
        ),
        widget.Spacer(
            length=8,
            background="#353446",
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/1.png",
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/layout.png", background="#353446"
        ),
        widget.CurrentLayout(
            background="#353446",
            foreground="#E0B0FF",
            fmt="{}",
            font="JetBrains Bold",
            fontsize=14,
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/1.png",
        ),
        widget.WindowName(
            background="#353446",
            format="{name}",
            font="JetBrains Bold",
            foreground="#E0B0FF",
            empty_group_string="Desktop",
            fontsize=14,
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/3.png",
        ),
        widget.Net(
            font="JetBrains Bold",
            format="  {down:.1f}{down_suffix}        {up:.1f}{up_suffix}  ",
            background="#282738",
            foreground="#E0B0FF",
            fontsize=16,
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/9.png",
            background="#E0B0FF",
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/8.png",
            background="#E0B0FF",
        ),
        widget.Systray(
            background="#282738",
            icon_size=22,
            padding=5,
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/6.png",
            background="#353446",
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/Misc/ram.png",
            background="#353446",
        ),
        widget.Spacer(
            length=-7,
            background="#353446",
        ),
        widget.Memory(
            background="#353446",
            format="{MemUsed: .0f}{mm}",
            foreground="#E0B0FF",
            font="JetBrains Bold",
            fontsize=16,
            update_interval=1,
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/2.png",
        ),
        widget.Spacer(
            length=8,
            background="#353446",
        ),
        widget.BatteryIcon(
            theme_path="~/.config/qtile/Assets/Battery/",
            background="#353446",
            scale=1,
        ),
        widget.Battery(
            font="JetBrains Bold",
            background="#353446",
            foreground="#E0B0FF",
            format="{percent:2.0%}",
            fontsize=16,
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/2.png",
        ),
        widget.Spacer(
            length=8,
            background="#353446",
        ),
        widget.Volume(
            font="JetBrains Bold",
            theme_path="~/.config/qtile/Assets/Volume/",
            emoji=True,
            fontsize=16,
            background="#353446",
            mouse_callbacks={uv.RIGHT_CLICK: lambda: qtile.cmd_spawn(uv.PAVUCONTROL)},
        ),
        widget.Spacer(
            length=-5,
            background="#353446",
            mouse_callbacks={uv.RIGHT_CLICK: lambda: qtile.cmd_spawn(uv.PAVUCONTROL)},
        ),
        widget.Volume(
            font="JetBrains Bold",
            background="#353446",
            foreground="#E0B0FF",
            fontsize=16,
            mouse_callbacks={uv.RIGHT_CLICK: lambda: qtile.cmd_spawn(uv.PAVUCONTROL)},
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/5.png",
            background="#353446",
        ),
        widget.Image(
            filename="~/.config/qtile/Assets/Misc/clock.png",
            background="#282738",
            margin_y=6,
            margin_x=5,
        ),
        widget.Clock(
            format="%a, %b %d-%m-%Y %H:%M:%S",
            background="#282738",
            foreground="#E0B0FF",
            font="JetBrains Bold",
            fontsize=16,
        ),
    ]
