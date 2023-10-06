local beautiful = require 'beautiful'
local theme_assets = require 'beautiful.theme_assets'
local xresources = require 'beautiful.xresources'
local rnotification = require 'ruled.notification'
local dpi = xresources.apply_dpi
local gears = require 'gears'
local gshape = require 'gears.shape'

local gfs = require 'gears.filesystem'
local client = client

local theme = {}

theme.useless_gap = dpi(11)
theme.border_width = 0
theme.oof_border_width = 0
theme.border_radius = 12

theme.font = 'Mononoki Nerd Font 12'

rnotification.connect_signal(
	'request::rules',
	function()
		rnotification.append_rule {
			rule = { urgency = 'critical' },
			properties = { bg = '#ff0000', fg = '#ffffff' },
		}
	end
)

local function rrect(radius)
	return function(cr, width, height) gshape.rounded_rect(cr, width, height, radius) end
end

if beautiful.border_radius and beautiful.border_radius > 0 then
	client.connect_signal('manage', function(c, startup)
		if not c.fullscreen and not c.maximized then c.shape = rrect(beautiful.border_radius) end
	end)

	--- Fullscreen and maximized clients should not have rounded corners
	local function no_round_corners(c)
		if c.fullscreen or c.maximized then
			c.shape = gears.shape.rectangle
		else
			c.shape = rrect(beautiful.border_radius)
		end
	end

	client.connect_signal('property::fullscreen', no_round_corners)
	client.connect_signal('property::maximized', no_round_corners)

	beautiful.snap_shape = rrect(beautiful.border_radius * 2)
else
	beautiful.snap_shape = gears.shape.rectangle
end

return theme
