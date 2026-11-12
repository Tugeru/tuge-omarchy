-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })
-- Include Flatpak exports when the shell indexes installed desktop entries.
local data_home = os.getenv("XDG_DATA_HOME")
if not data_home or data_home == "" then
  data_home = (os.getenv("HOME") or "") .. "/.local/share"
end

local data_dirs = os.getenv("XDG_DATA_DIRS")
if not data_dirs or data_dirs == "" then
  data_dirs = "/usr/local/share:/usr/share"
end

for _, flatpak_dir in ipairs({
  data_home .. "/flatpak/exports/share",
  "/var/lib/flatpak/exports/share",
}) do
  if not data_dirs:find(flatpak_dir, 1, true) then
    data_dirs = flatpak_dir .. ":" .. data_dirs
  end
end
hl.env("XDG_DATA_DIRS", data_dirs)
pcall(require, "/home/tuge/.config/hypr/openwhispr-binds.lua")
