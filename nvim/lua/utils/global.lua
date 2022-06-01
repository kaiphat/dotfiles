_G.load = function(plugin_name) 
  local loaded, plugin = pcall(require, plugin_name)
  if loaded then
    return plugin
  else
    print(plugin_name.." doesn't exist")
    return false
  end
end

_G.map = function(mode, keys, cmd, opts)
  opts = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, keys, cmd, opts)
end


