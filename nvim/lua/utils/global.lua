_G.map = function(mode, keys, cmd, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, keys, cmd, opts)
end

_G.get_current_path = function()
  return vim.fn.expand '%:p:h'
end

_G.is_number = function(value)
  return tonumber(value) ~= nil
end

_G.is_table = function(table)
  return type(table) == 'table'
end

_G.concat = function(a, b)
  for _, value in ipairs(b) do
    table.insert(a, value)
  end
  return a
end

_G.map_list = function(list, handler)
  local result = {}
  for index, value in ipairs(list) do
    table.insert(result, handler(value, index))
  end
  return result
end

_G.merge_tables = function(list)
  local result = {}

  for i = 1, #list do
    for key, value in pairs(list[i]) do
      result[key] = value
    end
  end

  return result
end

_G.assign = function(t1, t2)
  return vim.tbl_deep_extend('force', {}, t1, t2)
end

_G.merge = function(...)
  local args = { ... }
  return vim.tbl_extend('force', {}, unpack(args))
end

_G.loop = function(list, func)
    for k, v in pairs(list) do
        func(k, v)
    end
end

_G.add_to_home_path = function(path)
  return os.getenv 'HOME' .. '/' .. path
end

_G.get_row_col = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return cursor[1], cursor[2]
end

_G.get_terminal_width = function()
  local handle = io.popen 'tput cols'
  if handle then
    local result = handle:read '*a'
    handle:close()
    return tonumber(result)
  end
end

_G.log = function(any)
    local log = require('plenary.log').new({}, true)
    log.info(any)
end
