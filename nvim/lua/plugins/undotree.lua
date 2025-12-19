return {

	{
		'mbbill/undotree',
		enabled = false,
		cmd = 'UndotreeToggle',
	},

	{
		'XXiaoA/atone.nvim',
		cmd = 'Atone',
		opts = {},
		init = function()
			vim.api.nvim_create_user_command('Undo', function()
				vim.cmd 'Atone'
			end, {})
		end,
	},
}
