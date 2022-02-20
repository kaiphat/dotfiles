local M = {}

M.getCurrentPath = function()
  return vim.fn.expand('%:p:h')
end

M.splitString = function(str, delimiter)
    local result = {}
    for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

M.map = function(mode, keys, cmd, opt)
  opt = opt or { noremap = true, silent = true }
  vim.api.nvim_set_keymap(mode, keys, cmd, opt)
end

return M
