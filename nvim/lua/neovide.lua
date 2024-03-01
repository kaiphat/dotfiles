if vim.g.neovide then
    vim.o.guifont = 'Mononoki:h13'
	vim.opt.linespace = 0
	-- vim.g.neovide_background_color = '#292640'
	vim.g.neovide_transparency = 1
	vim.g.neovide_fullscreen = true

    vim.api.nvim_set_hl(0, 'Normal', { bg = '#191934', fg = '#5DE4C7'})
end
