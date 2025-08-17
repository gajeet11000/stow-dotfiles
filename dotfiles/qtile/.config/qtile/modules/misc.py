__all__ = [
    "dgroups_key_binder",
    "dgroups_app_rules",
    "follow_mouse_focus",
    "reconfigure_screens",
    "auto_minimize",
    "wl_input_rules",
    "bring_front_click",
    "floats_kept_above",
    "cursor_warp",
    "auto_fullscreen",
    "focus_on_window_activation",
    "wmname",
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

bring_front_click = "floating_only"
floats_kept_above = True
cursor_warp = True
auto_fullscreen = True

focus_on_window_activation = "focus"  # or smart or focus

wmname = "LG3D"
