local noice = load('noice')
if not noice then return end

noice.setup {
  cmdline = {
    format = {
      cmdline = { pattern = "^:", icon = "$", lang = "vim" },
      search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
      search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
      filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
      lua = { pattern = "^:%s*lua%s+", icon = "", lang = "lua" },
      help = { pattern = "^:%s*h%s+", icon = "" },
      input = {}, -- Used by input()
    },
    lsp_progress = {
      enabled = true,
    },
  },

  views = {
    cmdline = {
      win_options = {
        winhighlight = {
          Normal = "NormalFloat",
          FloatBorder = "FloatBorder"
        },
      }
    },
    cmdline_popup = {
      win_options = {
        winhighlight = {
          Normal = "NormalFloat",
          FloatBorder = "FloatBorder"
        },
      }
    }
  }
}
