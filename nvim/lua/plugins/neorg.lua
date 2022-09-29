local neorg = load('neorg')
if not neorg then return end

neorg.setup {
  load = {
    ["core.defaults"] = {},
    ["core.norg.concealer"] = {},
    ["core.norg.dirman"] = {
      config = {
        workspaces = {
          main = '~/notes'
        }
      }
    },
    ["core.keybinds"] = {
      config = {
        hook = function(keybinds)
          keybinds.remap_event("norg", "n", "gd", "core.norg.qol.todo_items.todo.task_done")
          keybinds.remap_event("norg", "n", "gu", "core.norg.qol.todo_items.todo.task_undone")
        end,
        default_keybinds = true
      }
    }
  }
}
