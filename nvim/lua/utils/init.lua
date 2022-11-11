local logger = require('utils.logger')

local M = {}

M.get_current_path = function()
  return vim.fn.expand('%:p:h')
end

M.splitString = function(str, delimiter)
    local result = {}
    for match in (str .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
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

M.upperSql = function(str)
  local words = {
    'select',
    'join',
    'from',
    'order by',
    'limit',
    'where',
    'as',
    'in',
    'on',
    'and',
    'case',
    'then',
    'if',
    'when',
    'is',
    'null',
    'group by',
    'else',
    'end'
  }

  for _, word in pairs(words) do
    str = str:gsub(word..' ', word:upper()..' ')
  end

  return str
end

M.clone_table = function(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
      copy = {}
      for orig_key, orig_value in next, orig, nil do
          copy[clone(orig_key)] = clone(orig_value)
      end
      setmetatable(copy, clone(getmetatable(orig)))
  else
      copy = orig
  end
  return copy
end

local function get_selection()
  -- does not handle rectangular selection
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return lines
end

return M

