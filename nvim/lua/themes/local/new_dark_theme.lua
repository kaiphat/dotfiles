local none = 'NONE'
local P = {
	text = '#f2f1f0',
	float = '#2c4875',
	visual = '#003f5c',
	delete = '#ff6361',
	add = '#bc5090',
	keyword = '#ffd380',
	field = '#ff8531',
	punctuation = '#2c4875',
}

--   #00202e
--   #003f5c
--   #2c4875
--   #8a508f
--   #bc5090
--   #ff6361
--   #ff8531
--   #ffa600
--   #ffd380
---  #f2f1f0

local T = setmetatable({}, {
	__newindex = function(table, group, opts)
		local highlights = { fg = none, bg = none }

		for k, v in pairs(opts) do
			if type(k) == 'number' then
				for k2, v2 in pairs(v) do
					highlights[k2] = v2
				end
			else
				highlights[k] = v
			end
		end

		rawset(table, group, highlights)
		vim.api.nvim_set_hl(0, group, highlights)
	end,
})

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     colors     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.fg_text = { fg = P.text }
T.fg_blue = { fg = P.blud }
T.fg_float = { fg = P.float }
T.fg_add = { fg = P.add }
T.fg_delete = { fg = P.delete }
T.fg_keyword = { fg = P.keyword }
T.fg_field = { fg = P.field }
T.fg_punctuation = { fg = P.punctuation }
T.fg_none = { fg = none }

T.bg_add = { bg = P.add }
T.bg_delete = { bg = P.delete }
T.bg_visual = { bg = P.visual }
T.bg_none = { bg = none }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     utility     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.it = { italic = true }
T.bold = { bold = true }
T.ul = { underline = true }
T.uc = { undercurl = true }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     base     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.Normal = { T.fg_text }
T.Visual = { T.bg_visual }
T.SignColumn = { T.gb_none }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     float     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.Float = { T.fg_text }
T.FloatBorder = { T.fg_float }
T.NormalFloat = { T.fg_text }
-- T.FloatShadow = { bg = nil }
-- T.FloatShadowThrough = { bg = nil }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     telescope     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.TelescopeNormal = { T.fg_text }
T.TelescopeSelection = { T.Visual }
-- T.TelescopeMatching = { fg = H.CmpItemAbbrMatch.fg }
-- T.TelescopeBorder = merge(H.FloatBorder)

-- T.TelescopeSelectionCaret = merge(H.TelescopeSelection, { fg = c.red })
-- T.TelescopeTitle = merge(H.TelescopeNormal)
-- T.TelescopePromptPrefix = H.TelescopeTitle
-- T.TelescopePromptCounter = H.TelescopeTitle
-- T.TelescopePromptTitle = H.TelescopeTitle
-- T.TelescopePromptNormal = { bg = nil }
-- T.TelescopePromptBorder = merge(H.TelescopeBorder, { bg = nil })

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     cmp     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.CmpItemAbbr = { T.fg_text }
-- T.CmpItemAbbrDeprecated = { fg = c.orange }
-- T.CmpItemAbbrMatch = merge(H.Bold, { fg = c.teal })
-- T.CmpItemAbbrMatchFuzzy = merge(H.Bold, { fg = c.teal })
-- T.CmpItemKind = { fg = c.gray }
-- T.CmpItemMenu = { fg = c.gray }
T.CmpItemMenuDefault = { T.FLoat }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     git     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T.GitSignsAdd = { T.fg_add }
T.GitSignsChange = { T.fg_add }
T.GitSignsDelete = { T.fg_delete }

T.GitSignsAddLn = { T.GitSignsAdd }
T.GitSignsChangeLn = { T.GitSignsAddLn }
T.GitSignsDeleteLn = { T.GitSignsDelete }

-- T.GitSignsAddPreview = { bg = add }
-- T.GitSignsChangePreview = { bg = delete }
-- T.GitSignsDeletePreview = { bg = delete }

-- T.GitGutterAdd = merge(H.GitSignsAdd)
-- T.GitGutterChange = { fg = c.pink }
-- T.GitGutterDelete = { fg = c.pink }

T.DiffAdd = { T.bg_add }
T.DiffChange = { T.bg_add }
T.DiffText = { T.bg_visual }
T.DiffDelete = { T.bg_delete }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     noice     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

-- T.NoiceCmdlineIcon = { fg = c.blue_gray }
T.NoiceCmdlinePopupBorder = { T.FloatBorder }
-- T.NoiceCmdlinePopupTitle = { fg = c.blue_gray }
-- T.NoiceCmdlinePopupBorderSearch = merge(H.NoiceCmdlinePopupBorder)
-- T.NoiceCmdlineIconSearch = { fg = c.blue_gray }
-- T.NoiceLspProgressTitle = { fg = c.blue_gray }
-- T.NoiceLspProgressClient = { fg = c.blue_gray }
-- T.NoiceLspProgressSpinner = { fg = c.blue_gray }
-- T.NoiceVirtualText = { fg = c.one_bg2, bg = c.pink }
-- T.NoiceMini = { fg = c.lavender, bg = nil }

-- ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈     treesitter     ┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈┈

T['@keyword'] = { T.fg_keyword }
T['@field'] = { T.fg_field }
T['@punctuation'] = { T.fg_punctuation }
