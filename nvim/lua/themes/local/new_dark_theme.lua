local NONE = 'NONE'
local P = {
	fg = '#ccaaaa',
	blue = '#334499',
	red = '#990000',
}

local T = setmetatable({}, {
	__newindex = function(table, group, opts)
		local highlights = { fg = NONE, bg = NONE }

		loop(opts, function(k, v)
			if type(k) == 'number' then
                for k2, v2 in pairs(v) do
                    highlights[k2] = v2
                end
			else
				highlights[k] = v
			end
		end)

		rawset(table, group, highlights)
		vim.api.nvim_set_hl(0, group, highlights)
	end,
})

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     colors     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.fg_normal = { fg = P.fg }
T.fg_blue = { fg = P.blud }
T.fg_red = { fg = P.red }

T.bg_red = { bg = P.red }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     utility     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.it = { italic = true }
T.bold = { bold = true }
T.ul = { underline = true }
T.uc = { undercurl = true }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     base     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.Normal = { T.fg }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     float     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.Float = { T.fg_red }
T.FloatBorder = { T.Float }
-- T.NormalFloat = { fg = c.cyan, bg = nil }
-- T.FloatShadow = { bg = nil }
-- T.FloatShadowThrough = { bg = nil }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     treesitter     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     telescope     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈
