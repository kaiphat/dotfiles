local noice = load('noice')
if not noice then return end

local default_opts = {
  win_options = {
    winhighlight = {
      Normal = "NormalFloat",
      FloatBorder = "FloatBorder"
    },
  }
}

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
    opts = default_opts,
  },

  lsp = {
    progress = {
      enabled = true,
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },

  format = {
  },

  routes = {
    -- show macro recording
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
  },

}
