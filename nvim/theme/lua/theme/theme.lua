local lush = require 'lush'
local hsl = lush.hsl

local colors = {
  white         = '#abb2bf',
  light_white   = '#ceceef',
  red           = '#DE8C92',
  nord_blue     = '#81A1C1',
  sun           = '#EBCB8B',
  orange        = '#fca2aa',
  cyan2         = '#91b9f1',
  light_blue    = '#9398cf',
  lightest_blue = '#404060',
  bg            = '#2d3139',
  mono_1        = '#787C99',
  mono_3        = '#5c6370',
  theme_7       = '#43d08a',
  theme_9       = '#282c34',
  theme_13      = '#2c323c',
  line          = '#333944',
  pink          = '#ff75a0',
  p             = '#c96090',
  green         = '#7eca9c',
  green2        = '#4ea0bc',
  green2        = '#e79382',
  nord_blue     = '#81A1C1',
  blue          = '#61afef',
  sun           = '#EBCB8B',
  dark_purple   = '#b892c7',
  teal          = '#519ABA',
  orange        = '#fca2aa',
  cyan          = '#a3b8ef',
  cyan_2        = '#bcddee',
  light_blue    = '#9398cf',
  lightest_blue = '#404060',
  brackets      = '#757595',
  a             = '#536162',

  red           = '#e06c75',
  green         = '#56b6c2',
  green         = '#7eca9c',
  g2            = '#66A5AD',
  gray          = '#6e88a6',
  brown         = '#c8ae9d',
  select        = '#ffcc66',
  nordGray1     = '#4c566a',
  nordGray2     = '#3b4252',
  nordWhite     = '#d8dee9',
  tokyoYellow   = '#ffcc66',

  prettyGray    = '#2b2f3a',
  prettyWhite   = '#dae0ee',
  prettyRed     = '#9e6e7a',

  dark          = '#202837'
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

    select      = colors.prettyRed,
    brackets    = colors.brackets,
    method      = colors.light_blue.da(15),
    constructor = colors.brown,
    property    = colors.gray,
    string      = colors.pink,
    statement   = colors.nord_blue,

    lineMain    = colors.nordGray1,
    lineBg      = colors.nordGray2,
    lineFg      = colors.nordWhite,
    line = colors.line
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

      CursorLine                       { fg = none, bg = c.line },
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
      NormalFloat                      { bg = c.bg.li(10) },
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

      Number                           { fg = c.fg, gui = s.i },
      Boolean                          { Number },

      Identifier                       { fg = c.fg },
      Function                         { fg = c.fg },

      Statement                        { fg = c.statement, gui = s.b },

      PreProc                          { Statement },

      Type                             { fg = c.bg.li(58) },

      Special                          { fg = c.leaf, gui = s.b },

      Delimiter                        { fg = c.bg.li(47) },
      SpecialComment                   { Comment, gui = none },

      LspReferenceText                 { Visual },
      LspReferenceRead                 { Visual },
      LspReferenceWrite                { Visual },
      LspCodeLens                      { LineNr },

      DiagnosticError                  { Error },
      DiagnosticWarn                   { WarningMsg },
      DiagnosticInfo                   { fg = c.water },
      DiagnosticHint                   { fg = c.blossom },

      DiagnosticSignError              { SignColumn, fg = DiagnosticError.fg },
      DiagnosticSignWarn               { SignColumn, fg = DiagnosticWarn.fg },
      DiagnosticSignInfo               { SignColumn, fg = DiagnosticInfo.fg },
      DiagnosticSignHint               { SignColumn, fg = DiagnosticHint.fg },

      DiagnosticVirtualTextError       { fg = c.fg.da(40), bg = none },
      DiagnosticVirtualTextWarn        { DiagnosticWarn, bg = DiagnosticWarn.fg.saturation(8).li(c.bg.l + 4) },
      DiagnosticVirtualTextInfo        { DiagnosticInfo, bg = DiagnosticInfo.fg.saturation(8).li(c.bg.l + 4) },
      DiagnosticVirtualTextHint        { DiagnosticHint, bg = DiagnosticHint.fg.saturation(8).li(c.bg.l + 4) },

      DiagnosticUnderlineWarn          { gui = s.ul },
      DiagnosticUnderlineInfo          { gui = s.ul },
      DiagnosticUnderlineHint          { gui = s.ul },
      DiagnosticUnderlineError         { gui = s.ul },

      TSConstructor                    { fg = c.constructor },
      TSConstant                       { Identifier, gui = s.b },
      TSConstBuiltin                   { Number },
      TSConstMacro                     { Number },
      TSMethod                         { fg = c.method, gui = s.b },
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

      TelescopeSelection               { CursorLine },
      TelescopeSelectionCaret          { TelescopeSelection, fg = c.rose },
      TelescopeMatching                { fg = c.blossom, gui = s.b },
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

      CocErrorSign                     { DiagnosticSignError },
      CocWarningSign                   { DiagnosticSignWarn },
      CocInfoSign                      { DiagnosticSignInfo },
      CocHintSign                      { DiagnosticSignHint },
      CocErrorHighlight                { DiagnosticUnderlineError },
      CocWarningHighlight              { DiagnosticUnderlineWarn },
      CocInfoHighlight                 { DiagnosticUnderlineInfo },
      CocHintHighlight                 { DiagnosticUnderlineHint },
      CocErrorVirtualText              { DiagnosticVirtualTextError },
      CocWarningVitualText             { DiagnosticVirtualTextWarn },
      CocSelectedText                  { SpellBad },
      CocCodeLens                      { LineNr },
      CocMarkdownLink                  { fg = c.sky, gui = s.ul },

      NeogitNotificationError          { DiagnosticError },
      NeogitNotificationWarning        { DiagnosticWarn },
      NeogitNotificationInfo           { DiagnosticInfo },

      NeogitDiffContextHighlight       { CursorLine },
      NeogitDiffDeleteHighlight        { DiffDelete },
      NeogitDiffAddHighlight           { DiffAdd },
      NeogitHunkHeader                 { LineNr },
      NeogitHunkHeaderHighlight        { CursorLine, fg = c.fg, gui = s.b },

      WhichKey                         { Statement },
      WhichKeyGroup                    { Special },
      WhichKeySeparator                { LineNr },
      WhichKeyValue                    { Constant },

      TroubleNormal                    { Function },
      TroubleText                      { Function },
      TroubleSource                    { Constant },

      NvimTreeNormal                   { Normal, fg = none, bg = none },
      NvimTreeVertSplit                { fg = none },
      NvimTreeCursorLine               { bg = StatusLineNC.bg },
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
    }
end)
