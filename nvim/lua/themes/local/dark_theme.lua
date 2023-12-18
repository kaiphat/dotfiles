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
H.NormalNC = merge(H.Normal)
H.SignColumn = { fg = c.fg, bg = nil }
H.Underlined = merge(H.Uc)
H.Bold = merge(H.Bold)
H.Italic = merge(H.It)
H.Error = { fg = c.blue_gray }
H.ErrorMsg = merge(H.Error)
H.WarningMsg = { fg = c.red }
H.Comment = merge(H.It, { fg = c.gray_blue })
H.Conceal = merge(H.Bold, { fg = c.red })
H.Cursor = { fg = nil, bg = c.one_bg3 }
H.CursorLine = { fg = nil, bg = c.one_bg3 }
H.CursorColumn = H.CursorLine
H.ColorColumn = { bg = c.red }
H.DiffAdd = { bg = c.green_blue }
H.DiffChange = { bg = c.red }
H.DiffDelete = { bg = c.blue_gray }
H.DiffText = { bg = c.red, fg = c.fg }
H.LineNr = { fg = c.gray_blue, bg = nil }
H.SignColumn = merge(H.LineNr)
H.FoldColumn = merge(H.LineNr, H.Bold)
H.Folded = { fg = c.gray }
H.CursorLineNr = merge(H.LineNr, H.Bold, { fg = c.fg })
H.MoreMsg = { fg = c.green_blue }
H.Float = { bg = nil, fg = c.cyan }
H.NormalFloat = { fg = c.cyan, bg = nil }
H.FloatBorder = merge(H.NormalFloat, H.Bold, { fg = c.sky })
H.FloatShadow = { bg = nil }
H.FloatShadowThrough = { bg = nil }
H.Visual = { fg = c.fg, bg = c.one_bg3 }
H.Pmenu = merge(H.NormalFloat)
H.PmenuSel = merge(H.Visual)
H.PmenuSbar = { bg = c.bg } -- scroll
H.PmenuThumb = merge(H.Visual, { fg = nil })
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
H.SpecialKey = merge(H.NonText, H.It)
H.Whitespace = merge(H.NonText)
H.EndOfBuffer = merge(H.NonText)
H.WildMenu = { bg = c.yellow, fg = c.bg }
H.Directory = { fg = c.fg, gui = nil }
H.Question = merge(H.MoreMsg)
H.Title = merge(H.Bold, { fg = c.fg })
H.Constant = merge(H.It, { fg = c.red })
H.String = { fg = c.green_tea, gui = nil }
H.Number = { fg = c.red }
H.Boolean = merge(H.Number)
H.Identifier = { fg = c.fg }
H.Function = { fg = c.fg }
H.Statement = merge(H.Bold, { fg = c.blue_nord })
H.PreProc = merge(H.Statement)
H.Special = merge(H.Bold, { fg = c.green_blue })
H.Delimiter = { fg = c.gray_blue }
H.SpecialComment = merge(H.Comment, { gui = nil })

-- HARPOON --
H.HarpoonBorder = merge(H.FloatBorder)

-- LSP --
H.LspReferenceText = merge(H.Visual, { fg = nil })
H.LspReferenceRead = merge(H.LspReferenceText)
H.LspReferenceWrite = merge(H.LspReferenceText)
H.LspCodeLens = merge(H.LineNr)

H.DiagnosticError = merge(H.WarningMsg)
H.DiagnosticWarn = merge(H.WarningMsg)
H.DiagnosticInfo = { fg = c.red }
H.DiagnosticHint = { fg = c.yellow }

H.DiagnosticSignError = merge(H.SignColumn, H.DiagnosticError)
H.DiagnosticSignWarn = merge(H.SignColumn, H.DiagnosticWarn)
H.DiagnosticSignInfo = merge(H.SignColumn, H.DiagnosticInfo)
H.DiagnosticSignHint = merge(H.SignColumn, H.DiagnosticHint)

H.DiagnosticVirtualTextError = merge(H.DiagnosticError, { bg = nil })
H.DiagnosticVirtualTextWarn = merge(H.DiagnosticVirtualTextError)
H.DiagnosticVirtualTextInfo = merge(H.DiagnosticVirtualTextError)
H.DiagnosticVirtualTextHint = merge(H.DiagnosticVirtualTextError)

H.DiagnosticUnderlineWarn = merge(H.Uc, { sp = c.blue_gray })
H.DiagnosticUnderlineInfo = H.DiagnosticUnderlineWarn
H.DiagnosticUnderlineHint = H.DiagnosticUnderlineWarn
H.DiagnosticUnderlineError = H.DiagnosticUnderlineWarn

-- NOICE --
H.NoiceCmdlineIcon = { fg = c.blue_gray }
H.NoiceCmdlinePopupBorder = merge(H.FloatBorder)
H.NoiceCmdlinePopupTitle = { fg = c.blue_gray }
H.NoiceCmdlinePopupBorderSearch = merge(H.NoiceCmdlinePopupBorder)
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
H['@const.builtin'] = merge(H.Number)
H['@const.macro'] = merge(H.Number)
H['@method'] = merge(H.Bold, { fg = c.blue_gray })
H['@function'] = merge(H['@method'])
H['@parameter'] = { fg = c.r1 }
H['@namespace'] = merge(H.Special)
H['@punctuation'] = merge(H.It, { fg = c.one_bg4, bg = nil })
H['@punct.bracket'] = merge(H.It, { fg = c.one_bg4, bg = nil })
H['@punct.delimiter'] = merge(H['@punct.bracket'])
H['@punct.special'] = merge(H['@punct.bracket'])
H['@string.escape'] = { fg = c.red, bg = nil }
H['@variable'] = merge(H.Identifier, H.Bold)
H['@variable.builtin'] = merge(H.Number)
H['@tag'] = merge(H.Special)
H['@tag.delimiter'] = merge(H.It, { fg = c.one_bg4, bg = nil })
H['@tag.attribute'] = { fg = c.blue }
H['@emphasis'] = merge(H.Italic)
H['@underline'] = merge(H.Underlined)
H['@strong'] = merge(H.Bold)
H['@literal'] = { fg = c.red }
H['@note'] = merge(H.DiagnosticInfo)
H['@warning'] = merge(H.WarningMsg)
H['@danger'] = merge(H.Error)
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
H.htmlLink = merge(H['@text.uri'])

-- NEO TREE --
H.NeoTreeNormal = merge(H.NormalFloat)
H.NeoTreeDimText = { fg = c.one_bg4 }
H.NeoTreeDotfile = merge(H.NeoTreeDimText)
H.NeoTreeMessage = merge(H.NeoTreeDimText)
H.NeoTreeTitleBar = merge(H.NeoTreeDimText)
H.NeoTreeFloatBorder = merge(H.FloatBorder)
H.NeoTreeGitAdded = { fg = c.green_tea }
H.NeoTreeGitStaged = H.NeoTreeGitAdded
H.NeoTreeGitUnstaged = H.NeoTreeGitAdded
H.NeoTreeGitModified = { fg = c.green_blue }
H.NeoTreeGitDeleted = { fg = c.red }
H.NeoTreeGitUntracked = H.NeoTreeGitUnstaged

-- NEORG --
H['@neorg.headings.1.title'] = { fg = c.purple }

-- TREESITTER CONTEXT --
H.TreesitterContext = merge(H.Visual)

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
H.markdownTSPunctSpecial = merge(H.Special)
H.markdownTSStringEscape = merge(H.SpecialKey)
H.markdownTSTextReference = merge(H.Identifier, H.Ul)
H.markdownTSEmphasis = merge(H.Italic)
H.markdownTSTitle = merge(H.Statement)
H.markdownTSLiteral = H.Statement
H.markdownTSURI = merge(H.SpecialComment)
H.markdownUrl = merge(H.markdownTSURI)
H.markdownCode = merge(H.markdownTSLiteral)
H.markdownLinkText = merge(H.markdownTSTextReference)
H.markdownLinkTextDelimiter = merge(H.Delimiter)

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

H.GitSignsAddLn = merge(H.GitSignsAdd)
H.GitSignsChangeLn = merge(H.GitSignsChange)
H.GitSignsDeleteLn = merge(H.GitSignsDelete)

H.GitSignsAddPreview = { bg = add }
H.GitSignsChangePreview = { bg = delete }
H.GitSignsDeletePreview = { bg = delete }

H.GitGutterAdd = merge(H.GitSignsAdd)
H.GitGutterChange = { fg = c.pink }
H.GitGutterDelete = { fg = c.pink }

H.DiffAdd = { bg = '#223233' }
H.DiffChange = { bg = '#223233' }
H.DiffText = merge(H.Visual, { fg = nil, underline = nil })
H.DiffDelete = { bg = '#321911' }

-- NOTIFY --
H.NotifyINFOBody = merge(H.NormalFloat)
H.NotifyWARNBody = merge(H.NormalFloat)
H.NotifyERRORBody = merge(H.NormalFloat)
H.NotifyDEBUGBody = merge(H.NormalFloat)
H.NotifyTRACEBody = merge(H.NormalFloat)

H.NotifyINFOTitle = { fg = c.green_tea }
H.NotifyINFOIcon = merge(H.NotifyINFOTitle)
H.NotifyErrorTitle = { fg = c.red }
H.NotifyErrorIcon = merge(H.NotifyErrorTitle)

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
H.CmpItemAbbrMatch = merge(H.Bold, { fg = c.teal })
H.CmpItemAbbrMatchFuzzy = merge(H.Bold, { fg = c.teal })
H.CmpItemKind = { fg = c.gray }
H.CmpItemMenu = { fg = c.gray }
H.CmpItemMenuDefault = merge(H.NormalFloat)

-- TELESCOPE --
H.TelescopeNormal = { fg = c.fg, bg = nil }
H.TelescopeSelection = merge(H.Visual, { fg = nil })
H.TelescopeMatching = { fg = H.CmpItemAbbrMatch.fg }
H.TelescopeBorder = merge(H.FloatBorder)

H.TelescopeSelectionCaret = merge(H.TelescopeSelection, { fg = c.red })
H.TelescopeTitle = merge(H.TelescopeNormal)
H.TelescopePromptPrefix = H.TelescopeTitle
H.TelescopePromptCounter = H.TelescopeTitle
H.TelescopePromptTitle = H.TelescopeTitle
H.TelescopePromptNormal = { bg = nil }
H.TelescopePromptBorder = merge(H.TelescopeBorder, { bg = nil })

-- SNEAK --
H.Sneak = merge(H.Search)
H.SneakLabel = merge(H.WildMenu)
H.SneakLabelMask = { bg = c.yellow, fg = c.yellow }

-- LIGHTSPEED --
H.LightspeedLabelOverlapped = merge(H.Ul, { fg = c.yellow })
H.LightspeedLabelDistantOverlapped = merge(H.Ul, { fg = c.orange })
H.LightspeedOneCharMatch = merge(H.SneakLabel, H.Bold)
H.LightspeedMaskedChar = merge(H.Conceal)
H.LightspeedUnlabeledMatch = merge(H.Bold)
H.LightspeedPendingOpArea = merge(H.SneakLabel)
H.LightspeedPendingChangeOpArea = { fg = c.yellow }
H.LightspeedGreyWash = merge(H.Comment)

-- HOP --
H.HopNextKey = { fg = c.purple }
H.HopNextKey1 = { fg = c.green_tea }
H.HopNextKey2 = { fg = c.purple }
H.HopUnmatched = { fg = '#445577' }

-- FIDGET --

H.FidgetTitle = H.FidgetTask

H.BufferCurrent = merge(H.TabLineSel)
H.BufferVisible = merge(H.StatusLineNC)
H.BufferVisibleSign = merge(H.StatusLineNC)
H.BufferVisibleIndex = merge(H.StatusLineNC)

-- NVIM TREE --
H.NvimTreeNormal = { fg = nil, bg = nil }
H.NvimTreeVertSplit = { fg = nil }
H.NvimTreeCursorLine = merge(H.CursorLine)
H.NvimTreeCursorColumn = merge(H.NvimTreeCursorLine)
H.NvimTreeRootFolder = merge(H.Bold, { fg = c.red })
H.NvimTreeSymlink = { fg = c.red }
H.NvimTreeExecFile = { fg = c.fg }
H.NvimTreeSpecialFile = { fg = c.fg, gui = nil }

H.NnnNormal = merge(H.NvimTreeNormal)
H.NnnNormalNC = merge(H.NnnNormal)

H.ChatGPTTotalTokensBorder = { fg = c.blue_darkest }
H.ChatGPTTotalTokens = { fg = c.fg, bg = H.ChatGPTTotalTokensBorder.fg }

H.FsashLabel = { bg = c.purple, fg = c.bg }
H.FlashMatch = { bg = c.teal, fg = c.bg }
H.FlashCurrent = { bg = c.teal, fg = c.bg }
H.MiniCursorword = H.Visual

for group, highlights in pairs(H) do
	for key, value in pairs(highlights) do
		if not value then highlights[key] = 'NONE' end
	end

	vim.api.nvim_set_hl(0, group, highlights)
end
