local lush = load 'lush'
if not lush then return end

local hsl = lush.hsl

local pastel = {
   white = "#b5bcc9",
   darker_black = "#10171e",
   black = "#131a21", --  nvim bg
   black2 = "#1a2128",
   one_bg = "#1e252c",
   one_bg2 = "#2a3138",
   one_bg3 = "#363d44",
   grey = "#363d44",
   grey_fg = "#4e555c",
   grey_fg2 = "#51585f",
   light_grey = "#545b62",
   red = "#ef8891",
   baby_pink = "#fca2aa",
   pink = "#fca2af",
   line = "#272e35", -- for lines like vertsplit
   green = "#9fe8c3",
   vibrant_green = "#9ce5c0",
   blue = "#99aee5",
   nord_blue = "#9aa8cf",
   yellow = "#fbdf90",
   sun = "#fbdf9a",
   purple = "#c2a2e3",
   dark_purple = "#b696d7",
   teal = "#92dbb6",
   orange = "#EDA685",
   cyan = "#b5c3ea",
   statusline_bg = "#181f26",
   lightbg = "#222930",
   pmenu_bg = "#ef8891",
   folder_bg = "#99aee5",
}

local pastel_16 = {
   base0A = "#f5d595",
   base04 = "#4f565d",
   base07 = "#b5bcc9",
   base05 = "#ced4df",
   base0E = "#c2a2e3",
   base0D = "#a3b8ef",
   base0C = "#abb9e0",
   base0B = "#9ce5c0",
   base02 = "#31383f",
   base0F = "#e88e9b",
   base03 = "#40474e",
   base08 = "#ef8891",
   base01 = "#2c333a",
   base00 = "#131a21",
   base09 = "#EDA685",
   base06 = "#d3d9e4",
}

local colors = {
  white         = '#abb2bf',
  white = "#b5bcc9",
  light_white   = '#ceceef',
  red           = '#DE8C92',
  nord_blue     = '#81A1C1',
  sun           = '#EBCB8B',
  cyan2         = '#91b9f1',
  light_blue    = '#9398cf',
  lightest_blue = '#404060',
  bg            = '#2d3139',
  mono_1        = '#787C99',
  mono_3        = '#5c6370',
  theme_7       = '#43d08a',
  theme_9       = '#282c34',
  theme_13      = '#2c323c',
  line          = '#40474e',
  pink          = '#ff75a0',
  p             = '#c96090',
  green         = '#7eca9c',
  green2        = '#4ea0bc',
  nord_blue     = '#81A1C1',
  blue          = '#61afef',
  sun           = '#EBCB8B',
  teal          = '#519ABA',
  orange        = '#fca2aa',
  orange2       = '#e79382',
  cyan          = '#a3b8ef',
  cyan_2        = '#bcddee',
  light_blue    = '#9398cf',
  purple        = "#c2a2e3",
  dark_purple   = "#b696d7",
  dark_purple   = "#b892c7",
  lightest_blue = '#404060',
  brackets      = '#757595',
  a             = '#536162',

  red           = '#e06c75',
  red           = "#ef8891",
  green         = '#56b6c2',
  green         = '#7eca9c',
  g2            = '#66A5AD',
  gray          = '#6e88a6',
  brown         = '#c8ae9d',
  select        = '#fbdf9a',
  nordGray1     = '#4c566a',
  nordGray2     = '#3b4252',
  nordWhite     = '#d8dee9',
  tokyoYellow   = '#ffcc66',

  prettyGray    = '#2b2f3a',
  prettyWhite   = '#dae0ee',
  prettyRed     = '#fca2af',
  greenTea      = '#9CC4B2',

  dark          = '#202837',
  dark_gray     = '#788aa3'
}

for key, value in pairs(colors) do
  colors[key] = hsl(value)
end

local none = 'NONE'

local s = {
  b             = 'bold',
  i             = 'italic',
  r             = 'reverse',
  ul            = 'underline',
  uc            = 'undercurl',
}

local themes = {
  theme = {
    bg          = colors.dark,
    fg          = colors.prettyWhite.da(10),
    secondFg    = colors.lightest_blue,
    thirdFg     = colors.cyan,

    rose        = colors.light_blue,
    blossom     = colors.select,
    leaf        = colors.g2,
    wood        = colors.red,
    water       = colors.red,
    sky         = colors.orange,
    sun         = colors.g2,

    select      = colors.prettyRed,
    brackets    = colors.brackets,
    method      = colors.light_blue.da(15),
    constructor = colors.brown,
    property    = colors.gray,
    string      = colors.greenTea,
    statement   = colors.nord_blue,
    number      = colors.red,
    bool        = colors.orange2,
    field       = colors.dark_gray,

    lineMain    = colors.nordGray1,
    lineBg      = colors.nordGray2,
    lineFg      = colors.nordWhite,
    line        = colors.line,
  }
}

local c = themes.theme

return lush(function()
  return {
      Normal                           { fg = c.fg, bg = c.bg },

      Underlined                       { gui = s.ul },
      Bold                             { gui = s.b },
      Italic                           { gui = s.i },
      Error                            { fg = c.rose },
      ErrorMsg                         { Error },
      WarningMsg                       { fg = c.wood },
      Comment                          { fg = c.bg.li(38).de(24), gui = s.i },
      Conceal                          { fg = c.water, gui = s.b },
      Cursor                           { bg = c.fg.li(20), fg = c.bg },
      lCursor                          { Cursor, bg = Cursor.bg.da(35)  },
      TermCursor                       { Cursor },
      TermCursorNC                     { lCursor },
      CursorLine                       { fg = none, bg = none },
      CursorColumn                     { CursorLine },
      ColorColumn                      { bg = c.wood.saturation(46).lightness(c.bg.l + 18) },
      DiffAdd                          { bg = c.leaf.saturation(50).lightness(c.bg.l + 8) },
      DiffChange                       { bg = c.water.saturation(50).lightness(c.bg.l + 8) },
      DiffDelete                       { bg = c.rose.saturation(30).lightness(c.bg.l + 8) },
      DiffText                         { bg = c.water.saturation(50).lightness(c.bg.l + 20), fg = c.fg },
      LineNr                           { fg = c.bg.li(35), bg = none },
      SignColumn                       { LineNr },
      FoldColumn                       { LineNr, gui = s.b },
      Folded                           { bg = c.bg.li(14), fg = c.bg.li(64) },
      CursorLineNr                     { LineNr, fg = c.fg, gui = s.b },
      MoreMsg                          { fg = c.leaf, gui = s.b },
      NormalFloat                      { bg = none },
      FloatBorder                      { fg = c.bg.li(46), bg = none },
      Pmenu                            { fg = c.fg.da(20), bg = c.bg.li(10) },
      PmenuSel                         { fg = c.secondFg, bg = c.select },
      PmenuSbar                        { bg = c.bg.li(32) },
      PmenuThumb                       { bg = c.bg.li(50) },
      Search                           { fg = c.secondFg, bg = c.select },
      IncSearch                        { fg = c.secondFg, bg = c.select },
      MatchParen                       { fg = c.select },
      SpellBad                         { fg = Error.fg.de(30), gui = s.uc, guisp = Error.fg },
      SpellCap                         { SpellBad, guisp = Error.fg.da(10) },
      SpellLocal                       { SpellCap },
      SpellRare                        { SpellBad, guisp = c.wood },
      StatusLine                       { bg = c.secondFg, fg = c.fg },
      StatusLineNC                     { bg = c.secondFg, fg = c.fg.li(28) },
      TabLine                          { fg  = c.secondFg, bg = c.rose },
      TabLineSel                       { fg  = c.secondFg, bg = c.thirdFg },
      TabLineFill                      { fg  = c.thirdFg, bg = none },
      VertSplit                        { fg = c.secondFg, bg = none },
      Visual                           { fg = none, bg = c.line },
      NonText                          { fg = c.bg.li(30) },
      SpecialKey                       { NonText, gui = s.i },
      Whitespace                       { NonText },
      EndOfBuffer                      { NonText },
      WildMenu                         { bg = c.blossom, fg = c.bg },
      Directory                        { fg = c.fg.da(15), gui = none },
      Question                         { MoreMsg },
      Title                            { fg = c.fg, gui = s.b },
      Constant                         { fg = c.wood, gui = s.i },
      String                           { fg = c.string, gui = none },
      Number                           { fg = c.number },
      Boolean                          { Number },
      Identifier                       { fg = c.fg },
      Function                         { fg = c.fg },
      Statement                        { fg = c.statement, gui = s.b },
      PreProc                          { Statement },
      Special                          { fg = c.leaf, gui = s.b },
      Delimiter                        { fg = c.bg.li(47) },
      SpecialComment                   { Comment, gui = none },

      LspReferenceText                 { bg = c.bg.li(10) },
      LspReferenceRead                 { LspReferenceText },
      LspReferenceWrite                { LspReferenceText },
      LspCodeLens                      { LineNr },

      DiagnosticError                  { WarningMsg },
      DiagnosticWarn                   { WarningMsg },
      DiagnosticInfo                   { fg = c.water },
      DiagnosticHint                   { fg = c.blossom },

      DiagnosticSignError              { SignColumn, fg = DiagnosticError.fg },
      DiagnosticSignWarn               { SignColumn, fg = DiagnosticWarn.fg },
      DiagnosticSignInfo               { SignColumn, fg = DiagnosticInfo.fg },
      DiagnosticSignHint               { SignColumn, fg = DiagnosticHint.fg },

      DiagnosticVirtualTextError       { DiagnosticError, bg = none }, 
      DiagnosticVirtualTextWarn        { DiagnosticError, bg = none },
      DiagnosticVirtualTextInfo        { DiagnosticError, bg = none },
      DiagnosticVirtualTextHint        { DiagnosticError, bg = none },

      DiagnosticUnderlineWarn          { gui = s.uc },
      DiagnosticUnderlineInfo          { gui = s.uc },
      DiagnosticUnderlineHint          { gui = s.uc },
      DiagnosticUnderlineError         { gui = s.uc },

      TSConstructor                    { fg = c.constructor },
      TSType                           { fg = c.sun },
      Type                             { TSType },
      TSConstant                       { Identifier, gui = s.b },
      TSConstBuiltin                   { Number },
      TSConstMacro                     { Number },
      TSMethod                         { fg = c.method, gui = s.b },
      TSField                          { fg = c.field },
      TSFunction                       { TSMethod },
      TSNamespace                      { Special },
      TSProperty                       { fg = c.property },
      TSPunctBracket                   { fg = c.brackets, gui = s.i },
      TSPunctDelimiter                 { fg = c.brackets, gui = s.i },
      TSPunctSpecial                   { fg = c.brackets, gui = s.i },
      TSStringEscape                   { fg  = c.red, bg = none },
      TSVariable                       { Identifier },
      TSVariableBuiltin                { Number },
      TSTag                            { Special },
      TSEmphasis                       { Italic },
      TSUnderline                      { Underlined },
      TSStrong                         { Bold },
      TSLiteral                        { fg  = c.red },
      TSNote                           { DiagnosticInfo },
      TSWarning                        { WarningMsg },
      TSDanger                         { Error },
      TSNumber                         { fg = c.number },
      TSBoolean                        { fg = c.bool },

      TreesitterContext                { bg = c.bg.li(10).de(10) },

      markdownH1                       { gui = none },
      markdownTSPunctSpecial           { Special },
      markdownTSStringEscape           { SpecialKey },
      markdownTSTextReference          { Identifier, gui = s.ul },
      markdownTSEmphasis               { Italic },
      markdownTSTitle                  { Statement },
      markdownTSLiteral                { Type },
      markdownTSURI                    { SpecialComment },

      diffAdded                        { fg = c.leaf },
      diffRemoved                      { fg = c.rose },
      diffChanged                      { fg = c.water },
      diffOldFile                      { fg = c.rose, gui = s.i },
      diffNewFile                      { fg = c.leaf, gui = s.i },
      diffFile                         { fg = c.wood, gui = s.b },
      diffLine                         { fg = c.blossom, gui = s.b },
      diffIndexLine                    { fg = c.wood },

      gitcommitOverflow                { WarningMsg },

      markdownUrl                      { markdownTSURI },
      markdownCode                     { markdownTSLiteral },
      markdownLinkText                 { markdownTSTextReference },
      markdownLinkTextDelimiter        { Delimiter },

      helpHyperTextEntry               { Special },
      helpHyperTextJump                { Constant },
      helpSpecial                      { Type },
      helpOption                       { Constant },

      GitSignsAdd                      { SignColumn, fg = c.leaf },
      GitSignsChange                   { SignColumn, fg = c.water },
      GitSignsDelete                   { SignColumn, fg = c.rose },

      GitGutterAdd                     { GitSignsAdd },
      GitGutterChange                  { GitSignsChange },
      GitGutterDelete                  { GitSignsDelete },

      IndentBlanklineChar              { fg = c.bg.li(14).de(22) },
      IndentBlanklineContextChar       { fg  = c.thirdFg.da(40).de(50), bg = none },

      TelescopeNormal                  { fg = c.fg.da(10) },
      TelescopeSelection               { bg = c.line },
      TelescopeSelectionCaret          { TelescopeSelection, fg = c.rose },
      TelescopeMatching                { fg = c.select, gui = s.b },
      TelescopeBorder                  { fg = FloatBorder.fg },
      TelescopePromptPrefix            { TelescopeBorder },

      Sneak                            { Search },
      SneakLabel                       { WildMenu },
      SneakLabelMask                   { bg = c.blossom, fg = c.blossom },

      LightspeedLabelOverlapped        { fg = c.blossom, gui = s.ul },
      LightspeedLabelDistantOverlapped { fg = c.sky, gui = s.ul },
      LightspeedOneCharMatch           { SneakLabel, gui = s.b },
      LightspeedMaskedChar             { Conceal },
      LightspeedUnlabeledMatch         { Bold },
      LightspeedPendingOpArea          { SneakLabel },
      LightspeedPendingChangeOpArea    { fg = c.blossom },
      LightspeedGreyWash               { fg = Comment.fg },

      HopNextKey                       { fg = c.constructor },
      HopNextKey1                      { fg = c.constructor },
      HopNextKey2                      { fg = c.constructor },
      HopUnmatched                     { LightspeedGreyWash },

      BufferCurrent                    { TabLineSel },
      BufferVisible                    { fg = StatusLineNC.fg },
      BufferVisibleSign                { fg = StatusLineNC.fg },
      BufferVisibleIndex               { fg = StatusLineNC.fg },

      NvimTreeNormal                   { Normal, fg = none, bg = none },
      NvimTreeVertSplit                { fg = none },
      NvimTreeCursorLine               { CursorLine },
      NvimTreeCursorColumn             { NvimTreeCursorLine	},
      NvimTreeRootFolder               { fg = c.water, gui = s.b },
      NvimTreeSymlink                  { fg = c.water },
      NvimTreeGitDirty                 { diffChanged },
      NvimTreeGitNew                   { diffAdded },
      NvimTreeGitDeleted               { diffRemoved },
      NvimTreeExecFile                 { fg = c.fg },
      NvimTreeSpecialFile              { fg = c.fg, gui = none },

      CmpItemAbbr                      { fg = c.fg.da(10) },
      CmpItemAbbrDeprecated            { fg = c.sky },
      CmpItemAbbrMatch                 { fg = c.string, gui = s.b  },
      CmpItemAbbrMatchFuzzy            { fg = c.string, gui = s.b },
      CmpItemKind                      { fg = c.property },
      CmpItemMenu                      { fg = c.property },

      NnnNormal                        { NvimTreeNormal },
      NnnNormalNC                      { NnnNormal },

      -- LightspeedLabel                  { fg = c.purple, gui = s.ul },
      -- LightspeedShortcut               { bg = c.purple },
    }
end)
