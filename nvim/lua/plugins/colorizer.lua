return {
	'norcalli/nvim-colorizer.lua',
	cmd = { 'ColorizerToggle' },
	config = function()
		require('colorizer').setup {
			'*',
			'!Lazy',
			'!Notify',
		}
	end,
}
