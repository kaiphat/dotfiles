require 'lua/helpers'
local wezterm = require 'wezterm'
local fonts = require 'lua/fonts'

wezterm.on('gui-startup', function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	-- window:gui_window():maximize()
	window:gui_window():toggle_fullscreen()
end)

local background = {
	window_background_opacity = 1,
	-- window_background_image = '/Users/ilyapu/Downloads/jan-ciganek-RRyrWaLoAbY-unsplash.jpg',
	-- window_background_image_hsb = {
	--     brightness = 0.02,
	--     saturation = 1.0,
	-- },
}

local keys = {
	{ key = 'C', mods = 'CTRL', action = wezterm.action.CopyTo 'Clipboard' },
	{ key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
	{ key = 'v', mods = 'SUPER', action = wezterm.action.PasteFrom 'Clipboard' },
	{ key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
	{ key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
	{ key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
	{ key = 'q', mods = 'CMD', action = wezterm.action.QuitApplication },
}

local config = {
	front_end = 'WebGpu',
	window_padding = {
		left = 20,
		right = 20,
		top = 20,
		bottom = 6,
	},
	enable_tab_bar = false,
	enable_scroll_bar = false,
	scrollback_lines = 1000,
	cursor_blink_rate = 1000,
	max_fps = 240,
	animation_fps = 240,
	colors = require 'lua/themes/dark_rose_pine',
    default_cursor_style = 'BlinkingBar',
	disable_default_key_bindings = true,
	warn_about_missing_glyphs = false,
	use_cap_height_to_scale_fallback_fonts = false,
	adjust_window_size_when_changing_font_size = false,
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

return merge(config, fonts.hermit, background)
