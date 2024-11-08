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
							return not fn.in_node {
								-- 'arrow_function',
								'binary_expression',
								'augmented_assignment_expression',
							}
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
			require('nvim-autopairs').setup {
				check_ts = true,
				fast_wrap = {
					map = '<M-e>',
					chars = { '{', '[', '(', '"', '\'' },
					pattern = [=[[%'%"%>%]%)%}%,]]=],
					end_key = '$',
					before_key = 'h',
					after_key = 'l',
					cursor_pos_before = true,
					keys = 'qwertyuiopzxcvbnmasdfghjkl',
					manual_position = true,
					highlight = 'Search',
					highlight_grey = 'Comment',
				},
			}
		end,
	},
}
