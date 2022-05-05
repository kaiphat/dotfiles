vim.api.nvim_create_autocmd('BufReadPost',  {
  callback = function()
    if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
      vim.fn.setpos('.', vim.fn.getpos("'\""))
      vim.api.nvim_feedkeys('zz', 'n', true)
    end 
  end 
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() 
    vim.highlight.on_yank { timeout = 700 } 
  end
})

