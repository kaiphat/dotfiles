local tree = load('nvim-tree')
if not tree then return end

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

tree.setup {
  view = {
    width = 70,
    mappings = {
      custom_only = true,
      list = {
        { key = "u",              cb = tree_cb("dir_up") },
        { key = "o",              cb = tree_cb("edit") },
        { key = "C",              cb = tree_cb("cd") },
        { key = "s",              cb = tree_cb("vsplit") },
        { key = "<Tab>",          cb = tree_cb("preview") },
        { key = "x",              cb = tree_cb("close_node") },
        { key = "I",              cb = tree_cb("toggle_ignored") },
        { key = "H",              cb = tree_cb("toggle_dotfiles") },
        { key = "R",              cb = tree_cb("refresh") },
        { key = "d",              cb = tree_cb("remove") },
        { key = "a",              cb = tree_cb("create") },
        { key = "X",              cb = tree_cb("cut") },
        { key = "c",              cb = tree_cb("copy") },
        { key = "p",              cb = tree_cb("paste") },
        { key = "y",              cb = tree_cb("copy_name") },
        { key = "P",              cb = tree_cb("copy_path") },
        { key = "r",              cb = tree_cb("rename") },
        { key = "Y",              cb = tree_cb("copy_absolute_path") },
      }
    }
  },
  update_cwd = true,
  update_focused_file = {
    enable = false,
    update_cwd = false,
    ignore_list = {},
  },
  git = {
    enable = true,
    ignore = false
  },
}

