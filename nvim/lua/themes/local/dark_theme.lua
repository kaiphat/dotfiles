local u = require 'utils'
local H = {}
local c = {
	bg = '#202837',
	fg = '#c4c6e7',
	one_bg2 = '#384155',
	one_bg3 = '#405879',
	one_bg4 = '#486892',
	one_bg5 = '#253147',
	cyan = '#a3b8ef',
	blue_gray = '#9398cf',
	purple = '#c2a2e3',
	blue_nord = '#81A1C1',
	teal = '#81c8be',
	blue = '#8caaee',
	lavender = '#babbf1',
	sky = '#7a8bb1',
	sapphire = '#85c1dc',
	pink = '#f4b8e4',
	blue_darkest = '#404060',
	yellow = '#fbdf9a',
	red = '#ef8891',
	r1 = '#cb7f9a',
	green_blue = '#66A0A0',
	green_tea = '#9CC4B2',
	brown = '#c8ae9d',
	orange = '#fca2aa',
	orange_dark = '#ef9f76',
	gray = '#6e88a6',
	gray_blue = '#788aa3',
}

-- BASE --
H.It = { italic = true }
H.Bold = { bold = true }
H.Ul = { underline = true }
H.Uc = { undercurl = true }

-- GENERAL --
H.Normal = { fg = c.fg, bg = nil }
H.NormalNC = u.merge(H.Normal)
H.SignColumn = { fg = c.fg, bg = nil }
H.Underlined = u.merge(H.Uc)
H.Bold = u.merge(H.Bold)
H.Italic = u.merge(H.It)
H.Error = { fg = c.blue_gray }
H.ErrorMsg = u.merge(H.Error)
H.WarningMsg = { fg = c.red }
H.Comment = u.merge(H.It, { fg = c.gray_blue })
H.Conceal = u.merge(H.Bold, { fg = c.red })
H.Cursor = { fg = nil, bg = c.one_bg3 }
H.CursorLine = { fg = nil, bg = c.one_bg3 }
H.CursorColumn = H.CursorLine
H.ColorColumn = { bg = c.red }
H.DiffAdd = { bg = c.green_blue }
H.DiffChange = { bg = c.red }
H.DiffDelete = { bg = c.blue_gray }
H.DiffText = { bg = c.red, fg = c.fg }
H.LineNr = { fg = c.gray_blue, bg = nil }
H.SignColumn = u.merge(H.LineNr)
H.FoldColumn = u.merge(H.LineNr, H.Bold)
H.Folded = { fg = c.gray }
H.CursorLineNr = u.merge(H.LineNr, H.Bold, { fg = c.fg })
H.MoreMsg = { fg = c.green_blue }
H.Float = { bg = nil, fg = c.cyan }
H.NormalFloat = { fg = c.cyan, bg = nil }
H.FloatBorder = u.merge(H.NormalFloat, H.Bold, { fg = c.sky })
H.FloatShadow = { bg = nil }
H.FloatShadowThrough = { bg = nil }
H.Visual = { fg = c.fg, bg = c.one_bg3 }
H.Pmenu = u.merge(H.NormalFloat)
H.PmenuSel = u.merge(H.Visual)
H.PmenuSbar = { bg = c.bg } -- scroll
H.PmenuThumb = u.merge(H.Visual, { fg = nil })
H.Search = { fg = c.one_bg2, bg = c.teal }
H.IncSearch = { fg = c.one_bg2, bg = c.teal }
H.MatchParen = { fg = c.red, bg = nil }
H.StatusLine = { bg = nil, fg = nil, gui = nil }
H.StatusLineNC = { bg = c.blue_darkest, fg = c.fg }
H.TabLine = { fg = c.blue_darkest, bg = c.blue_gray }
H.TabLineSel = { fg = c.blue_darkest, bg = c.cyan }
H.TabLineFill = { fg = c.cyan, bg = nil }
H.VertSplit = { fg = c.blue_darkest, bg = nil }
H.NonText = { fg = c.one_bg3 }
H.SpecialKey = u.merge(H.NonText, H.It)
H.Whitespace = u.merge(H.NonText)
H.EndOfBuffer = u.merge(H.NonText)
H.WildMenu = { bg = c.yellow, fg = c.bg }
H.Directory = { fg = c.fg, gui = nil }
H.Question = u.merge(H.MoreMsg)
H.Title = u.merge(H.Bold, { fg = c.fg })
H.Constant = u.merge(H.It, { fg = c.red })
H.String = { fg = c.green_tea, gui = nil }
H.Number = { fg = c.red }
H.Boolean = u.merge(H.Number)
H.Identifier = { fg = c.fg }
H.Function = { fg = c.fg }
H.Statement = u.merge(H.Bold, { fg = c.blue_nord })
H.PreProc = u.merge(H.Statement)
H.Special = u.merge(H.Bold, { fg = c.green_blue })
H.Delimiter = { fg = c.gray_blue }
H.SpecialComment = u.merge(H.Comment, { gui = nil })

-- HARPOON --
H.HarpoonBorder = u.merge(H.FloatBorder)

-- LSP --
H.LspReferenceText = u.merge(H.Visual, { fg = nil })
H.LspReferenceRead = u.merge(H.LspReferenceText)
H.LspReferenceWrite = u.merge(H.LspReferenceText)
H.LspCodeLens = u.merge(H.LineNr)

H.DiagnosticError = u.merge(H.WarningMsg)
H.DiagnosticWarn = u.merge(H.WarningMsg)
H.DiagnosticInfo = { fg = c.red }
H.DiagnosticHint = { fg = c.yellow }

H.DiagnosticSignError = u.merge(H.SignColumn, H.DiagnosticError)
H.DiagnosticSignWarn = u.merge(H.SignColumn, H.DiagnosticWarn)
H.DiagnosticSignInfo = u.merge(H.SignColumn, H.DiagnosticInfo)
H.DiagnosticSignHint = u.merge(H.SignColumn, H.DiagnosticHint)

H.DiagnosticVirtualTextError = u.merge(H.DiagnosticError, { bg = nil })
H.DiagnosticVirtualTextWarn = u.merge(H.DiagnosticVirtualTextError)
H.DiagnosticVirtualTextInfo = u.merge(H.DiagnosticVirtualTextError)
H.DiagnosticVirtualTextHint = u.merge(H.DiagnosticVirtualTextError)

H.DiagnosticUnderlineWarn = u.merge(H.Uc, { sp = c.blue_gray })
H.DiagnosticUnderlineInfo = H.DiagnosticUnderlineWarn
H.DiagnosticUnderlineHint = H.DiagnosticUnderlineWarn
H.DiagnosticUnderlineError = H.DiagnosticUnderlineWarn

-- NOICE --
H.NoiceCmdlineIcon = { fg = c.blue_gray }
H.NoiceCmdlinePopupBorder = u.merge(H.FloatBorder)
H.NoiceCmdlinePopupTitle = { fg = c.blue_gray }
H.NoiceCmdlinePopupBorderSearch = u.merge(H.NoiceCmdlinePopupBorder)
H.NoiceCmdlineIconSearch = { fg = c.blue_gray }
H.NoiceLspProgressTitle = { fg = c.blue_gray }
H.NoiceLspProgressClient = { fg = c.blue_gray }
H.NoiceLspProgressSpinner = { fg = c.blue_gray }

H.NoiceVirtualText = { fg = c.one_bg2, bg = c.pink }
H.NoiceMini = { fg = c.lavender, bg = nil }

-- TREESITTER --
H['@constructor'] = { fg = c.brown }
H['@type'] = { fg = c.gray_blue }
H['@class'] = { fg = c.sapphire }
H['@enum'] = { fg = c.pink }
H['@field'] = { fg = c.cyan }
H['@property'] = { fg = c.cyan }
H['@keyword'] = { fg = c.teal }
H['@string'] = { fg = c.green_tea }
-- hl["@text"] = { underline = nil, undercurl = nil }
-- hl["@spell"] = { underline = nil, undercurl = nil }
H['@text.uri'] = { fg = c.red, underline = nil }
H['@constant'] = { fg = c.lavender }
H['@const.builtin'] = u.merge(H.Number)
H['@const.macro'] = u.merge(H.Number)
H['@method'] = u.merge(H.Bold, { fg = c.blue_gray })
H['@function'] = u.merge(H['@method'])
H['@parameter'] = { fg = c.r1 }
H['@namespace'] = u.merge(H.Special)
H['@punctuation'] = u.merge(H.It, { fg = c.one_bg4, bg = nil })
H['@punct.bracket'] = u.merge(H.It, { fg = c.one_bg4, bg = nil })
H['@punct.delimiter'] = u.merge(H['@punct.bracket'])
H['@punct.special'] = u.merge(H['@punct.bracket'])
H['@string.escape'] = { fg = c.red, bg = nil }
H['@variable'] = u.merge(H.Identifier, H.Bold)
H['@variable.builtin'] = u.merge(H.Number)
H['@tag'] = u.merge(H.Special)
H['@tag.delimiter'] = u.merge(H.It, { fg = c.one_bg4, bg = nil })
H['@tag.attribute'] = { fg = c.blue }
H['@emphasis'] = u.merge(H.Italic)
H['@underline'] = u.merge(H.Underlined)
H['@strong'] = u.merge(H.Bold)
H['@literal'] = { fg = c.red }
H['@note'] = u.merge(H.DiagnosticInfo)
H['@warning'] = u.merge(H.WarningMsg)
H['@danger'] = u.merge(H.Error)
H['@number'] = { fg = c.red }
H['@boolean'] = { fg = c.orange_dark }
H['@structure'] = { fg = c.orange_dark }
H['@storageclass'] = { fg = c.orange_dark }
H['@storageclass'] = { fg = c.orange_dark }
H['@type.definition'] = { fg = c.orange_dark }
-- semantic tokens below
-- @class
-- @struct
-- @enum
-- @enumMember
-- @event
-- @interface
-- @modifier
-- @regexp
-- @typeParameter
-- @decorator

H.Type = H['@type']
-- HTML --
H.htmlLink = u.merge(H['@text.uri'])

-- NEO TREE --
H.NeoTreeNormal = u.merge(H.NormalFloat)
H.NeoTreeDimText = { fg = c.one_bg4 }
H.NeoTreeDotfile = u.merge(H.NeoTreeDimText)
H.NeoTreeMessage = u.merge(H.NeoTreeDimText)
H.NeoTreeTitleBar = u.merge(H.NeoTreeDimText)
H.NeoTreeFloatBorder = u.merge(H.FloatBorder)
H.NeoTreeGitAdded = { fg = c.green_tea }
H.NeoTreeGitStaged = H.NeoTreeGitAdded
H.NeoTreeGitUnstaged = H.NeoTreeGitAdded
H.NeoTreeGitModified = { fg = c.green_blue }
H.NeoTreeGitDeleted = { fg = c.red }
H.NeoTreeGitUntracked = H.NeoTreeGitUnstaged

-- NEORG --
H['@neorg.headings.1.title'] = { fg = c.purple }

-- TREESITTER CONTEXT --
H.TreesitterContext = u.merge(H.Visual)

-- h.diffAdded = { fg = c.green_blue }
-- h.diffRemoved = { fg = c.blue_gray }
-- h.diffChanged = { fg = c.red }
-- h.diffOldFile = { fg = c.blue_gray, h.It }
-- h.diffNewFile = { fg = c.green_blue, h.It }
-- h.diffFile = { fg = c.red, h.Bold }
-- h.diffLine = { fg = c.select, h.Bold }
-- h.diffIndexLine = { fg = c.red }

-- h.gitcommitOverflow = { h.WarningMsg }

-- MARKDOWN --
H.markdownH1 = { gui = nil }
H.markdownTSPunctSpecial = u.merge(H.Special)
H.markdownTSStringEscape = u.merge(H.SpecialKey)
H.markdownTSTextReference = u.merge(H.Identifier, H.Ul)
H.markdownTSEmphasis = u.merge(H.Italic)
H.markdownTSTitle = u.merge(H.Statement)
H.markdownTSLiteral = H.Statement
H.markdownTSURI = u.merge(H.SpecialComment)
H.markdownUrl = u.merge(H.markdownTSURI)
H.markdownCode = u.merge(H.markdownTSLiteral)
H.markdownLinkText = u.merge(H.markdownTSTextReference)
H.markdownLinkTextDelimiter = u.merge(H.Delimiter)

-- h.helpHyperTextEntry = { h.Special }
-- h.helpHyperTextJump = { h.Constant }
-- h.helpSpecial = { h.Type }
-- h.helpOption = { h.Constant }

-- GIT --
local add = '#223233'
local delete = '#321911'

H.GitSignsAdd = { fg = c.green_blue }
H.GitSignsChange = { fg = c.cyan }
H.GitSignsDelete = { fg = c.cyan }

H.GitSignsAddLn = u.merge(H.GitSignsAdd)
H.GitSignsChangeLn = u.merge(H.GitSignsChange)
H.GitSignsDeleteLn = u.merge(H.GitSignsDelete)

H.GitSignsAddPreview = { bg = add }
H.GitSignsChangePreview = { bg = delete }
H.GitSignsDeletePreview = { bg = delete }

H.GitGutterAdd = u.merge(H.GitSignsAdd)
H.GitGutterChange = { fg = c.pink }
H.GitGutterDelete = { fg = c.pink }

H.DiffAdd = { bg = '#223233' }
H.DiffChange = { bg = '#223233' }
H.DiffText = u.merge(H.Visual, { fg = nil, underline = nil })
H.DiffDelete = { bg = '#321911' }

-- NOTIFY --
H.NotifyINFOBody = u.merge(H.NormalFloat)
H.NotifyWARNBody = u.merge(H.NormalFloat)
H.NotifyERRORBody = u.merge(H.NormalFloat)
H.NotifyDEBUGBody = u.merge(H.NormalFloat)
H.NotifyTRACEBody = u.merge(H.NormalFloat)

H.NotifyINFOTitle = { fg = c.green_tea }
H.NotifyINFOIcon = u.merge(H.NotifyINFOTitle)
H.NotifyErrorTitle = { fg = c.red }
H.NotifyErrorIcon = u.merge(H.NotifyErrorTitle)

-- hl.NotifyDEBUGTitle = { fg = c.red }
-- hl.NotifyINFOTitle29 = { fg = c.red }
-- hl.NotifyINFOTitle30 = { fg = c.red }

H.NotifyINFOBorder = H.FloatBorder
H.NotifyWARNBorder = H.NotifyINFOBorder
H.NotifyERRORBorder = H.NotifyINFOBorder
H.NotifyDEBUGBorder = H.NotifyINFOBorder
H.NotifyTRACEBorder = H.NotifyINFOBorder

-- INDENT --
H.IndentBlanklineChar = { fg = c.blue_darkest }
H.IndentBlanklineContextChar = { fg = c.one_bg3 }

-- MINI --
H.MiniIndentscopeSymbol = { fg = c.one_bg3 }
H.MiniTrailspace = { bg = c.one_bg3 }

-- CMP --
H.CmpItemAbbr = { fg = c.fg }
H.CmpItemAbbrDeprecated = { fg = c.orange }
H.CmpItemAbbrMatch = u.merge(H.Bold, { fg = c.teal })
H.CmpItemAbbrMatchFuzzy = u.merge(H.Bold, { fg = c.teal })
H.CmpItemKind = { fg = c.gray }
H.CmpItemMenu = { fg = c.gray }
H.CmpItemMenuDefault = u.merge(H.NormalFloat)

-- TELESCOPE --
H.TelescopeNormal = { fg = c.fg, bg = nil }
H.TelescopeSelection = u.merge(H.Visual, { fg = nil })
H.TelescopeMatching = { fg = H.CmpItemAbbrMatch.fg }
H.TelescopeBorder = u.merge(H.FloatBorder)

H.TelescopeSelectionCaret = u.merge(H.TelescopeSelection, { fg = c.red })
H.TelescopeTitle = u.merge(H.TelescopeNormal)
H.TelescopePromptPrefix = H.TelescopeTitle
H.TelescopePromptCounter = H.TelescopeTitle
H.TelescopePromptTitle = H.TelescopeTitle
H.TelescopePromptNormal = { bg = nil }
H.TelescopePromptBorder = u.merge(H.TelescopeBorder, { bg = nil })

-- SNEAK --
H.Sneak = u.merge(H.Search)
H.SneakLabel = u.merge(H.WildMenu)
H.SneakLabelMask = { bg = c.yellow, fg = c.yellow }

-- LIGHTSPEED --
H.LightspeedLabelOverlapped = u.merge(H.Ul, { fg = c.yellow })
H.LightspeedLabelDistantOverlapped = u.merge(H.Ul, { fg = c.orange })
H.LightspeedOneCharMatch = u.merge(H.SneakLabel, H.Bold)
H.LightspeedMaskedChar = u.merge(H.Conceal)
H.LightspeedUnlabeledMatch = u.merge(H.Bold)
H.LightspeedPendingOpArea = u.merge(H.SneakLabel)
H.LightspeedPendingChangeOpArea = { fg = c.yellow }
H.LightspeedGreyWash = u.merge(H.Comment)

-- HOP --
H.HopNextKey = { fg = c.purple }
H.HopNextKey1 = { fg = c.green_tea }
H.HopNextKey2 = { fg = c.purple }
H.HopUnmatched = { fg = '#445577' }

-- FIDGET --

H.FidgetTitle = H.FidgetTask

H.BufferCurrent = u.merge(H.TabLineSel)
H.BufferVisible = u.merge(H.StatusLineNC)
H.BufferVisibleSign = u.merge(H.StatusLineNC)
H.BufferVisibleIndex = u.merge(H.StatusLineNC)

-- NVIM TREE --
H.NvimTreeNormal = { fg = nil, bg = nil }
H.NvimTreeVertSplit = { fg = nil }
H.NvimTreeCursorLine = u.merge(H.CursorLine)
H.NvimTreeCursorColumn = u.merge(H.NvimTreeCursorLine)
H.NvimTreeRootFolder = u.merge(H.Bold, { fg = c.red })
H.NvimTreeSymlink = { fg = c.red }
H.NvimTreeExecFile = { fg = c.fg }
H.NvimTreeSpecialFile = { fg = c.fg, gui = nil }

H.NnnNormal = u.merge(H.NvimTreeNormal)
H.NnnNormalNC = u.merge(H.NnnNormal)

H.ChatGPTTotalTokensBorder = { fg = c.blue_darkest }
H.ChatGPTTotalTokens = { fg = c.fg, bg = H.ChatGPTTotalTokensBorder.fg }

H.FsashLabel = { bg = c.purple, fg = c.bg }
H.FlashMatch = { bg = c.teal, fg = c.bg }
H.FlashCurrent = { bg = c.teal, fg = c.bg }
H.MiniCursorword = H.Visual

for group, highlights in pairs(H) do
	for key, value in pairs(highlights) do
		if not value then
			highlights[key] = 'NONE'
		end
	end

	vim.api.nvim_set_hl(0, group, highlights)
end
