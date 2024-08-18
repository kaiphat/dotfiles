return {
	'fcancelinha/nordern.nvim',
	lazy = false,
	priority = 1000,
	config = function()
		require('nordern').setup {
			transparent = true,
			brighter_comments = false,
			italic_comments = true,
		}

		vim.cmd.colorscheme 'nordern'
	end,
}
