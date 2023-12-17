return {
	'norcalli/nvim-colorizer.lua',
	-- cmd = { 'ColorizerAttachToBuffer' },
	lazy = false,
	config = function()
		require('colorizer').setup {
			'*',
			'!Lazy',
			'!Notify',
		}
	end,
}
