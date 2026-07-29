-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################

-- See https://wiki.hyprland.org/Configuring/Environment-variables/
local vars = require("configs.variables")

hl.env("BROWSER", vars.BROWSER)
hl.env("SCRATCHPAD_BROWSER", vars.SCRATCHPAD_BROWSER)
hl.env("TERM", vars.TERMINAL)
hl.env("EDITOR", vars.EDITOR)
hl.env("XCURSOR_SIZE", vars.CURSOR_SIZE)
hl.env("XCURSOR_THEME", vars.CURSOR_THEME)
hl.env("HYPRCURSOR_SIZE", vars.CURSOR_SIZE)
hl.env("HYPRCURSOR_THEME", vars.CURSOR_THEME)
hl.env("GTK_THEME", vars.GTK_THEME)
hl.env("WAYLAND_DISPLAY", "wayland-1")

-- NVIDIA Variables
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- Toolkit Backend Variables
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("CLUTTER_BACKEND", "wayland")

-- XDG Specifications
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "sway")

-- QT Variables
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- hl.env("QT_STYLE_OVERRIDE", "kvantum")
