return {
	'norcalli/nvim-colorizer.lua',
	event = 'BufReadPre',
	config = function()
		local colorizer = require 'colorizer'

		colorizer.setup {
			'*',
			'!Lazy',
			'!Notify',
		}
	end,
}
