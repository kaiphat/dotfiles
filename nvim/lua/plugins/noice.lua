local icon = os.getenv("PROMPT_CHAR")

return {
  'folke/noice.nvim',
  config = function()
    local noice = require 'noice'

    noice.setup {
      views = {
        cmdline_popup = {
          -- border = {
          --   style = 'none',
          --   padding = { 1, 2 }
          -- },
          position = {
            row = '50%',
            col = '50%',
          },
          win_options = {
            winhighlight = {
              Normal = 'NormalFloat',
              FloatBorder = 'FloatBorder',
            },
          },
        },

        mini = {
          win_options = {
            winblend = 0,
          },
        },
      },

      cmdline = {
        format = {
          cmdline = { pattern = '^:', icon = icon, lang = 'vim' },
          search_down = { kind = 'search', pattern = '^/', icon = ' ', lang = 'regex' },
          search_up = { kind = 'search', pattern = '^%?', icon = ' ', lang = 'regex' },
          filter = { pattern = '^:%s*!', icon = icon, lang = 'bash' },
          lua = { pattern = '^:%s*lua%s+', icon = '', lang = 'lua' },
          help = { pattern = '^:%s*h%s+', icon = '' },
          input = {}, -- Used by input()
        },
      },

      lsp = {
        progress = {
          enabled = false,
          view = 'notify',
        },
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },

      format = {},

      presets = {
        bottom_search = false,
        cmdline_output_to_split = false,

        inc_rename = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },

      routes = {
        {
          filter = {
            event = 'msg_show',
            find = '%d+L, %d+B',
          },
          view = 'notify',
        },
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
      },
    }
  end,
}
