local g = vim.g
local o = vim.opt

if g.neovide then
  o.guifont = 'JetBrainsMono Nerd Font:h9'

  g.neovide_cursor_animation_length = 0.13
  g.neovide_background_color = '#ff0000'
  g.transparency = 0.8
  g.neovide_transparency = 0.8
  g.neovide_remember_window_size = true
  g.neovide_fullscreen = false
end
