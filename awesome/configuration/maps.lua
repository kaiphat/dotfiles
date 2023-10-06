require 'awful.hotkeys_popup.keys'

local awful = require 'awful'
local awesome = awesome
local client = client

local mod = 'Mod4'
local ctrl = 'Control'
local shift = 'Shift'

awful.keyboard.append_global_keybindings {
	awful.key({ mod, ctrl }, 'r', awesome.restart),

	awful.key({ mod }, 'Return', spawn 'alacritty'),
	awful.key({ mod }, 'd', spawn 'rofi -show drun'),
	awful.key({ mod, shift }, 'b', spawn 'brave'),
	awful.key({ mod, shift }, 'm', spawn 'telegram-desktop'),

	awful.key({ mod }, 'space', spawn_script '~/dotfiles/scripts/change_language.sh'),

	awful.key({ mod, shift, ctrl }, 'q', spawn 'poweroff'),
	awful.key({ mod, shift, ctrl }, 'r', spawn 'reboot'),
	awful.key({ mod, shift, ctrl }, 's', spawn 'systemctl suspend'),

	awful.key({ mod }, 's', function() awful.layout.set(awful.layout.suit.tile) end),
	awful.key({ mod }, 'f', awful.client.floating.toggle),
	awful.key({ mod }, '`', function()
		awful.client.focus.byidx(1)
		for _, c in ipairs(client.get()) do
			if not c.fullscreen then c.fullscreen = true end
		end
	end),
	awful.key({ mod }, 'z', function()
		local clients = client.get()
		for _, c in ipairs(clients) do
			c.fullscreen = not c.fullscreen
		end
	end),

	awful.key {
		modifiers = { mod },
		keygroup = 'numrow',
		group = 'tags',
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then tag:view_only() end
		end,
	},
	awful.key {
		modifiers = { mod, shift },
		keygroup = 'numrow',
		group = 'tags',
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then client.focus:move_to_tag(tag) end
			end
		end,
	},
}

client.connect_signal('request::default_keybindings', function()
	awful.keyboard.append_client_keybindings {
		awful.key({ mod, shift }, 'i', function(c) c:kill() end),
	}
end)

client.connect_signal('request::default_mousebindings', function()
	awful.mouse.append_client_mousebindings {
		awful.button({}, 1, function(c) c:activate { context = 'mouse_click' } end),
		awful.button({ mod }, 1, function(c) c:activate { context = 'mouse_click', action = 'mouse_move' } end),
		awful.button({ mod }, 3, awful.mouse.client.resize),
	}
end)

client.connect_signal('mouse::enter', function(c) c:activate { context = 'mouse_enter', raise = false } end)
