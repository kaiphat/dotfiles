local M = {}

M.excluded_filetypes = {
	'help',
	'terminal',
	'dashboard',
	'packer',
	'lspinfo',
	'TelescopePrompt',
	'TelescopeResults',
	'norg',
	'md',
	'mason',
	'markdown',
	'lazy',
	'noice',
}

M.chars = {
	'▏',
	'│',
	'⏐',
	'┊',
	'¦',
}

M.get_char = function() return M.chars[1] end

return {
	'lukas-reineke/indent-blankline.nvim',
	enabled = true,
	main = 'ibl',
	config = function()
		local ibl = require 'ibl'

		ibl.setup {
			indent = {
				char = M.get_char(),
			},
			scope = {
				enabled = false,
			},
			exclude = {
				buftypes = {
					'terminal',
				},
				filetypes = M.excluded_filetypes,
			},
		}
	end,
}
