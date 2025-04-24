local wezterm = require 'wezterm'
local font_config = require 'wezterm.fonts'
local theme = require 'wezterm.themes.rose_pine_dark'
local config = require 'wezterm.config'

config.set(font_config.build_font(font_config.fonts.jet_brains))
config.set(theme)
config.set {
	automatically_reload_config = true,
	enable_tab_bar = false,
	enable_scroll_bar = false,
	scrollback_lines = 1000,
	max_fps = 240,
	animation_fps = 240,
	cursor_blink_rate = 0,
	default_cursor_style = 'SteadyBlock',
	freetype_load_target = 'Light',
	freetype_render_target = 'HorizontalLcd',
	freetype_load_flags = 'NO_HINTING',
	disable_default_key_bindings = true,
	warn_about_missing_glyphs = false,
	window_close_confirmation = 'NeverPrompt',
	window_padding = {
		left = '2cell',
		right = '2cell',
		top = '0.5cell',
		bottom = '0cell',
	},
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = 'Left' } },
			mods = 'CTRL',
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
	keys = {
		{ key = 'V', mods = 'CTRL', action = wezterm.action.PasteFrom 'Clipboard' },
		{ key = 'v', mods = 'SUPER', action = wezterm.action.PasteFrom 'Clipboard' },
		{ key = '=', mods = 'CTRL', action = wezterm.action.IncreaseFontSize },
		{ key = '0', mods = 'CTRL', action = wezterm.action.ResetFontSize },
		{ key = '-', mods = 'CTRL', action = wezterm.action.DecreaseFontSize },
		{ key = 'q', mods = 'CMD', action = wezterm.action.QuitApplication },
	},
}

wezterm.on('gui-startup', function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen() -- toggle_fullscreen or maximize
end)

return config.get()
