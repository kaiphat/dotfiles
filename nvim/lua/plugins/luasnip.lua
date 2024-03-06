local rust = require 'snippets.rust'
local javascript = require 'snippets.javascript'

return {
	'L3MON4D3/LuaSnip',
	version = 'v2.*',
	keys = {
		{
			'<C-d>',
			function()
				if require('luasnip').jumpable(1) then
					require('luasnip').jump(1)
				end
			end,
			mode = { 'i', 's' },
		},
		{
			'<C-u>',
			function()
				if require('luasnip').jumpable(-1) then
					require('luasnip').jump(-1)
				end
			end,
			mode = { 'i', 's' },
		},
		{
			'<C-x>',
			function()
				require('luasnip').change_choice(1)
			end,
			mode = { 'i', 's' },
		},
	},
	event = { 'InsertEnter' },
	config = function()
		local ls = require 'luasnip'

		ls.setup {
			history = true,
			updateevents = 'TextChanged,TextChangedI',
			delete_check_events = 'TextChanged,InsertLeave',
		}

		rust.init()
		javascript.init()

		ls.filetype_extend('typescript', { 'javascript' })
		ls.filetype_extend('javascriptreact', { 'javascript' })
		ls.filetype_extend('typescriptreact', { 'javascript' })
	end,
}
