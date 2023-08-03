local theme_assets = require 'beautiful.theme_assets'
local xresources = require 'beautiful.xresources'
local rnotification = require 'ruled.notification'
local dpi = xresources.apply_dpi

local gfs = require 'gears.filesystem'

local theme = {}

theme.useless_gap = dpi(12)
theme.border_width = dpi(0)
theme.font = 'Mononoki Nerd Font 12'

rnotification.connect_signal('request::rules', function()
  rnotification.append_rule {
    rule = { urgency = 'critical' },
    properties = { bg = '#ff0000', fg = '#ffffff' },
  }
end)

return theme
