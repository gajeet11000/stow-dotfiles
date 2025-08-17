from libqtile import layout
from libqtile.config import Match

from . import utils

common_configs = {
    "margin": 8,
    "border_width": 4,
    "border_focus": "#E0B0FF",
    "border_normal": "#000000",
}


def init_layouts():
    return [
        layout.MonadTall(**common_configs),
        layout.Floating(**common_configs),
        layout.Max(**common_configs),
    ]


def init_floating_layout_config():
    """
    Initialize the floating layout with custom rules.
    This function is called in the main config file.
    """
    return layout.Floating(
        **common_configs,
        float_rules=[
            *layout.Floating.default_float_rules,
            *[Match(wm_class=c) for c in utils.FLOATING_CLASS_LIST],
            *[Match(title=t) for t in utils.FLOATING_TITLE_LIST],
        ],
    )
