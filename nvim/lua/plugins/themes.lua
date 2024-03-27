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
    tokyonight = 'tokyonight',
    catppuccin_dark = 'catppuccin_dark',
    catppuccin_light = 'catppuccin_light'
}

return require('themes.' .. themes.catppuccin_dark)
