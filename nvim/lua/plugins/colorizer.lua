return {
	'norcalli/nvim-colorizer.lua',
	cmd = { 'ColorizerAttachToBuffer' },
	config = function()
		require('colorizer').setup {
			'*',
			'!Lazy',
			'!Notify',
		}
	end,
}
