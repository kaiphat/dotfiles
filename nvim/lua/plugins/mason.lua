local M = {}

M.tools = {
  'lua-language-server',
  'prettierd',
  'rust-analyzer',
  'typescript-language-server',
  'json-lsp',
  'css-lsp',
  'html-lsp',
  'json-lsp',
  'sql-formatter',
  'emmet-language-server',
  'stylua',
}

return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      local mason = require 'mason'
      local tool_installer = require 'mason-tool-installer'

      mason.setup {
        ui = {
          border = 'rounded',
          width = 0.5,
        },
      }

      tool_installer.setup {
        ensure_installed = M.tools,
      }
    end,
  },
}
