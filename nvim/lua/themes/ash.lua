-- {
--   base = "#0a0a0c",
--   charcoal = "#636778",
--   crimson = "#bf616a",
--   crust = "#000000",
--   drift = "#8d9da1",
--   ember = "#d08770",
--   fog = "#a0a0af",
--   frost = "#96a8ad",
--   mantle = "#020203",
--   none = "NONE",
--   overlay0 = "#646782",
--   overlay1 = "#686c7d",
--   overlay2 = "#7f8497",
--   rose = "#e77f88",
--   rust = "#bc735c",
--   sage = "#9db89c",
--   seafoam = "#8dd3c3",
--   slate = "#7c7d8c",
--   storm = "#8796aa",
--   subtext0 = "#9399ad",
--   subtext1 = "#a6adc3",
--   surface0 = "#1e2122",
--   surface1 = "#31323c",
--   surface2 = "#555873",
--   text = "#9c9eb4",
--   tide = "#79a0aa"
-- }

return {
	'drewxs/ash.nvim',
	priority = 1000,
	lazy = false,
	config = function()
		require('ash').setup {
			transparent = true,

			highlights = function(colors)
				return {
					MiniCursorword = { underline = false, bg = colors.surface2 },
					MiniCursorwordCurrent = { underline = false, bg = colors.surface2 },
					TreesitterContext = { link = 'Visual' },
					TreesitterContextBottom = { link = 'TreesitterContext', underline = false },
					TreesitterContextSeparator = { fg = colors.rose },
				}
			end,
		}

		vim.cmd [[colorscheme ash]]
	end,
}
