local M = {}

M.servers = {
  prettierd = {
    prefer_local = 'node_modules/.bin',
    extra_filetypes = {},
  },
  stylua = {
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
  sql_formatter = {
    extra_filetypes = { 'man' },
    extra_args = {
      '-l',
      'postgresql',
      '-c',
      add_to_home_path 'dotfiles/sql_formatter.json',
    },
  },
}

return {
  'jose-elias-alvarez/null-ls.nvim',
  event = 'BufReadPre',
  config = function()
    local null_ls = require 'null-ls'
    local formattings = null_ls.builtins.formatting

    local sources = {}

    for name, config in pairs(M.servers) do
      table.insert(sources, formattings[name].with(config))
    end

    null_ls.setup {
      debounce = 10,
      sources = sources,
    }
  end,
}
