local noice = load('noice')
if not noice then return end

noice.setup {
  views = {
    popup = {
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    cmdline = {
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    cmdline_popup = {
      win_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },

      filter_options = {
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    }
  },
  cmdline = {
    icons = {
      ["/"] = { icon = " ", hl_group = "DiagnosticWarn", firstc = false },
      [":"] = { icon = "", hl_group = "DiagnosticInfo", firstc = false },
    },
  }
}
