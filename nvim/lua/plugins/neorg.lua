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
        default_keybinds = true
      }
    }
  }
}
