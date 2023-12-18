_G.get_current_path = function()
  return vim.fn.expand '%:p:h'
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

_G.merge = function(...)
  local args = { ... }
  return vim.tbl_extend('force', {}, unpack(args))
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
