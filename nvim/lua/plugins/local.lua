local nvim_config_path = vim.fn.stdpath 'config'
local path_to_local_plugins = nvim_config_path .. '/lua/local_plugins/'

return {
	{
		dir = path_to_local_plugins .. 'marks',
		event = 'VeryLazy',
		name = 'marks',
		enabled = true,
		config = function()
			require('local_plugins.marks').setup {
				save_position = true,
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
		name = 'stages',
		dir = path_to_local_plugins .. 'stages',
		lazy = false,
		enabled = false,
		keys = {
			{
				'[p',
				function()
					require('local_plugins.stages'):jump_to_parent()
				end,
			},
			{
				'[[',
				function()
					require('local_plugins.stages'):jump_up()
				end,
				ft = '*',
			},
			{
				']]',
				function()
					require('local_plugins.stages'):jump_down()
				end,
				ft = '*',
			},
		},
		config = function()
			require('local_plugins.stages'):setup()
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
}
