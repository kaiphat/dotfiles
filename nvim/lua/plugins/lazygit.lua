return {
	'kdheepak/lazygit.nvim',
	enabled = false,
	keys = {
		{ '<leader>lg', ':LazyGit<cr>', silent = true },
		{ '<leader>gf', ':LazyGitFilterCurrentFile<cr>', silent = true },
	},
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	config = function()
		vim.g.lazygit_use_neovim_remote = 1
	end,
}
