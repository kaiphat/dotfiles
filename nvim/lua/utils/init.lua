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

M.map = function(mode, keys, cmd, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, keys, cmd, opts)
end

M.snake = function(s)
  return s:gsub('%f[^%l]%u', '_%1'):gsub('%f[^%a]%d', '_%1'):gsub('%f[^%d]%a', '_%1'):gsub('(%u)(%u%l)', '%1_%2'):upper()
end

M.camel = function(s)
  s = s:lower()
  return string.gsub(s, "_%a+", function(word)
    local first = string.sub(word, 2, 2)
    local rest = string.sub(word, 3)
    return string.upper(first) .. rest
  end)
end

M.bindArgs = function(func, ...) 
  local args = {...}
  return function()
    return func(unpack(args))
  end
end

M.lua = function(str) 
  return ':lua '..str..'<cr>'
end


return M
