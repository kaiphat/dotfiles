return {
	'kdheepak/lazygit.nvim',
	keys = {
		{ '<leader>gl', ':LazyGit<cr>', silent = true },
		{ '<leader>gf', ':LazyGitFilterCurrentFile<cr>', silent = true },
	},
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
}
