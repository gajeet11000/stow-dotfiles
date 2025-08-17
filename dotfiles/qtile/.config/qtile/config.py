from modules.hooks import *
from modules.keybindings import init_keybindings
from modules.layouts import init_floating_layout_config, init_layouts
from modules.misc import *
from modules.mouse import init_mouse
from modules.screens import init_screens
from modules.workspaces import init_groups

if __name__ in ["config", "__main__"]:
    screens = init_screens()


groups = init_groups()

keys = init_keybindings(groups=groups)

layouts = init_layouts()

floating_layout = init_floating_layout_config()

mouse = init_mouse()
