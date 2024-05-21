require 'lua/utils'

local wezterm = require 'wezterm'
local fonts = require 'lua/fonts'
local theme = require 'lua/themes/github_light'

wezterm.on('gui-startup', function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen() -- toggle_fullscreen or maximize
end)

local background = {
	window_background_opacity = 1,
	-- window_background_image = '/Users/ilyapu/Downloads/image (6).png',
	-- window_background_image_hsb = {
	--     brightness = 0.2,
	--     saturation = 0.9,
	-- },
}

local keys = {
	-- { key = 'C', mods = 'CTRL', action = wezterm.action.CopyTo 'Clipboard' },
	{ key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
	{ key = 'v', mods = 'SUPER', action = wezterm.action.PasteFrom 'Clipboard' },
	{ key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
	{ key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
	{ key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
	{ key = 'q', mods = 'CMD', action = wezterm.action.QuitApplication },
}

return merge( --
	fonts.input,
	background,
	theme,
	{
		window_padding = {
			left = 20,
			right = 20,
			top = 15,
			bottom = 1,
		},
		enable_tab_bar = false,
		enable_scroll_bar = false,
		scrollback_lines = 1000,
		cursor_blink_rate = 1400,
		max_fps = 240,
		animation_fps = 240,
		default_cursor_style = 'BlinkingBar',
		disable_default_key_bindings = true,
		warn_about_missing_glyphs = false,
		window_close_confirmation = 'NeverPrompt',
		keys = keys,
		mouse_bindings = {
			{
				event = { Up = { streak = 1, button = 'Left' } },
				mods = 'CTRL',
				action = wezterm.action.OpenLinkAtMouseCursor,
			},
		},
	}
)
