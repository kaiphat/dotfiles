local palette = {
	base = '#232136',
	overlay = '#393552',
	muted = '#6e6a86',
	text = '#787C99',
	love = '#eb6f92',
	gold = '#f6c177',
	-- rose = '#ea9a97',
	pine = '#3e8fb0',
	foam = '#9ccfd8',
	iris = '#c4a7e7',
	-- highlight_high = '#56526e',
}

local colors = {
	foreground = palette.text,
	-- background = '#191934',
	-- background = '#1b172e',
	background = '#202a44',
	cursor_bg = '#baaaff',
	cursor_border = '#baaaff',
	cursor_fg = palette.text,
	selection_bg = palette.overlay,
	selection_fg = palette.text,

	ansi = {
		palette.overlay,
		palette.love,
		palette.pine,
		palette.gold,
		palette.foam,
		palette.iris,
		'#ebbcba', -- replacement for palette.rose,
		palette.text,
	},

	brights = {
		'#817c9c', -- replacement for palette.muted,
		palette.love,
		palette.pine,
		palette.gold,
		palette.foam,
		palette.iris,
		'#ebbcba', -- replacement for palette.rose,
		palette.text,
	},
}

return {
	colors = {
		cursor_bg = '#d6e9ff',
		cursor_border = '#d6e9ff',
		cursor_fg = '#232136',
	},
	color_scheme = 'rose-pine-moon',
}
