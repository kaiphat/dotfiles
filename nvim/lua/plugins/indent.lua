local char_highlight_group = '@IndentBlanklineChar'
local context_char_highlight_group = '@IndentBlanklineContextChar'

local excluded_filetypes = {
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

local nodes = {
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

return {
	'lukas-reineke/indent-blankline.nvim',
	enabled = true,
	main = 'ibl',
	event = 'BufReadPre',
	config = function()
		local ibl = require 'ibl'
		local hooks = require 'ibl.hooks'

		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, char_highlight_group, { link = 'IndentBlanklineChar' })
			vim.api.nvim_set_hl(0, context_char_highlight_group, { link = 'IndentBlanklineContextChar' })
		end)

		ibl.setup {
			indent = {
				char = ICONS.VERTICAL_LINE_1,
				highlight = char_highlight_group,
			},
			scope = {
				enabled = false,
				show_start = false,
				show_end = false,
				include = {
					node_type = { ['*'] = nodes },
				},
				highlight = context_char_highlight_group,
			},
			exclude = {
				buftypes = {
					'terminal',
				},
				filetypes = excluded_filetypes,
			},
		}
	end,
}
