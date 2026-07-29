local vars = require("configs.variables")
local utils = require("configs.utils")
local SUPER = "SUPER"
local SUPER_SHIFT = "SUPER+SHIFT"
local SUPER_CTRL = "SUPER+CTRL"
local SUPER_ALT = "SUPER+ALT"

-- ###################
-- ### KEYBINDINGS ###
-- ###################

-- Scripts
hl.bind(SUPER .. "+RETURN", hl.dsp.exec_cmd(vars.TERMINAL))
hl.bind(SUPER_ALT .. "+N", hl.dsp.exec_cmd(vars.TERMINAL))
hl.bind(SUPER .. "+E", hl.dsp.exec_cmd(vars.FILE_MANAGER))
hl.bind(SUPER .. "+A", hl.dsp.exec_cmd(vars.FILE_MANAGER .. " " .. vars.STORAGE_DIR))
hl.bind(SUPER .. "+B", hl.dsp.exec_cmd(vars.BROWSER))
hl.bind(SUPER .. "+SPACE", hl.dsp.exec_cmd(vars.LAUNCHER))
hl.bind(SUPER_SHIFT .. "+Q", hl.dsp.exec_cmd(vars.LOGOUT))
hl.bind(SUPER_CTRL .. "+W", hl.dsp.exec_cmd(vars.RELOAD_WAYBAR))
hl.bind("Print", hl.dsp.exec_cmd("env XDG_CURRENT_DESKTOP=Sway flameshot gui"))
hl.bind(SUPER .. "+D", hl.dsp.exec_cmd(vars.FILE_MANAGER .. " " .. vars.HOME .. "/Downloads"))
hl.bind(SUPER .. "+Q", hl.dsp.exec_cmd(vars.CALCULATOR))
hl.bind(SUPER .. "+N", hl.dsp.exec_cmd(vars.TOGGLE_NOTIFICATION_CENTER))
hl.bind(SUPER_ALT .. "+B", hl.dsp.exec_cmd(vars.SET_RANDOM_WALLPAPER))
hl.bind(SUPER .. "+W", hl.dsp.exec_cmd(vars.WINDOWS_SWITCHER))

-- Window actions
hl.bind(SUPER .. "+F", hl.dsp.window.fullscreen({mode="maximized", action="toggle"}))
hl.bind(SUPER .. "+C", hl.dsp.window.close())
hl.bind(SUPER_SHIFT .. "+C", hl.dsp.window.kill())
hl.bind(SUPER .. "+G", hl.dsp.group.toggle())
hl.bind(SUPER_ALT .. "+F", hl.dsp.window.float())
hl.bind(SUPER_CTRL .. "+R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(SUPER_ALT .. "+V", hl.dsp.layout("togglesplit"))
-- hl.bind(SUPER .. "+V", hl.dsp.exec_cmd(vars.CLIPBOARD))

-- Move focus (Arrow keys)
hl.bind(SUPER .. "+LEFT",  hl.dsp.focus({direction="l"}))
hl.bind(SUPER .. "+RIGHT", hl.dsp.focus({direction="r"}))
hl.bind(SUPER .. "+UP",    hl.dsp.focus({direction="u"}))
hl.bind(SUPER .. "+DOWN",  hl.dsp.focus({direction="d"}))

-- Move focus (Vim keys)
hl.bind(SUPER .. "+H", hl.dsp.focus({direction="l"}))
hl.bind(SUPER .. "+L", hl.dsp.focus({direction="r"}))
hl.bind(SUPER .. "+K", hl.dsp.focus({direction="u"}))
hl.bind(SUPER .. "+J", hl.dsp.focus({direction="d"}))

-- Resize (repeating)
hl.bind(SUPER_CTRL .. "+H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(SUPER_CTRL .. "+L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), { repeating = true })
hl.bind(SUPER_CTRL .. "+K", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(SUPER_CTRL .. "+J", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), { repeating = true })

-- Move windows
hl.bind(SUPER_SHIFT .. "+H", hl.dsp.window.move({ direction = "l" }))
hl.bind(SUPER_SHIFT .. "+L", hl.dsp.window.move({ direction = "r" }))
hl.bind(SUPER_SHIFT .. "+K", hl.dsp.window.move({ direction = "u" }))
hl.bind(SUPER_SHIFT .. "+J", hl.dsp.window.move({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
hl.bind(SUPER .. "+1", hl.dsp.focus({ workspace = "1" }))
hl.bind(SUPER .. "+2", hl.dsp.focus({ workspace = "2" }))
hl.bind(SUPER .. "+3", hl.dsp.focus({ workspace = "3" }))
hl.bind(SUPER .. "+4", hl.dsp.focus({ workspace = "4" }))
hl.bind(SUPER .. "+5", hl.dsp.focus({ workspace = "5" }))
hl.bind(SUPER .. "+6", hl.dsp.focus({ workspace = "6" }))
hl.bind(SUPER .. "+7", hl.dsp.focus({ workspace = "7" }))
hl.bind(SUPER .. "+8", hl.dsp.focus({ workspace = "8" }))
hl.bind(SUPER .. "+9", hl.dsp.focus({ workspace = "9" }))
hl.bind(SUPER .. "+0", hl.dsp.focus({ workspace = "10" }))

-- Move active window to a workspace and FOLLOW WORKSPACE
hl.bind(SUPER_SHIFT .. "+1", hl.dsp.window.move({ workspace = "1", follow = true }))
hl.bind(SUPER_SHIFT .. "+2", hl.dsp.window.move({ workspace = "2", follow = true }))
hl.bind(SUPER_SHIFT .. "+3", hl.dsp.window.move({ workspace = "3", follow = true }))
hl.bind(SUPER_SHIFT .. "+4", hl.dsp.window.move({ workspace = "4", follow = true }))
hl.bind(SUPER_SHIFT .. "+5", hl.dsp.window.move({ workspace = "5", follow = true }))
hl.bind(SUPER_SHIFT .. "+6", hl.dsp.window.move({ workspace = "6", follow = true }))
hl.bind(SUPER_SHIFT .. "+7", hl.dsp.window.move({ workspace = "7", follow = true }))
hl.bind(SUPER_SHIFT .. "+8", hl.dsp.window.move({ workspace = "8", follow = true }))
hl.bind(SUPER_SHIFT .. "+9", hl.dsp.window.move({ workspace = "9", follow = true }))
hl.bind(SUPER_SHIFT .. "+0", hl.dsp.window.move({ workspace = "10", follow = true }))
hl.bind(SUPER_SHIFT .. "+COMMA", hl.dsp.window.move({ workspace = "-1", follow = true }))
hl.bind(SUPER_SHIFT .. "+PERIOD", hl.dsp.window.move({ workspace = "+1", follow = true }))

-- Move active window to a workspace WITHOUT FOLLOWING
hl.bind(SUPER_CTRL .. "+1", hl.dsp.window.move({ workspace = "1", follow = false }))
hl.bind(SUPER_CTRL .. "+2", hl.dsp.window.move({ workspace = "2", follow = false }))
hl.bind(SUPER_CTRL .. "+3", hl.dsp.window.move({ workspace = "3", follow = false }))
hl.bind(SUPER_CTRL .. "+4", hl.dsp.window.move({ workspace = "4", follow = false }))
hl.bind(SUPER_CTRL .. "+5", hl.dsp.window.move({ workspace = "5", follow = false }))
hl.bind(SUPER_CTRL .. "+6", hl.dsp.window.move({ workspace = "6", follow = false }))
hl.bind(SUPER_CTRL .. "+7", hl.dsp.window.move({ workspace = "7", follow = false }))
hl.bind(SUPER_CTRL .. "+8", hl.dsp.window.move({ workspace = "8", follow = false }))
hl.bind(SUPER_CTRL .. "+9", hl.dsp.window.move({ workspace = "9", follow = false }))
hl.bind(SUPER_CTRL .. "+0", hl.dsp.window.move({ workspace = "10", follow = false }))
hl.bind(SUPER_CTRL .. "+COMMA", hl.dsp.window.move({ workspace = "-1", follow = false }))
hl.bind(SUPER_CTRL .. "+PERIOD", hl.dsp.window.move({ workspace = "+1", follow = false }))

-- Example special workspace (scratchpad)
hl.bind(SUPER .. "+S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(SUPER .. "+SHIFT+S", hl.dsp.window.move({ workspace = "special:magic", follow = true }))

-- Cursor zoom
hl.bind(SUPER .. "+mouse_down", function() utils.zoom(-0.1) end)
hl.bind(SUPER .. "+mouse_up", function() utils.zoom(0.1) end)

hl.bind(SUPER .. "+EQUAL", function() utils.zoom(0.1) end, {repeating=true})
hl.bind(SUPER .. "+MINUS", function() utils.zoom(-0.1) end, {repeating=true})
hl.bind(SUPER .. "+KP_ADD", function() utils.zoom(0.1) end, {repeating=true})
hl.bind(SUPER .. "+KP_SUBTRACT", function() utils.zoom(-0.1) end, {repeating=true})

-- WhatsApp / Spotify scratchpads
hl.bind(SUPER_ALT .. "+P", hl.dsp.exec_cmd(vars.WHATSAPP_SPECIAL))
hl.bind(SUPER_ALT .. "+SPACE", hl.dsp.exec_cmd(vars.SPOTIFY_SPECIAL))
hl.bind(SUPER .. "+V", hl.dsp.exec_cmd(vars.CLIPBOARD_SPECIAL))

hl.bind(SUPER .. "+PERIOD", hl.dsp.focus({workspace="e+1"}))
hl.bind(SUPER .. "+COMMA", hl.dsp.focus({workspace="e-1"}))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(SUPER .. "+mouse:272", hl.dsp.window.drag())
hl.bind(SUPER .. "+mouse:273", hl.dsp.window.resize())

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(vars.VOLUME .. " --inc"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(vars.VOLUME .. " --dec"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(vars.VOLUME .. " --toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(vars.VOLUME .. " --toggle-mic"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(vars.BRIGHTNESS .. " --inc"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(vars.BRIGHTNESS .. " --dec"), { locked = true, repeating = true })

hl.bind(SUPER_ALT .. "+PERIOD", hl.dsp.exec_cmd(vars.VOLUME .. " --inc"), { locked = true, repeating = true })
hl.bind(SUPER_ALT .. "+COMMA", hl.dsp.exec_cmd(vars.VOLUME .. " --dec"), { locked = true, repeating = true })
hl.bind(SUPER .. "+M", hl.dsp.exec_cmd(vars.VOLUME .. " --toggle"), { locked = true, repeating = true })
hl.bind(SUPER_ALT .. "+M", hl.dsp.exec_cmd(vars.VOLUME .. " --toggle-mic"), { locked = true, repeating = true })
hl.bind(SUPER .. "+X", hl.dsp.exec_cmd(vars.BRIGHTNESS .. " --inc"), { locked = true, repeating = true })
hl.bind(SUPER .. "+Z", hl.dsp.exec_cmd(vars.BRIGHTNESS .. " --dec"), { locked = true, repeating = true })

-- Media controls
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioStop", hl.dsp.exec_cmd("playerctl stop"))

hl.bind(SUPER_ALT .. "+RIGHT", hl.dsp.exec_cmd("playerctl next"))
hl.bind(SUPER_ALT .. "+LEFT", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(SUPER_ALT .. "+UP", hl.dsp.exec_cmd("playerctl stop"))
hl.bind(SUPER_ALT .. "+DOWN", hl.dsp.exec_cmd("playerctl play-pause"))

hl.bind(SUPER_ALT .. "+L", hl.dsp.exec_cmd("playerctl next"))
hl.bind(SUPER_ALT .. "+J", hl.dsp.exec_cmd("playerctl previous"))
hl.bind(SUPER_ALT .. "+K", hl.dsp.exec_cmd("playerctl play-pause"))

-- Plugins
-- hl.bind("SUPER+D", hl.dsp.hyprexpo_expo("toggle"))
