require 'awful.autofocus'

local awful = require 'awful'
local beautiful = require 'beautiful'
local gears = require 'gears'

awful.screen.connect_for_each_screen(function(s)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper

		if type(wallpaper) == 'function' then wallpaper = wallpaper(s) end

		gears.wallpaper.maximized(wallpaper, s, false, nil)
	end
end)

client.connect_signal(
	'mouse::enter',
	function(c) c:emit_signal('request::activate', 'mouse_enter', { raise = false }) end
)
