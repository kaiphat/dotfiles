local nvim_config_path = vim.fn.stdpath 'config'
local path_to_local_plugins = nvim_config_path .. '/lua/local_plugins/'

return {
	{
		dir = path_to_local_plugins .. 'marks',
		event = 'VeryLazy',
		name = 'marks',
		enabled = true,
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			require('local_plugins.marks').setup {
				save_position = false,
			}
		end,
	},

	{
		name = 'unit',
		dir = path_to_local_plugins .. 'unit',
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
		dir = path_to_local_plugins .. 'restore',
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
		dir = path_to_local_plugins .. 'statusline',
		-- event = 'VeryLazy',
		enabled = false,
		priority = 900,
		config = function()
			require('local_plugins.statusline').setup()
		end,
	},
}
