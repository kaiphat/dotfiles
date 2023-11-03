local base_keys = '<leader>h'

return {
	'ThePrimeagen/harpoon',
	keys = {
		{ base_keys .. 'a', function() require('harpoon.mark').add_file() end },
		{ base_keys .. 'r', function() require('harpoon.mark').rm_file() end },
		{ base_keys .. 'm', function() require('harpoon.ui').toggle_quick_menu() end },
		{ base_keys .. 'n', function() require('harpoon.ui').nav_next() end },
		{ base_keys .. 'p', function() require('harpoon.ui').nav_prev() end },
	},
	config = function()
		require('harpoon').setup {
			menu = {
				width = 100,
			},

			global_settings = {
				mark_branch = true,
			},
		}
	end,
}
