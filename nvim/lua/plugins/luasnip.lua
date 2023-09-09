local M = {}

M.set_mappings = function()
  local ls = require 'luasnip'

  map({ 'i', 's' }, '<C-e>', function()
    ls.jump(1)
  end)
  map({ 'i', 's' }, '<C-d>', function()
    ls.change_choice(1)
  end)
end

M.change = function(func, index)
  local ls = require 'luasnip'

  index = index or 1

  return ls.function_node(function(args)
    local str = args[1][1]

    return { func(str) or '' }
  end, { index })
end

M.wrap = function(func)
  local ls = require 'luasnip'
  local list = {}

  for key, value in pairs(func(M)) do
    table.insert(list, ls.snippet(key, value))
  end

  return list
end

return {
  'L3MON4D3/LuaSnip',
  config = function()
    local ls = require 'luasnip'
    local rust_snippets = require 'plugins.snippets.rust'
    local javascript_snippets = require 'plugins.snippets.javascript'

    ls.config.set_config {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      delete_check_events = 'TextChanged,InsertLeave',
    }

    M.set_mappings()

    ls.add_snippets('rust', M.wrap(rust_snippets))
    ls.add_snippets('javascript', M.wrap(javascript_snippets))

    ls.filetype_extend('typescript', { 'javascript' })
    ls.filetype_extend('javascriptreact', { 'javascript' })
    ls.filetype_extend('typescriptreact', { 'javascript' })
  end,
}
