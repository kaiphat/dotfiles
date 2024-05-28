local themes = {
	dark = 'dark',
	new_dark = 'new_dark',
	github_light = 'github_light',
	github_dark = 'github_dark',
	rose_pine_dark = 'rose_pine_dark',
	rose_pine_light = 'rose_pine_light',
	gruvbox_light = 'gruvbox_light',
	kanagawa_dark = 'kanagawa_dark',
	everforest = 'everforest',
	poimandres = 'poimandres',
	catppuccin_dark = 'catppuccin_dark',
	catppuccin_light = 'catppuccin_light',
	tokyo_dark = 'tokyo_dark',
	ayu_dark = 'ayu_dark',
	ayu_light = 'ayu_light',
	zenbones_dark = 'zenbones_dark',
	neomodern_dark = 'neomodern_dark',
}

return require('themes.' .. themes.rose_pine_light)
