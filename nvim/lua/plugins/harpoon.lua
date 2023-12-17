local base_keys = '<leader>h'

return {
	'ThePrimeagen/harpoon',
	branch = 'harpoon2',
	requires = { 'nvim-lua/plenary.nvim' },
	keys = {

		{
			base_keys .. 'a',
			function()
				local h = require 'harpoon'
				h:list():append()
				print 'added'
			end,
		},
		{
			base_keys .. 'r',
			function()
				local h = require 'harpoon'
				h:list():remove()
				print 'removed'
			end,
		},
		{
			base_keys .. 'm',
			function()
				local h = require 'harpoon'
				h.ui:toggle_quick_menu(h:list())
			end,
		},
		{
			base_keys .. 'n',
			function()
				local h = require 'harpoon'
				h:list():next()
			end,
		},
		{
			base_keys .. 'p',
			function()
				local h = require 'harpoon'
				h:list():prev()
			end,
		},
		{
			base_keys .. 'c',
			function()
				local h = require 'harpoon'
				h:list():clear()
				print('clear')
			end,
		},
	},
	config = function() require('harpoon'):setup {} end,
}
