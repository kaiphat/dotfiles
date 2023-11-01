local COLORS = {
	fg = '#ccaaaa',
	blue = '#334499',
	red = '#990000',
}

local T = setmetatable({}, {
	__newindex = function(table, group, opts)
		local highlights = { fg = 'NONE', bg = 'NONE' }

		loop(opts, function(k, v)
			if type(k) == 'number' then
				highlights = merge(highlights, v)
			else
				highlights[k] = v
			end
		end)

		rawset(table, group, highlights)
		vim.api.nvim_set_hl(0, group, highlights)
	end,
})

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     colors     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
T.FG_NORMAL = { fg = COLORS.fg }
T.FG_BLUE = { fg = COLORS.blud }
T.FG_RED = { fg = COLORS.red }

T.BG_RED = { bg = COLORS.red }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     utility     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
T.IT = { italic = true }
T.BOLD = { bold = true }
T.UL = { underline = true }
T.UC = { undercurl = true }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     base     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
T.Normal = { T.FG }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     float     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
T.Float = { T.FG_RED }
T.FloatBorder = { T.Float }
-- T.NormalFloat = { fg = c.cyan, bg = nil }
-- T.FloatShadow = { bg = nil }
-- T.FloatShadowThrough = { bg = nil }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     treesitter     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     telescope     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
