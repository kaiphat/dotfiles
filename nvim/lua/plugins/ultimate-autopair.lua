return {
	'altermo/ultimate-autopair.nvim',
	branch = 'v0.6',
	event = { 'InsertEnter' },
	config = function()
		local p = require 'ultimate-autopair'

		p.setup {
			close = {
				multi = true,
			},
			extensions = {
				suround = {
					p = 100,
				},
			},
			internal_pairs = {
				{ '[', ']', fly = true, dosuround = true, newline = true, space = true },
				{ '(', ')', fly = true, dosuround = true, newline = true, space = true },
				{ '{', '}', fly = true, dosuround = true, newline = true, space = true },
				{ '<', '>', fly = true, dosuround = true, newline = true, space = true },
				{ '"', '"', suround = true, multiline = false, alpha = { 'txt' } },
				{
					'\'',
					'\'',
					suround = true,
					cond = function(fn) return not fn.in_lisp() or fn.in_string() end,
					alpha = true,
					nft = { 'tex', 'latex' },
					multiline = false,
				},
				{ '`', '`', nft = { 'tex', 'latex' }, multiline = false },
				{ '``', '\'\'', ft = { 'tex', 'latex' } },
				{ '```', '```', newline = true, ft = { 'markdown' } },
				{ '<!--', '-->', ft = { 'markdown', 'html' } },
				{ '"""', '"""', newline = true, ft = { 'python' } },
				{ '\'\'\'', '\'\'\'', newline = true, ft = { 'python' } },
			},
		}
	end,
}
