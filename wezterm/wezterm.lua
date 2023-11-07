require 'lua/helpers'
local wezterm = require 'wezterm'
local fonts = require 'lua/fonts'
local DARK_ROSE_PINE = require 'lua/themes/dark_rose_pine'
local DARK = require 'lua/themes/dark'
local LIGHT = require 'lua/themes/light'

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   FONTS   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

wezterm.on('gui-startup', function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	-- window:gui_window():maximize()
	window:gui_window():toggle_fullscreen()
end)

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   BACKGROUND   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local background = {
	window_background_opacity = 1,
    window_background_image = '/Users/ilyapu/Downloads/cristina-gottardi-CSpjU6hYo_0-unsplash.jpg',
    window_background_image_hsb = {
        brightness = 0.03,
        saturation = 1.0,
    },
}

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   THEME   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local THEMES = {
	DARK = DARK,
	LIGHT = LIGHT,
	DARK_ROSE_PINE = DARK_ROSE_PINE,
}

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈   RESULT   ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

local config = {
	front_end = 'WebGpu',
	colors = THEMES.DARK_ROSE_PINE,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	enable_tab_bar = false,
	enable_scroll_bar = false,
	scrollback_lines = 10000,
	cursor_blink_rate = 1000,
	max_fps = 100,
	animation_fps = 100,
	default_cursor_style = 'BlinkingBlock',
	warn_about_missing_glyphs = false,
	use_cap_height_to_scale_fallback_fonts = true,
	disable_default_key_bindings = true,
	adjust_window_size_when_changing_font_size = false,

	keys = {
		{
			key = 'C',
			mods = 'CTRL',
			action = wezterm.action.CopyTo 'Clipboard',
		},
		{
			key = 'V',
			mods = 'CTRL',
			action = wezterm.action.PasteFrom 'Clipboard',
		},
		{
			key = '=',
			mods = 'CTRL',
			action = wezterm.action.IncreaseFontSize,
		},
		{
			key = '-',
			mods = 'CTRL',
			action = wezterm.action.DecreaseFontSize,
		},
	},
}

return merge(config, fonts.agave_code, background)