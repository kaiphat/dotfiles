vim.cmd [[command! Squeeze %s/\v(\n\n)\n+/\1/e]]
vim.cmd [[command! DeleteEmptyLines %s/\v(\n)\n+/\1/e]]
