if vim.g.neovide then
	vim.o.guifont = 'Hermit:h12'
	vim.o.linespace = 0

	vim.g.neovide_transparency = 1
	vim.g.neovide_fullscreen = true
	vim.g.neovide_remember_window_size = true
	vim.g.neovide_input_macos_option_key_is_meta = 'only_left'

	vim.o.background = 'light'
	-- vim.api.nvim_set_hl(0, 'Normal', { bg = '#191934', fg = '#5DE4C7' })
	vim.api.nvim_set_hl(0, 'Normal', { bg = '#eeeeee', fg = '#5DE4C7' })
end
