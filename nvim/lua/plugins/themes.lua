--
--  nc = '#1f1d30',
--  base = '#232136',
--  surface = '#2a273f',
--  overlay = '#393552',
--  muted = '#6e6a86',
--  subtle = '#908caa',
--  text = '#e0def4',
--  love = '#eb6f92',
--  gold = '#f6c177',
--  rose = '#ea9a97',
--  pine = '#3e8fb0',
--  foam = '#9ccfd8',
--  iris = '#c4a7e7',
--  highlight_low = '#2a283e',
--  highlight_med = '#44415a',
--  highlight_high = '#56526e',

local themes = {
	DARK = {
		dir = '../themes/dark_theme.lua',
		priority = 1000,
		config = function() require 'themes.dark_theme' end,
	},

	CUSTOM_ROSE_PINE_DARK = {
		dir = '../themes/rose_pine.lua',
		priority = 1000,
		config = function() require 'themes.rose_pine' end,
	},

	NEW_DARK = {
		priority = 1000,
		dir = '../themes/new_dark_theme.lua',
		config = function() require 'themes.new_dark_theme' end,
	},

	GITHUB_LIGHT = {
		'projekt0n/github-nvim-theme',
		priority = 1000,
		config = function()
			require('github-theme').setup {}

			vim.cmd 'colorscheme github_light_high_contrast'
		end,
	},

	ROSE_PINE_LIGHT = {
		'rose-pine/neovim',
		priority = 1000,
		name = 'rose-pine',
		config = function()
			require('rose-pine').setup {}

			vim.cmd 'colorscheme rose-pine-dawn'
		end,
	},

	ROSE_PINE_DARK = {
		'rose-pine/neovim',
		priority = 1000,
		lazy = false,
		name = 'rose-pine',
		config = function()
			local rp = require 'rose-pine'

			rp.setup {
				variant = 'moon',
				dark_variant = 'moon',
				dim_nc_background = false,
				disable_background = true,
				disable_float_background = true,

				highlight_groups = {
					Normal = { fg = '#908caa' },
					NormalNC = { fg = '#908caa' },
					GitSignsAdd = { bg = 'none' },
					GitSignsChange = { bg = 'none' },
					GitSignsDelete = { bg = 'none' },
					MiniCursorword = { underline = false, bg = 'foam', blend = 30 },
					HopNextKey1 = { fg = 'love' },
					HopNextKey2 = { fg = 'pine' },
					VertSplit = { fg = '#405879' },
                    TreesitterContext = { bg = 'muted', blend = 15 },
					TreesitterContextSeparator = { fg = 'rose' },
					CmpItemKindCodeium = { fg = 'iris' },
					['@variable'] = { italic = false, fg = '#c4c6e7' },
					['@lsp.type.property'] = { italic = false },
                    ['@property.typescript'] = { italic = false, fg = '#7a8bb1' },
					['@punctuation'] = { italic = true },
					['@attribute'] = { fg = 'iris' },
					['@neorg.headings.1.title'] = { fg = 'iris' },
					['@neorg.lists.unordered.prefix.norg'] = { fg = 'iris' },
					['@neorg.todo_items.done.norg'] = { fg = 'foam' },
				},
			}

			vim.cmd 'colorscheme rose-pine'
		end,
	},
}

return { themes.ROSE_PINE_DARK }
