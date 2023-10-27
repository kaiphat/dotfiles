local M = {}

M.char_highlight_group = 'CHAR'
M.context_char_highlight_group = 'CONTEXT_CHAR'
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

M.nodes = {
	'argument_list',
	'arguments',
	'assignment_statement',
	'Block',
	-- 'chunk',
	'class',
	'ContainerDecl',
	'dictionary',
	'do_block',
	'do_statement',
	'element',
	'except',
	'FnCallArguments',
	'for',
	'for_statement',
	'function',
	'function_declaration',
	'function_definition',
	'if_statement',
	'IfExpr',
	'IfStatement',
	'import',
	'InitList',
	'list_literal',
	'method',
	'object',
	'ParamDeclList',
	'repeat_statement',
	'selector',
	'SwitchExpr',
	'table',
	'table_constructor',
	'try',
	'tuple',
	'type',
	'var',
	'while',
	'while_statement',
	'with',
}

M.chars = {
	'▏',
	'│',
	'⏐',
	'┊',
	'¦',
}

return {
	'lukas-reineke/indent-blankline.nvim',
	enabled = false,
	main = 'ibl',
	config = function()
		local ibl = require 'ibl'
		local hooks = require 'ibl.hooks'

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, M.char_highlight_group, { fg = DARK_THEME_COLORS.blue_darkest })
			vim.api.nvim_set_hl(0, M.context_char_highlight_group, { fg = DARK_THEME_COLORS.one_bg3 })
		end)

		ibl.setup {
			indent = {
				char = M.chars[1],
				highlight = M.char_highlight_group,
			},
			scope = {
				enabled = true,
				show_start = false,
				show_end = false,
				include = {
					node_type = { ['*'] = M.nodes },
				},
				highlight = M.context_char_highlight_group,
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
