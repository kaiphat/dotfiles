local g = vim.g
local o = vim.opt

-- local size = '15.9'
local size = '13.5'

local fonts = {
  iosevka = 'Iosevka',
  jetBrains = 'JetBrainsMono NF',
  caskadia = 'CaskaydiaCovePL NF',
  fantasque = 'FantasqueSansMono NF',
  firaCode = 'FiraCode NF'
}

o.guifont = fonts.firaCode..':h'..size

g.neovide_fullscreen = true
g.neovide_refresh_rate = 100
g.neovide_cursor_antialiasing = true
g.neovide_remember_window_size = true
