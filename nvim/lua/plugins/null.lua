return {
  'jose-elias-alvarez/null-ls.nvim',
  event = 'BufReadPre',
  config = function()
    local null_ls = require 'null-ls'
    local formattings = null_ls.builtins.formatting

    null_ls.setup {
      debounce = 10,
      sources = {
        formattings.prettierd.with {
          prefer_local = 'node_modules/.bin',
          extra_filetypes = {},
        },
        formattings.stylua.with {
          extra_args = {
            '--quote-style',
            'ForceSingle',
            '--call-parentheses',
            'None',
            '--indent-width',
            '2',
            '--indent-type',
            'Spaces',
          },
        },
        formattings.sql_formatter.with {
          extra_args = {
            '-l',
            'postgresql',
            '-c',
            '/home/ipunko/dotfiles/sql_formatter.json',
          },
        },
      },
    }
  end,
}
