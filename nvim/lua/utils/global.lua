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

_G.create_title = function(char)
  local MAX_LENGTH = 60
  local SPACE_LENGTH = 3
  local DEFAULT_CHAR = '┈'

  char = char or '#'

  local row = get_row_col()

  local line = vim.trim(vim.api.nvim_get_current_line():gsub(char, ''):gsub(DEFAULT_CHAR, ''))
  local left_line_length = math.floor((MAX_LENGTH - #line - SPACE_LENGTH * 2) / 2)
  local left = DEFAULT_CHAR:rep(left_line_length)
  local right = DEFAULT_CHAR:rep(MAX_LENGTH - #line - SPACE_LENGTH * 2 - left_line_length)

  local next_line = vim.api.nvim_buf_get_lines(0, row, row + 1, false)[1]
  local space = (' '):rep(SPACE_LENGTH)
  local title = char .. ' ' .. left .. space .. line .. space .. right

  local border = char .. ' ' .. DEFAULT_CHAR:rep(MAX_LENGTH)

  vim.api.nvim_buf_set_lines(0, row - 1, row, true, { border, title, border })

  if vim.trim(next_line) ~= '' then
    vim.api.nvim_buf_set_lines(0, row + 2, row + 2, true, { '' })
  end
end

_G.create_sub_title = function(char)
  local MAX_LENGTH = 60
  local SPACE_LENGTH = 5
  local DEFAULT_CHAR = '┈'

  char = char or '#'

  local row = get_row_col()

  local line = vim.trim(vim.api.nvim_get_current_line():gsub(char, ''):gsub(DEFAULT_CHAR, ''))
  local free_space = MAX_LENGTH - #line - SPACE_LENGTH * 2
  local left_line_length = math.floor(free_space / 2)
  local left = DEFAULT_CHAR:rep(left_line_length)
  local right = DEFAULT_CHAR:rep(free_space - left_line_length)

  local space = (' '):rep(SPACE_LENGTH)
  local title = char .. ' ' .. left .. space .. line .. space .. right

  vim.api.nvim_buf_set_lines(0, row - 1, row, true, { title })
end
