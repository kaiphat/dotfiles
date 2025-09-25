local nvim_config_path = vim.fn.stdpath 'config'
local function get_dir(name)
	return nvim_config_path .. '/lua/local_plugins/' .. name
end

return {
	{
		dir = get_dir 'anchor',
		event = 'VeryLazy',
		name = 'anchor',
		enabled = true,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'folke/snacks.nvim',
		},
		config = function()
			require('local_plugins.anchor').setup {}
		end,
	},

	{
		name = 'unit',
		dir = get_dir 'unit',
		keys = {
			{
				'u',
				function()
					require('local_plugins.unit').select(true)
				end,
				mode = { 'x', 'o' },
			},
		},
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			require('local_plugins.unit').setup()
		end,
	},

	{
		name = 'restore',
		dir = get_dir 'restore',
		enabled = true,
		keys = {
			{
				'<leader>ur',
				function()
					require('local_plugins.restore').restore()
				end,
			},
		},
		event = 'VeryLazy',
		config = function()
			require('local_plugins.restore').setup()
		end,
	},

	{
		name = 'statusline',
		dir = get_dir 'statusline',
		-- event = 'VeryLazy',
		enabled = false,
		priority = 900,
		config = function()
			require('local_plugins.statusline').setup()
		end,
	},

	{
		name = 'cursorword',
		dir = get_dir 'cursorword',
		event = 'VeryLazy',
		enabled = true,
		config = function()
			require('local_plugins.cursorword').setup()
		end,
	},
}
