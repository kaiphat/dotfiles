_G.map = function(mode, keys, cmd, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, keys, cmd, opts)
end

_G.is_number = function(value)
  return tonumber(value) ~= nil
end

_G.is_table = function(table)
  return type(table) == 'table'
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

_G.add_to_home_path = function(path)
  return os.getenv 'HOME' .. '/' .. path
end

_G.get_row_col = function()
  local cursor = vim.api.nvim_win_get_cursor(0)
  return cursor[1], cursor[2]
end

-- _G.create_title = function(char)
--   local prefix_length = 10
--
--   char = char or '#'
--
--   local row = get_row_col()
--   local line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
--   local trimmed_line = trim_string(line)
--   local line_length = trimmed_line:len()
--
--   local prefix = generate_string(char, prefix_length)
--   local prefix_line = prefix .. generate_string(char, line_length + 2) .. prefix
--   local title = prefix .. ' ' .. trimmed_line .. ' ' .. prefix
--
--   vim.api.nvim_buf_set_lines(0, row - 1, row, true, { prefix_line, title, prefix_line })
-- end

_G.create_title = function(char)
  local length = 7
  local max_length = 60

  char = char or '#'

  local row = get_row_col()

  local left = string.rep(char, length)
  local right = string.rep(char, max_length)
  local line = vim.trim(vim.api.nvim_get_current_line():gsub(char, ''))
  local next_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  local raw_title = left .. ' ' .. line .. ' ' .. right
  local title = raw_title:sub(1, max_length)

  local border = string.rep(char, #title)

  vim.api.nvim_buf_set_lines(0, row - 1, row, true, { border, title, border })

  if vim.trim(next_line) ~= '' then
    vim.api.nvim_buf_set_lines(0, row + 2, row + 2, true, { '' })
  end
end
