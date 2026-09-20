-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Swap the default fullscreen actions.
hl.unbind("SUPER + F")
hl.unbind("SUPER + ALT + F")
o.bind("SUPER + F", "Full width", hl.dsp.window.fullscreen({ mode = "maximized" }))
o.bind("SUPER + ALT + F", "Full screen", hl.dsp.window.fullscreen({ mode = "fullscreen" }))

-- Move the terminal, Omarchy menu, and floating/tiling bindings.
hl.unbind("SUPER + T")
hl.unbind("SUPER + RETURN")
hl.unbind("SUPER + SPACE")
hl.unbind("SUPER + W")
o.bind("SUPER + T", "Terminal", { omarchy = "terminal" })
o.bind("SUPER + RETURN", "Omarchy menu", "omarchy-menu toggle")
o.bind("SUPER + W", "Toggle window floating/tiling", hl.dsp.window.float({ action = "toggle" }))

-- Move close-window from the old SUPER + W binding to SUPER + Q.
hl.unbind("SUPER + Q")
o.bind("SUPER + Q", "Close window", hl.dsp.window.close())

-- Move horizontal focus from arrow keys to SUPER + A/D.
hl.unbind("SUPER + LEFT")
hl.unbind("SUPER + RIGHT")
hl.unbind("SUPER + A")
hl.unbind("SUPER + D")
o.bind("SUPER + A", "Focus on left window", hl.dsp.layout("focus l"))
o.bind("SUPER + D", "Focus on right window", hl.dsp.layout("focus r"))
