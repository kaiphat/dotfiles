local awful = require 'awful'
local screen = screen

screen.connect_signal(
	'request::desktop_decoration',
	function(s) awful.tag({ '1', '2', '3', '4', '5', '6' }, s, awful.layout.layouts[1]) end
)
