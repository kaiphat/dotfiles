return {
	'danfry1/lume',
	lazy = false,
	priority = 1000,
	config = function()
		require('lume').setup {
			transparent = true,
			italics = true,
		}

		vim.cmd 'colorscheme lume'
	end,
}
