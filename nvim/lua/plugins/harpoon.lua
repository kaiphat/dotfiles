return {
	'ThePrimeagen/harpoon',
	keys = {
		{ 'mm', function() require('harpoon.mark').toggle_file() end },
		{ '\'m', function() require('harpoon.ui').toggle_quick_menu() end },
		{ 'mn', function() require('harpoon.ui').nav_next() end },
		{ 'mp', function() require('harpoon.ui').nav_prev() end },
	},
	config = function()
		local harpoon = require 'harpoon'

		harpoon.setup {
			menu = {
				width = 100,
			},

			global_settings = {
				mark_branch = true,
			},
		}
	end,
}
