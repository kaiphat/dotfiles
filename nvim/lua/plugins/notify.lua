local notify = load 'notify'
if not notify then return end

notify.setup {
  max_width = 60,
  minimum_width = 30,
  fps = 60,
  on_open = function(win)
    vim.wo[win].wrap = true
    vim.api.nvim_win_set_option(win, 'wrap', true)
  end,
  stages = 'fade',
  render = 'minimal',
}

vim.notify = notify
