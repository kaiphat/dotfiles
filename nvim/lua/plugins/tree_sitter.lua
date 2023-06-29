local M = {}

M.get_mappings = function()
  local unit = require 'utils.unit'

  map({ 'x', 'o' }, 'u', function()
    unit.select(true)
  end)
  map('n', ']]', function()
    unit.move_down()
  end)
  map('n', '[[', function()
    unit.move_up()
  end)
end

return {
  {
    'nvim-treesitter/nvim-treesitter-context',
    enabled = false
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    config = function()
      local install = require 'nvim-treesitter.install'
      local config = require 'nvim-treesitter.configs'

      install.compilers = { 'gcc' }

      config.setup {
        ensure_installed = {
          'javascript',
          'rust',
          'typescript',
          'toml',
          'yaml',
          'vim',
          'tsx',
          'markdown',
          'json',
          'lua',
          'make',
          'css',
          'html',
          'scss',
          'dockerfile',
          'json5',
          'fish',
          'glimmer',
          'scheme',
          'sql',
          'python',
          'bash',
          'regex',
          'norg',
          'kdl',
          'proto',
          'markdown_inline',
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { 'BufWrite', 'CursorHold' },
        },
        textsubjects = {
          enable = true,
          keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
          },
        },
        highlight = {
          enable = true,
          use_languagetree = true,
          additional_vim_regex_highlighting = true,
        },
        indent = {
          enable = true,
          disable = {},
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<Enter>',
            node_incremental = '<Enter>',
            node_decremental = '<BS>',
          },
        },
      }

      -- vim.treesitter.language.register('markdown', 'man')
      M.get_mappings()
    end,
  },
}
