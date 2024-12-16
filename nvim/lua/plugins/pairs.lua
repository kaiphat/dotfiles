return {
	{
		'altermo/ultimate-autopair.nvim',
		branch = 'v0.6',
		event = { 'InsertEnter' },
		enabled = true,
		config = function()
			require('ultimate-autopair.utils').maxlines = math.huge

			require('ultimate-autopair').setup {
				close = {
					multi = true,
				},
				fastwarp = {
					enable = true,
					enable_normal = true,
					enable_reverse = true,
					--{(|)} > fastwarp > {(}|)
					hopout = true,
					map = '<A-e>', --string or table
					rmap = '<A-E>', --string or table
					cmap = '<A-e>', --string or table
					rcmap = '<A-E>', --string or table
					multiline = true,
					nocursormove = true,
					do_nothing_if_fail = true,
					no_filter_nodes = { 'string', 'raw_string', 'string_literals', 'character_literal' },
					faster = false,
					conf = {},
					multi = false,
				},
				extensions = {},
				internal_pairs = {
					{
						'<',
						'>',
						fly = true,
						dosuround = true,
						newline = true,
						space = true,
						cond = function(fn)
							return true
							-- return not fn.in_node {
							-- 	-- 'arrow_function',
							-- 	'binary_expression',
							-- 	'augmented_assignment_expression',
							-- }
						end,
					},
					{
						'[',
						']',
						fly = true,
						dosuround = true,
						newline = true,
						space = true,
					},
					{
						'(',
						')',
						fly = true,
						dosuround = true,
						newline = true,
						space = true,
					},
					{
						'{',
						'}',
						fly = true,
						dosuround = true,
						newline = true,
						space = true,
					},
					{
						'<',
						'>',
						fly = true,
						dosuround = true,
						newline = true,
						space = true,
					},

					{
						'"',
						'"',
						fly = true,
						suround = true,
						multiline = false,
						alpha = { 'txt' },
					},
					{
						'\'',
						'\'',
						suround = true,
						fly = true,
						cond = function(fn)
							return not fn.in_lisp() or fn.in_string()
						end,
						alpha = true,
						nft = { 'tex', 'latex' },
						multiline = false,
					},
					{ '`', '`', nft = { 'tex', 'latex' }, multiline = true },
					{ '``', '\'\'', ft = { 'tex', 'latex' } },
					{ '```', '```', newline = true, ft = { 'markdown' } },
					{ '<!--', '-->', ft = { 'markdown', 'html' } },
					{ '"""', '"""', newline = true, ft = { 'python' } },
					{ '\'\'\'', '\'\'\'', newline = true, ft = { 'python' } },
				},
				config_internal_pairs = {},
			}
		end,
	},

	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		enabled = false,
		config = function()
			local pairs = require 'nvim-autopairs'
			local Rule = require 'nvim-autopairs.rule'
			local cond = require 'nvim-autopairs.conds'

			pairs.setup {
				disable_in_macro = false,
				enable_check_bracket_line = false,
				check_ts = true,
				fast_wrap = {
					map = '<M-e>',
					chars = { '{', '[', '(', '"', '\'', '`' },
					-- pattern = [=[[%'%"%>%]%)%}%,]]=],
					-- end_key = '$',
					-- before_key = 'h',
					-- after_key = 'l',
					-- cursor_pos_before = true,
					-- keys = 'qwertyuiopzxcvbnmasdfghjkl',
					-- manual_position = true,
					-- highlight = 'Search',
					-- highlight_grey = 'Comment',
				},
			}

			pairs.add_rules {
				Rule('<', '>', {
					-- if you use nvim-ts-autotag, you may want to exclude these filetypes from this rule
					-- so that it doesn't conflict with nvim-ts-autotag
					'-html',
					'-javascriptreact',
					'-typescriptreact',
				}):with_pair(
					-- regex will make it so that it will auto-pair on
					-- `a<` but not `a <`
					-- The `:?:?` part makes it also
					-- work on Rust generics like `some_func::<T>()`
					cond.before_regex('%a+:?:?$', 3)
				):with_move(function(opts)
					return opts.char == '>'
				end),
			}

			pairs.get_rule('{'):replace_map_cr(function()
				local res = '<c-g>u<CR><CMD>normal! ====<CR><up><end><CR>'
				local line = vim.fn.winline()
				local height = vim.api.nvim_win_get_height(0)
				-- Check if current line is within [1/3, 2/3] of the screen height.
				-- If not, center the current line.
				if line < height / 3 or height * 2 / 3 < line then
					-- Here, 'x' is a placeholder to make sure the indentation doesn't break.
					res = res .. 'x<ESC>zzs'
				end
				return res
			end)
		end,
	},
}
