local fn = vim.fn

vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
  group = vim.api.nvim_create_augroup('LastPosition', {}),
  callback = function()
    local test_line_data = vim.api.nvim_buf_get_mark(0, '\"')
    local test_line = test_line_data[1]
    local last_line = vim.api.nvim_buf_line_count(0)

    if test_line > 0 and test_line <= last_line then
      vim.api.nvim_win_set_cursor(0, test_line_data)
    end
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() 
    vim.highlight.on_yank { timeout = 700 } 
  end
})

