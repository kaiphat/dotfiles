--   red = '#ef8891',
--   baby_pink = '#fca2aa',
--   pink = '#fca2af',
--   line = '#272e35', -- for lines like vertsplit
--   green = '#9fe8c3',
--   vibrant_green = '#9ce5c0',
--   blue = '#99aee5',
--   nord_blue = '#9aa8cf',
--   yellow = '#fbdf90',
--   sun = '#fbdf9a',
--   purple = '#c2a2e3',
--   dark_purple = '#b696d7',
--   teal = '#92dbb6',
--   orange = '#EDA685',
--   cyan = '#b5c3ea',
--   statusline_bg = '#181f26',
--   lightbg = '#222930',
--   pmenu_bg = '#ef8891',
--   folder_bg = '#99aee5',

-- Rosewater	#f2d5cf
-- Flamingo	#eebebe
-- aPink	#f4b8e4
-- Mauve	#ca9ee6
-- aRed	#e78284
-- aMaroon	#ea999c
-- Peach	#ef9f76
-- aYellow	#e5c890
-- aGreen	#a6d189
-- aTeal	#81c8be
-- Sky	#99d1db
-- Sapphire	#85c1dc
-- aBlue	#8caaee
-- aLavender	#babbf1
-- Text	#c6d0f5
-- Subtext1	#b5bfe2
-- Subtext0	#a5adce
-- Overlay2	#949cbb
-- Overlay1	#838ba7
-- Overlay0	#737994
-- Surface2	#626880
-- Surface1	#51576d
-- Surface0	#414559
-- Base	#303446
-- Mantle	#292c3c
-- Crust	#232634


local c = {
  bg = '#202837',
  fg = '#b4b6d7',
  one_bg2 = '#2a3143',
  one_bg3 = '#405879',
  one_bg4 = '#486892',

  cyan         = '#a3b8ef',
  blue_gray    = '#9398cf',
  purple       = '#c2a2e3',
  blue_nord    = '#81A1C1',
  blue_darkest = '#404060',
  yellow       = '#fbdf9a',
  red          = '#ef8891',
  green_blue   = '#66A0A0',
  green_tea    = '#9CC4B2',
  brown        = '#c8ae9d',
  orange       = '#fca2aa',
  orange_dark  = '#ef9f76',
  nord_gray_2  = '#3b4252',
  gray         = '#6e88a6',
  gray_blue    = '#788aa3',
}

local hl = {}

C = ""

-- BASE --
hl.It   = { italic = true }
hl.Bold = { bold = true }
hl.Ul   = { underline = true }
hl.Uc   = { undercurl = true }

-- GENERAL --
hl.Normal = { fg = c.fg, bg = c.bg }
hl.Underlined = { hl.Ul }
hl.Bold = { hl.Bold, }
hl.Italic = { hl.It }
hl.Error = { fg = c.blue_gray }
hl.ErrorMsg = { hl.Error }
hl.WarningMsg = { fg = c.red }
hl.Comment = { fg = c.gray_blue, hl.It }
hl.Conceal = { fg = c.red, hl.Bold }
hl.Cursor = { fg = nil, bg = c.one_bg3 }
-- h.lCursor = { h.Cursor }
-- h.TermCursor = { h.Cursor }
-- h.TermCursorNC = { h.lCursor }
-- h.CursorColumn = { h.CursorLine }
hl.CursorLine = { fg = nil, bg = nil }
hl.ColorColumn = { bg = c.red }
hl.DiffAdd = { bg = c.green_blue }
hl.DiffChange = { bg = c.red }
hl.DiffDelete = { bg = c.blue_gray }
hl.DiffText = { bg = c.red, fg = c.fg }
hl.LineNr = { fg = c.gray_blue, bg = nil }
hl.SignColumn = { hl.LineNr }
hl.FoldColumn = { hl.LineNr, hl.Bold }
hl.Folded = { fg = c.gray }
hl.CursorLineNr = { hl.LineNr, fg = c.fg, hl.Bold }
hl.MoreMsg = { fg = c.green_blue }
hl.Float = { bg = c.one_bg2 }
hl.NormalFloat = { bg = c.one_bg2 }
hl.FloatBorder = { fg = hl.NormalFloat.bg, bg = hl.NormalFloat.bg }
hl.FloatShadow = { bg = nil }
hl.FloatShadowThrough = { bg = nil }
hl.Visual = { fg = c.fg, bg = c.one_bg3 }
hl.Pmenu = { hl.NormalFloat }
hl.PmenuSel = { hl.Visual }
hl.PmenuSbar = { bg = c.bg } -- scroll
hl.PmenuThumb = { bg = hl.Visual.bg }
hl.Search = { fg = c.blue_darkest, bg = c.red }
hl.IncSearch = { fg = c.blue_darkest, bg = c.red }
hl.MatchParen = { fg = c.red, bg = nil }
hl.StatusLine = { bg = nil, fg = nil, gui = nil }
hl.StatusLineNC = { bg = c.blue_darkest, fg = c.fg }
hl.TabLine = { fg = c.blue_darkest, bg = c.blue_gray }
hl.TabLineSel = { fg = c.blue_darkest, bg = c.cyan }
hl.TabLineFill = { fg = c.cyan, bg = nil }
hl.VertSplit = { fg = c.blue_darkest, bg = nil }
hl.NonText = { fg = c.one_bg3 }
hl.SpecialKey = { hl.NonText, hl.It }
hl.Whitespace = { hl.NonText }
hl.EndOfBuffer = { hl.NonText }
hl.WildMenu = { bg = c.yellow, fg = c.bg }
hl.Directory = { fg = c.fg, gui = nil }
hl.Question = { hl.MoreMsg }
hl.Title = { fg = c.fg, hl.Bold }
hl.Constant = { fg = c.red, hl.It }
hl.String = { fg = c.green_tea, gui = nil }
hl.Number = { fg = c.red }
hl.Boolean = { hl.Number }
hl.Identifier = { fg = c.fg }
hl.Function = { fg = c.fg }
hl.Statement = { fg = c.blue_nord, hl.Bold }
hl.PreProc = { hl.Statement }
hl.Special = { fg = c.green_blue, hl.Bold }
hl.Delimiter = { fg = c.gray_blue }
hl.SpecialComment = { hl.Comment, gui = nil }

-- HARPOON --
hl.HarpoonBorder = { hl.FloatBorder }

-- LSP --
hl.LspReferenceText = { bg = hl.Visual.bg }
hl.LspReferenceRead = { hl.LspReferenceText }
hl.LspReferenceWrite = { hl.LspReferenceText }
hl.LspCodeLens = { hl.LineNr }

hl.DiagnosticError = { hl.WarningMsg }
hl.DiagnosticWarn = { hl.WarningMsg }
hl.DiagnosticInfo = { fg = c.red }
hl.DiagnosticHint = { fg = c.yellow }

hl.DiagnosticSignError = { hl.SignColumn, fg = hl.DiagnosticError.fg }
hl.DiagnosticSignWarn = { hl.SignColumn, fg = hl.DiagnosticWarn.fg }
hl.DiagnosticSignInfo = { hl.SignColumn, fg = hl.DiagnosticInfo.fg }
hl.DiagnosticSignHint = { hl.SignColumn, fg = hl.DiagnosticHint.fg }

hl.DiagnosticVirtualTextError = { hl.DiagnosticError, bg = nil }
hl.DiagnosticVirtualTextWarn = { hl.DiagnosticVirtualTextError }
hl.DiagnosticVirtualTextInfo = { hl.DiagnosticVirtualTextError }
hl.DiagnosticVirtualTextHint = { hl.DiagnosticVirtualTextError }

hl.DiagnosticUnderlineWarn = { hl.Ul, sp = hl.WarningMsg.fg }
hl.DiagnosticUnderlineInfo = { hl.DiagnosticUnderlineWarn }
hl.DiagnosticUnderlineHint = { hl.DiagnosticUnderlineWarn }
hl.DiagnosticUnderlineError = { hl.DiagnosticUnderlineWarn }

-- NOICE --
hl.NoiceCmdlineIcon = { fg = c.blue_gray }
hl.NoiceCmdlineIconSearch = { fg = c.blue_gray }
hl.NoiceLspProgressTitle = { fg = c.blue_gray }
hl.NoiceLspProgressClient = { fg = c.blue_gray }
hl.NoiceLspProgressSpinner = { fg = c.blue_gray }

-- TREESITTER --
hl['@constructor'] = { fg = c.brown }
hl['@type'] = { fg = c.green_blue }
hl['@constant'] = { hl.Identifier, hl.Bold }
hl['@const.builtin'] = { hl.Number }
hl['@const.macro'] = { hl.Number }
hl['@method'] = { fg = c.blue_gray, hl.Bold }
hl['@field'] = { fg = c.gray_blue }
hl['@function'] = { hl['@method'] }
hl['@function'] = { hl['@method'] }
hl['@namespace'] = { hl.Special }
hl['@property'] = { fg = c.gray }
hl['@punct.bracket'] = { fg = c.one_bg4, hl.It, bg = nil }
hl['@punct.delimiter'] = { hl['@punct.bracket'] }
hl['@punct.special'] = { hl['@punct.bracket'] }
hl['@string.escape'] = { fg = c.red, bg = nil }
hl['@variable'] = { hl.Identifier }
hl['@variable.builtin'] = { hl.Number }
hl['@tag'] = { hl.Special }
hl['@emphasis'] = { hl.Italic }
hl['@underline'] = { hl.Underlined }
hl['@strong'] = { hl.Bold }
hl['@literal'] = { fg = c.red }
hl['@note'] = { hl.DiagnosticInfo }
hl['@warning'] = { hl.WarningMsg }
hl['@danger'] = { hl.Error }
hl['@number'] = { fg = c.red }
hl['@boolean'] = { fg = c.orange_dark }
-- visual parents
hl.Type = { fg = c.orange_dark }

-- NEO TREE --
hl.NeoTreeNormal = { hl.NormalFloat }
hl.NeoTreeDimText = { fg = c.one_bg4 }
hl.NeoTreeDotfile = { hl.NeoTreeDimText }
hl.NeoTreeMessage = { hl.NeoTreeDimText }
hl.NeoTreeTitleBar = { hl.NeoTreeDimText }

-- NEORD --
hl['@neorg.headings.1.title'] = { fg = c.purple }

-- TREESITTER CONTEXT --
hl.TreesitterContext = { hl.Visual }

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
hl.markdownH1 = { gui = nil }
hl.markdownTSPunctSpecial = { hl.Special }
hl.markdownTSStringEscape = { hl.SpecialKey }
hl.markdownTSTextReference = { hl.Identifier, hl.Ul }
hl.markdownTSEmphasis = { hl.Italic }
hl.markdownTSTitle = { hl.Statement }
hl.markdownTSLiteral = { hl.Type }
hl.markdownTSURI = { hl.SpecialComment }
hl.markdownUrl = { hl.markdownTSURI }
hl.markdownCode = { hl.markdownTSLiteral }
hl.markdownLinkText = { hl.markdownTSTextReference }
hl.markdownLinkTextDelimiter = { hl.Delimiter }

-- h.helpHyperTextEntry = { h.Special }
-- h.helpHyperTextJump = { h.Constant }
-- h.helpSpecial = { h.Type }
-- h.helpOption = { h.Constant }

-- GIT --
hl.GitSignsAdd = { fg = c.green_blue }
hl.GitSignsChange = { fg = c.cyan }
hl.GitSignsDelete = { fg = c.cyan }

hl.GitSignsAddLn = { hl.GitSignsAdd }
hl.GitSignsChangeLn = { hl.GitSignsChange }
hl.GitSignsDeleteLn = { hl.GitSignsDelete }

hl.GitSignsAddPreview = { fg = c.blue_darkest, bg = hl.GitSignsAdd.fg }
hl.GitSignsChangePreview = { fg = c.blue_darkest, bg = hl.GitSignsChange.fg }
hl.GitSignsDeletePreview = { fg = c.blue_darkest, bg = hl.GitSignsDelete.fg }

hl.GitGutterAdd = { hl.GitSignsAdd }
hl.GitGutterChange = { hl.GitSignsChange }
hl.GitGutterDelete = { hl.GitSignsDelete }

hl.DiffAdd = { bg = '#223233' }
hl.DiffChange = { bg = '#223233' }
hl.DiffText = { bg = hl.Visual.bg }
hl.DiffDelete = { bg = '#321911', fg = '#321911' }

-- NOTIFY --
hl.NotifyINFOBody = { hl.NormalFloat }
hl.NotifyWARNBody = { hl.NormalFloat }
hl.NotifyERRORBody = { hl.NormalFloat }
hl.NotifyDEBUGBody = { hl.NormalFloat }
hl.NotifyTRACEBody = { hl.NormalFloat }

hl.NotifyINFOTitle = { fg = c.green_tea }
hl.NotifyINFOIcon = { hl.NotifyINFOTitle }
hl.NotifyErrorTitle = { fg = c.red }
hl.NotifyErrorIcon = { hl.NotifyErrorTitle }

-- hl.NotifyDEBUGTitle = { fg = c.red }
-- hl.NotifyINFOTitle29 = { fg = c.red }
-- hl.NotifyINFOTitle30 = { fg = c.red }

hl.NotifyINFOBorder = { fg = hl.NormalFloat.bg, bg = hl.NormalFloat.bg }
hl.NotifyWARNBorder = { hl.NotifyINFOBorder }
hl.NotifyERRORBorder = { hl.NotifyINFOBorder }
hl.NotifyDEBUGBorder = { hl.NotifyINFOBorder }
hl.NotifyTRACEBorder = { hl.NotifyINFOBorder }

-- INDENT --
hl.IndentBlanklineChar = { fg = c.blue_darkest }
hl.IndentBlanklineContextChar = { fg = c.one_bg3 }

-- TELESCOPE --
hl.TelescopeNormal = { fg = c.fg, bg = hl.NormalFloat.bg }
hl.TelescopeSelection = { bg = hl.Visual.bg }
hl.TelescopeMatching = { fg = c.red, hl.Bold }
hl.TelescopeBorder = { fg = hl.NormalFloat.bg, bg = hl.NormalFloat.bg }

C = c.gray_blue
hl.TelescopeSelectionCaret = { hl.TelescopeSelection, fg = C }
hl.TelescopePromptPrefix = { fg = C }
hl.TelescopePromptCounter = { fg = C }
hl.TelescopePromptTitle = { fg = C }

C = c.nord_gray_2
hl.TelescopePromptNormal = { bg = C }
hl.TelescopePromptBorder = { fg = C, bg = C }

-- SNEAK --
hl.Sneak = { hl.Search }
hl.SneakLabel = { hl.WildMenu }
hl.SneakLabelMask = { bg = c.yellow, fg = c.yellow }

-- LIGHTSPEED --
hl.LightspeedLabelOverlapped = { fg = c.yellow, hl.Ul }
hl.LightspeedLabelDistantOverlapped = { fg = c.orange, hl.Ul }
hl.LightspeedOneCharMatch = { hl.SneakLabel, hl.Bold }
hl.LightspeedMaskedChar = { hl.Conceal }
hl.LightspeedUnlabeledMatch = { hl.Bold }
hl.LightspeedPendingOpArea = { hl.SneakLabel }
hl.LightspeedPendingChangeOpArea = { fg = c.yellow }
hl.LightspeedGreyWash = { fg = hl.Comment.fg }

-- HOP --
C = c.yellow
hl.HopNextKey = { fg = c.purple }
hl.HopNextKey1 = { fg = c.green_tea }
hl.HopNextKey2 = { fg = c.purple }
hl.HopUnmatched = { fg = '#445577' }

-- FIDGET --
C = c.gray
hl.FidgetTask = { fg = C }
hl.FidgetTitle = { fg = C }

hl.BufferCurrent = { hl.TabLineSel }
hl.BufferVisible = { fg = hl.StatusLineNC.fg }
hl.BufferVisibleSign = { fg = hl.StatusLineNC.fg }
hl.BufferVisibleIndex = { fg = hl.StatusLineNC.fg }

-- NVIM TREE --
hl.NvimTreeNormal = { fg = nil, bg = nil }
hl.NvimTreeVertSplit = { fg = nil }
hl.NvimTreeCursorLine = { hl.CursorLine }
hl.NvimTreeCursorColumn = { hl.NvimTreeCursorLine }
hl.NvimTreeRootFolder = { fg = c.red, hl.Bold }
hl.NvimTreeSymlink = { fg = c.red }
hl.NvimTreeGitDirty = { hl.diffChanged }
hl.NvimTreeGitNew = { hl.diffAdded }
hl.NvimTreeGitDeleted = { hl.diffRemoved }
hl.NvimTreeExecFile = { fg = c.fg }
hl.NvimTreeSpecialFile = { fg = c.fg, gui = nil }

-- CMP --
hl.CmpItemAbbr = { fg = c.fg }
hl.CmpItemAbbrDeprecated = { fg = c.orange }
hl.CmpItemAbbrMatch = { fg = c.green_tea, hl.Bold }
hl.CmpItemAbbrMatchFuzzy = { fg = c.green_tea, hl.Bold }
hl.CmpItemKind = { fg = c.gray }
hl.CmpItemMenu = { fg = c.gray }
hl.CmpItemMenuDefault = { hl.NormalFloat }

hl.NnnNormal = { hl.NvimTreeNormal }
hl.NnnNormalNC = { hl.NnnNormal }


-- HIGHLIGHT --

local function remove_from_table(table, target_key)
  local new_table = {}

  for key, value in pairs(table) do
    if key ~= target_key then
      new_table[key] = value
    end
  end

  return new_table
end

local function flat(options)
  local need_repeat = false

  for key, value in pairs(options) do
    if is_table(value) then
      options = merge_tables {
        value,
        remove_from_table(options, key),
      }

      need_repeat = true
    end
  end

  if (need_repeat) then
    return flat(options)
  else
    return options
  end
end

local function highlight(list)
  for group, options in pairs(list) do
    local flat_options = flat(options)

    for key, value in pairs(options) do
      options[key] = value or 'NONE'
    end

    vim.api.nvim_set_hl(0, group, flat_options)
  end
end

highlight(hl)
