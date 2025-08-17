from libqtile.config import Click, Drag
from libqtile.lazy import lazy

from . import user_variables as uv


def init_mouse():
    return [
        Drag(
            [uv.SUPER],
            uv.LEFT_CLICK,
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        Drag(
            [uv.SUPER],
            uv.RIGHT_CLICK,
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
        Click([uv.SUPER], uv.MIDDLE_CLICK, lazy.window.bring_to_front()),
        # Drag(
        #     [uv.CTRL],
        #     uv.LEFT_CLICK,
        #     lazy.window.set_position_floating(),
        #     start=lazy.window.get_position(),
        # ),
        # Drag(
        #     [uv.CTRL],
        #     uv.RIGHT_CLICK,
        #     lazy.window.set_size_floating(),
        #     start=lazy.window.get_size(),
        # ),
        # Click(uv.CTRL, uv.MIDDLE_CLICK, lazy.window.bring_to_front()),
    ]
