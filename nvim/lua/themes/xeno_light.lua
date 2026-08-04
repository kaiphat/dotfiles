-- local function theme(xeno)
-- 	xeno.color('aurora', '#3ddc97')
-- 	xeno.color('teal', '#2ec4b6')
-- 	xeno.color('cyan', '#4fd9e8')
-- 	xeno.color('ice', '#8ecae6')
-- 	xeno.color('frost', '#a8e6cf')
-- 	xeno.color('violet', '#abcfe4')
-- 	xeno.color('indigo', '#7c93ee')
-- 	xeno.color('glow_pink', '#e39fc2')
--
-- 	xeno.theme('polarized', {
-- 		background = '#0a141c',
-- 		accent = '#3ddc97',
-- 		foreground = '#c9dde2',
-- 		properties = {
-- 			contrast = 0.10,
-- 			chroma = 0.05,
-- 			lightness = -0.05,
-- 			variation = 0.10,
-- 		},
--
-- 		highlights = {
-- 			editor = {
-- 				CursorLineNr = { fg = '@frost.100', bold = true },
-- 				MatchParen = { fg = '@frost.100', bold = true },
-- 				Visual = { bg = xeno.opaque('@aurora.500', 0.18) },
-- 				CursorLine = { bg = xeno.opaque('@teal.600', 0.06) },
-- 				Search = { bg = xeno.opaque('@cyan.400', 0.25), fg = '@foreground.50' },
-- 				IncSearch = { bg = xeno.opaque('@frost.300', 0.35), fg = '@background.950' },
-- 			},
--
-- 			syntax = {
-- 				Comment = { fg = '@foreground.400', italic = true },
-- 				Keyword = { fg = '@violet.300' },
-- 				Conditional = { fg = '@violet.100' },
-- 				Function = { fg = '@teal.300' },
-- 				Type = { fg = '@cyan.200' },
-- 				String = { fg = '@aurora.100' },
-- 				Number = { fg = '@frost.100' },
-- 				Boolean = { fg = '@frost.100' },
-- 				Variable = { fg = '@foreground.300' },
-- 				Property = { fg = '@ice.300' },
-- 				Operator = { fg = '@cyan.300' },
-- 				Punctuation = { fg = '@foreground.400' },
--
-- 				['@keyword'] = { link = 'Keyword' },
-- 				['@keyword.return'] = { link = 'Keyword' },
-- 				['@keyword.function'] = { link = 'Conditional' },
-- 				['@keyword.conditional'] = { link = 'Conditional' },
-- 				['@keyword.repeat'] = { link = 'Conditional' },
-- 				['@keyword.operator'] = { fg = '@cyan.300' },
-- 				['@keyword.import'] = { fg = '@teal.400' },
--
-- 				['@function'] = { link = 'Function' },
-- 				['@function.builtin'] = { fg = '@cyan.100' },
--
-- 				['@type'] = { link = 'Type' },
--
-- 				['@string'] = { link = 'String' },
-- 				['@string.escape'] = { fg = '@ice.100' },
--
-- 				['@number'] = { link = 'Number' },
-- 				['@boolean'] = { link = 'Boolean' },
--
-- 				['@constant'] = { fg = '@frost.200' },
-- 				['@constant.builtin'] = { fg = '@glow_pink.100', bold = true },
--
-- 				['@variable'] = { link = 'Variable' },
-- 				['@variable.builtin'] = { fg = '@indigo.200' },
--
-- 				['@property'] = { link = 'Property' },
--
-- 				['@constructor'] = { fg = '@foreground.400' },
--
-- 				['@operator'] = { link = 'Operator' },
-- 				['@punctuation'] = { link = 'Punctuation' },
-- 				['@punctuation.bracket'] = { link = 'Punctuation' },
-- 				['@punctuation.delimiter'] = { link = 'Punctuation' },
--
-- 				['@lsp.type.variable'] = { link = '@variable' },
-- 				['@lsp.type.property'] = { link = '@property' },
-- 				['@lsp.type.function'] = { link = '@function' },
-- 				['@lsp.type.type'] = { link = '@type' },
-- 				['@lsp.type.keyword'] = { link = '@keyword' },
-- 				['@lsp.mod.declaration'] = { clear = true },
-- 				['@lsp.typemod.property.declaration'] = { link = '@property' },
-- 			},
-- 		},
-- 	})
-- end
--
__.add_plugin {
	'kyzabuilds/xeno.nvim',
	name = 'xeno',
	is_instant = true,
	load = function(xeno)
		xeno.setup {
			background = nil,

			properties = {
				contrast = 0.3, -- Contrast adjustment (-1.0 to 1.0)
				variation = 0.0, -- Hue variation (-1.0 to 1.0)
				chroma = 0.0, -- Saturation adjustment (-1.0 to 1.0)
				lightness = 0.0, -- Lightness adjustment (-1.0 to 1.0)
			},

			highlights = {
				editor = {},
			},

			-- accent = '#8faEeC',
			accent = '#efbEcC',
			foreground = '#a9cde2',

			transparent = true,

			decorations = {
				borders = false,
			},

			integrations = {
				ghostty = {
					enabled = false,
					update_config = false,
				},
			},
		}

		-- theme(xeno)

		-- vim.cmd.colorscheme 'polarized'
	end,
}
