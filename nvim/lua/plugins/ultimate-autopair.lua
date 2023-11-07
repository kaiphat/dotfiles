return {
	'altermo/ultimate-autopair.nvim',
	branch = 'v0.6',
	event = { 'InsertEnter' },
	config = function()
		local p = require 'ultimate-autopair'

		p.setup {
			close = {
				multi = false,
			},
			extensions = {
			    suround = {
			        p = 100
			    }
			}
		}
	end,
}
