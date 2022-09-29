--   white = '#b5bcc9',
--   darker_black = '#10171e',
--   black = '#131a21', --  nvim bg
--   black2 = '#1a2128',
--   one_bg = '#1e252c',
--   one_bg2 = '#2a3138',
--   one_bg3 = '#363d44',
--   grey_fg = '#4e555c',
--   grey_fg2 = '#51585f',
--   light_grey = '#545b62',
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

local c = {
  bg = '#202837',
  fg = '#b4b6d7',
  one_bg2 = '#2a3143',
  one_bg3 = '#405879',

  cyan         = '#a3b8ef',
  blue_gray    = '#9398cf',
  blue_nord    = '#81A1C1',
  blue_darkest = '#404060',
  select       = '#fbdf9a',
  red          = '#fc828f',
  red_dark     = '#aa6666',
  green_blue   = '#66A5AD',
  green_tea    = '#9CC4B2',
  brown        = '#c8ae9d',
  orange       = '#fca2aa',
  orange_dark  = '#EDA685',
  nord_gray_2  = '#3b4252',
  gray         = '#6e88a6',
  gray_blue    = '#788aa3',
}

local h = {}

-- BASE --

h.It   = { italic = true }
h.Bold = { bold = true }
h.Ul   = { underline = true }
h.Uc   = { undercurl = true }

-- GENERAL --

h.Normal = { fg = c.fg, bg = c.bg }
h.Underlined = { h.Ul }
h.Bold = { h.Bold, }
h.Italic = { h.It }
h.Error = { fg = c.blue_gray }
h.ErrorMsg = { h.Error }
h.WarningMsg = { fg = c.red_dark }
h.Comment = { fg = c.gray_blue, h.It }
h.Conceal = { fg = c.red, h.Bold }
h.Cursor = { fg = nil, bg = c.one_bg3 }
-- h.lCursor = { h.Cursor }
-- h.TermCursor = { h.Cursor }
-- h.TermCursorNC = { h.lCursor }
-- h.CursorColumn = { h.CursorLine }
h.CursorLine = { fg = nil, bg = nil }
h.ColorColumn = { bg = c.red }
h.DiffAdd = { bg = c.green_blue }
h.DiffChange = { bg = c.red }
h.DiffDelete = { bg = c.blue_gray }
h.DiffText = { bg = c.red, fg = c.fg }
h.LineNr = { fg = c.bg, bg = nil }
h.SignColumn = { h.LineNr }
h.FoldColumn = { h.LineNr, h.Bold }
h.Folded = { bg = c.bg, fg = c.bg }
h.CursorLineNr = { h.LineNr, fg = c.fg, h.Bold }
h.MoreMsg = { fg = c.green_blue }
h.NormalFloat = { bg = c.one_bg2 }
h.FloatBorder = { fg = c.gray_blue, bg = nil }
h.FloatShadow = { bg = nil }
h.FloatShadowThrough = { bg = nil }
h.Pmenu = { fg = c.fg, bg = c.bg }
h.PmenuSel = { fg = c.blue_darkest, bg = c.red }
h.PmenuSbar = { bg = c.bg }
h.PmenuThumb = { bg = c.bg }
h.Search = { fg = c.blue_darkest, bg = c.red }
h.IncSearch = { fg = c.blue_darkest, bg = c.red }
h.MatchParen = { fg = c.red }
h.StatusLine = { bg = nil, fg = nil, gui = nil }
h.StatusLineNC = { bg = c.blue_darkest, fg = c.fg }
h.TabLine = { fg = c.blue_darkest, bg = c.blue_gray }
h.TabLineSel = { fg = c.blue_darkest, bg = c.cyan }
h.TabLineFill = { fg = c.cyan, bg = nil }
h.VertSplit = { fg = c.blue_darkest, bg = nil }
h.Visual = { fg = nil, bg = c.one_bg3 }
h.NonText = { fg = c.bg }
h.SpecialKey = { h.NonText, h.It }
h.Whitespace = { h.NonText }
h.EndOfBuffer = { h.NonText }
h.WildMenu = { bg = c.select, fg = c.bg }
h.Directory = { fg = c.fg, gui = nil }
h.Question = { h.MoreMsg }
h.Title = { fg = c.fg, h.Bold }
h.Constant = { fg = c.red, h.It }
h.String = { fg = c.green_tea, gui = nil }
h.Number = { fg = c.red }
h.Boolean = { h.Number }
h.Identifier = { fg = c.fg }
h.Function = { fg = c.fg }
h.Statement = { fg = c.blue_nord, h.Bold }
h.PreProc = { h.Statement }
h.Special = { fg = c.green_blue, h.Bold }
h.Delimiter = { fg = c.gray_blue }
h.SpecialComment = { h.Comment, gui = nil }

h.LspReferenceText = { bg = h.Visual.bg }
h.LspReferenceRead = { h.LspReferenceText }
h.LspReferenceWrite = { h.LspReferenceText }
h.LspCodeLens = { h.LineNr }

h.DiagnosticError = { h.WarningMsg }
h.DiagnosticWarn = { h.WarningMsg }
h.DiagnosticInfo = { fg = c.red }
h.DiagnosticHint = { fg = c.select }

h.DiagnosticSignError = { h.SignColumn, fg = h.DiagnosticError.fg }
h.DiagnosticSignWarn = { h.SignColumn, fg = h.DiagnosticWarn.fg }
h.DiagnosticSignInfo = { h.SignColumn, fg = h.DiagnosticInfo.fg }
h.DiagnosticSignHint = { h.SignColumn, fg = h.DiagnosticHint.fg }

h.DiagnosticVirtualTextError = { h.DiagnosticError, bg = nil }
h.DiagnosticVirtualTextWarn = { h.DiagnosticVirtualTextError }
h.DiagnosticVirtualTextInfo = { h.DiagnosticVirtualTextError }
h.DiagnosticVirtualTextHint = { h.DiagnosticVirtualTextError }

h.DiagnosticUnderlineWarn = { h.Ul, sp = h.WarningMsg.fg }
h.DiagnosticUnderlineInfo = { h.DiagnosticUnderlineWarn }
h.DiagnosticUnderlineHint = { h.DiagnosticUnderlineWarn }
h.DiagnosticUnderlineError = { h.DiagnosticUnderlineWarn }

h.TSConstructor = { fg = c.brown }
h.TSType = { fg = c.green_blue }
h.Type = { h.TSType }
h.TSConstant = { h.Identifier, h.Bold }
h.TSConstBuiltin = { h.Number }
h.TSConstMacro = { h.Number }
h.TSMethod = { fg = c.blue_gray, h.Bold }
h.TSField = { fg = c.gray_blue }
h.TSFunction = { h.TSMethod }
h.TSNamespace = { h.Special }
h.TSProperty = { fg = c.gray }
h.TSPunctBracket = { fg = c.gray, h.It }
h.TSPunctDelimiter = { h.TSPunctBracket }
h.TSPunctSpecial = { h.TSPunctBracket }
h.TSStringEscape = { fg = c.red, bg = nil }
h.TSVariable = { h.Identifier }
h.TSVariableBuiltin = { h.Number }
h.TSTag = { h.Special }
h.TSEmphasis = { h.Italic }
h.TSUnderline = { h.Underlined }
h.TSStrong = { h.Bold }
h.TSLiteral = { fg = c.red }
h.TSNote = { h.DiagnosticInfo }
h.TSWarning = { h.WarningMsg }
h.TSDanger = { h.Error }
h.TSNumber = { fg = c.red }
h.TSBoolean = { fg = c.orange_dark }

h.TreesitterContext = { bg = c.nord_gray_2 }

h.markdownH1 = { gui = nil }
h.markdownTSPunctSpecial = { h.Special }
h.markdownTSStringEscape = { h.SpecialKey }
h.markdownTSTextReference = { h.Identifier, h.Ul }
h.markdownTSEmphasis = { h.Italic }
h.markdownTSTitle = { h.Statement }
h.markdownTSLiteral = { h.Type }
h.markdownTSURI = { h.SpecialComment }

h.diffAdded = { fg = c.green_blue }
h.diffRemoved = { fg = c.blue_gray }
h.diffChanged = { fg = c.red }
h.diffOldFile = { fg = c.blue_gray, h.It }
h.diffNewFile = { fg = c.green_blue, h.It }
h.diffFile = { fg = c.red, h.Bold }
h.diffLine = { fg = c.select, h.Bold }
h.diffIndexLine = { fg = c.red }

h.gitcommitOverflow = { h.WarningMsg }

h.markdownUrl = { h.markdownTSURI }
h.markdownCode = { h.markdownTSLiteral }
h.markdownLinkText = { h.markdownTSTextReference }
h.markdownLinkTextDelimiter = { h.Delimiter }

h.helpHyperTextEntry = { h.Special }
h.helpHyperTextJump = { h.Constant }
h.helpSpecial = { h.Type }
h.helpOption = { h.Constant }

h.GitSignsAdd = { h.SignColumn, fg = c.green_blue }
h.GitSignsChange = { h.SignColumn, fg = c.red }
h.GitSignsDelete = { h.SignColumn, fg = c.blue_gray }
h.GitGutterAdd = { h.GitSignsAdd }
h.GitGutterChange = { h.GitSignsChange }
h.GitGutterDelete = { h.GitSignsDelete }

h.IndentBlanklineChar = { fg = h.Visual.bg }
h.IndentBlanklineContextChar = { fg = c.blue_nord, bg = nil }

h.TelescopeNormal = { fg = c.fg }
h.TelescopeSelection = { bg = h.Visual.bg }
h.TelescopeSelectionCaret = { h.TelescopeSelection, fg = c.blue_gray }
h.TelescopeMatching = { fg = c.red, h.Bold }
h.TelescopeBorder = { fg = h.FloatBorder.fg }
h.TelescopePromptPrefix = { h.TelescopeBorder }

h.Sneak = { h.Search }
h.SneakLabel = { h.WildMenu }
h.SneakLabelMask = { bg = c.select, fg = c.select }

h.LightspeedLabelOverlapped = { fg = c.select, h.Ul }
h.LightspeedLabelDistantOverlapped = { fg = c.orange, h.Ul }
h.LightspeedOneCharMatch = { h.SneakLabel, h.Bold }
h.LightspeedMaskedChar = { h.Conceal }
h.LightspeedUnlabeledMatch = { h.Bold }
h.LightspeedPendingOpArea = { h.SneakLabel }
h.LightspeedPendingChangeOpArea = { fg = c.select }
h.LightspeedGreyWash = { fg = h.Comment.fg }

h.HopNextKey = { fg = c.brown }
h.HopNextKey1 = { fg = c.brown }
h.HopNextKey2 = { fg = c.brown }
h.HopUnmatched = { h.LightspeedGreyWash }

h.FidgetTask = { fg = c.gray }
h.FidgetTitle = { fg = c.gray }

h.BufferCurrent = { h.TabLineSel }
h.BufferVisible = { fg = h.StatusLineNC.fg }
h.BufferVisibleSign = { fg = h.StatusLineNC.fg }
h.BufferVisibleIndex = { fg = h.StatusLineNC.fg }

h.NvimTreeNormal = { fg = nil, bg = nil }
h.NvimTreeVertSplit = { fg = nil }
h.NvimTreeCursorLine = { h.CursorLine }
h.NvimTreeCursorColumn = { h.NvimTreeCursorLine }
h.NvimTreeRootFolder = { fg = c.red, h.Bold }
h.NvimTreeSymlink = { fg = c.red }
h.NvimTreeGitDirty = { h.diffChanged }
h.NvimTreeGitNew = { h.diffAdded }
h.NvimTreeGitDeleted = { h.diffRemoved }
h.NvimTreeExecFile = { fg = c.fg }
h.NvimTreeSpecialFile = { fg = c.fg, gui = nil }

h.CmpItemAbbr = { fg = c.fg }
h.CmpItemAbbrDeprecated = { fg = c.orange }
h.CmpItemAbbrMatch = { fg = c.green_tea, h.Bold }
h.CmpItemAbbrMatchFuzzy = { fg = c.green_tea, h.Bold }
h.CmpItemKind = { fg = c.gray }
h.CmpItemMenu = { fg = c.gray }

h.NnnNormal = { h.NvimTreeNormal }
h.NnnNormalNC = { h.NnnNormal }


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
        remove_from_table(options, key),
        value
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

local function hl(list)
  for group, options in pairs(list) do
    local flat_options = flat(options)

    for key, value in pairs(options) do
      options[key] = value or 'NONE'
    end

    vim.api.nvim_set_hl(0, group, flat_options)
  end
end

hl(h)
