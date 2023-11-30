vim.cmd [[command! Squeeze %s/\v(\n\n)\n+/\1/e]]
vim.cmd [[command! DeleteEmptyLines %s/\v(\n)\n+/\1/e]]

_G.delete_spacec = function ()
    vim.cmd [[silent! s/\S\@<=\s\+/ /g]]
    vim.cmd [[silent! nohl]]
end

vim.cmd [[command! DeleteSpaces lua delete_spacec()]]
