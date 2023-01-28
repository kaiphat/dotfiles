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
