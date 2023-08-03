pcall(require, 'luarocks.loader')

require 'awful.autofocus'
require 'awful.hotkeys_popup.keys'

local gears = require 'gears'
local awful = require 'awful'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local naughty = require 'naughty'
local ruled = require 'ruled'
local menubar = require 'menubar'
local hotkeys_popup = require 'awful.hotkeys_popup'
local gfs = require 'gears.filesystem'

local awesome = awesome
local client = client
local screen = screen
local tag = tag
local mod = 'Mod4'
local ctrl = 'Control'
local shift = 'Shift'

beautiful.init(gfs.get_configuration_dir() .. 'theme/theme.lua')

naughty.connect_signal('request::display_error', function(message, startup)
  naughty.notification {
    urgency = 'critical',
    title = 'Oops, an error happened' .. (startup and ' during startup!' or '!'),
    message = message,
  }
end)

tag.connect_signal('request::default_layouts', function()
  awful.layout.append_default_layouts {
    awful.layout.suit.tile,
    awful.layout.suit.spiral,
    awful.layout.suit.floating,
    awful.layout.suit.max,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
  }
end)

awesome.connect_signal('startup', function()
  awful.util.spawn 'bash -c "~/dotfiles/scripts/autostart.sh"'
end)

awful.keyboard.append_global_keybindings {
  awful.key({ mod, ctrl }, 'r', awesome.restart),
  awful.key({ mod }, 'Return', function()
    awful.spawn 'wezterm'
  end),
  awful.key({ mod, shift }, 'b', function()
    awful.spawn 'brave'
  end),
  awful.key({ mod, shift }, 'm', function()
    awful.spawn 'telegram-desktop'
  end),
}

client.connect_signal('request::default_keybindings', function()
  awful.keyboard.append_client_keybindings {
    awful.key({ mod, shift }, 'i', function(c)
      c:kill()
    end),
  }
end)

ruled.notification.connect_signal('request::rules', function()
  -- All notifications will match this rule.
  ruled.notification.append_rule {
    rule = {},
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
    },
  }
end)

screen.connect_signal('request::desktop_decoration', function(s)
  awful.tag({ '1', '2', '3' }, s, awful.layout.layouts[1])
end)

client.connect_signal('request::default_mousebindings', function()
  awful.mouse.append_client_mousebindings {
    awful.button({}, 1, function(c)
      c:activate { context = 'mouse_click' }
    end),
    awful.button({ mod }, 1, function(c)
      c:activate { context = 'mouse_click', action = 'mouse_move' }
    end),
    awful.button({ mod }, 3, function(c)
      c:activate { context = 'mouse_click', action = 'mouse_resize' }
    end),
  }
end)

ruled.client.connect_signal('request::rules', function()
  ruled.client.append_rule {
    id = 'global',
    rule = {},
    properties = {
      focus = awful.client.focus.filter,
      raise = true,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    },
  }
end)

naughty.connect_signal('request::display', function(n)
  naughty.layout.box { notification = n }
end)

client.connect_signal('mouse::enter', function(c)
  c:activate { context = 'mouse_enter', raise = false }
end)
