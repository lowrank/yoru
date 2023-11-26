local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local helpers = require("helpers")

local function autostart_apps()
	--- Compositor
	helpers.run.check_if_running("picom", nil, function()
		awful.spawn("picom --config " .. config_dir .. "configuration/picom.conf", false)
	end)
	-- helpers.run.check_if_running("picom", nil, function()
	-- 	awful.spawn("picom")
	-- end)
	--- Music Server
	helpers.run.run_once_pgrep("systemctl --user start pulseaudio  ")
	helpers.run.run_once_pgrep("mpd")
	helpers.run.run_once_pgrep("mpDris2")
	--- Polkit Agent
	helpers.run.run_once_ps(
		"polkit-gnome-authentication-agent-1",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
	)
	--- Other stuff
	helpers.run.run_once_grep("blueman-applet")
	helpers.run.run_once_grep("nm-applet")

	-- helpers.run.check_if_running("slack", nil, function()
	-- 	awful.spawn("slack")
	-- end)
	
	-- helpers.run.check_if_running("electron_outlook", nil, function()
	-- 	awful.spawn("electron-outlook")
	-- end)

	helpers.run.check_if_running("albert", nil, function()
		awful.spawn("albert")
	end)


end

autostart_apps()
