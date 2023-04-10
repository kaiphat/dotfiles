return {
  {
    enabled = false,
    'nvim-treesitter/playground',
    cmd = {
      'TSPlaygroundToggle',
      'TSHighlightCapturesUnderCursor',
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufReadPost',
    dependencies = {
      -- 'nvim-treesitter/nvim-treesitter-context',
    },
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
      }

      vim.treesitter.language.register('fish', 'man')

      local unit = require 'utils.unit'

      map({ 'x', 'o' }, 'u', function()
        unit.select(true)
      end)
      map('n', ']]', function()
        unit.moveToEnd()
      end)
      map('n', '[[', function()
        unit.moveToStart()
      end)
    end,
  },
}
