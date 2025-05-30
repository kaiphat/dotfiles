local palette = {
	base = '#faf4ed',
	overlay = '#f2e9e1',
	muted = '#9893a5',
	text = '#575279',
	love = '#b4637a',
	gold = '#ea9d34',
	rose = '#d7827e',
	pine = '#286983',
	foam = '#56949f',
	iris = '#907aa9',
	-- highlight_high = '#cecacd',
}

local active_tab = {
	bg_color = palette.overlay,
	fg_color = palette.text,
}

local inactive_tab = {
	bg_color = palette.base,
	fg_color = palette.muted,
}

local colors = {
	foreground = palette.text,
	background = '#e3e3e3',
	background = '#f1f0ff',
	cursor_bg = palette.muted,
	cursor_border = palette.muted,
	cursor_fg = palette.text,
	selection_bg = palette.overlay,
	selection_fg = palette.text,

	ansi = {
		'#f2e9de',
		palette.love,
		palette.pine,
		palette.gold,
		palette.foam,
		palette.iris,
		palette.rose,
		palette.text,
	},

	brights = {
		'#6e6a86', -- muted from rose-pine palette
		palette.love,
		palette.pine,
		palette.gold,
		palette.foam,
		palette.iris,
		palette.rose,
		palette.text,
	},

	tab_bar = {
		background = palette.base,
		active_tab = active_tab,
		inactive_tab = inactive_tab,
		inactive_tab_hover = active_tab,
		new_tab = inactive_tab,
		new_tab_hover = active_tab,
		inactive_tab_edge = palette.muted, -- (Fancy tab bar only)
	},
}

return {
	colors = {
		background = '#f0ecf3',
	},
	color_scheme = 'rose-pine-dawn',
}
