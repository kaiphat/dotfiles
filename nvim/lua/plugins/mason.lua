local M = {}

M.tools = {
  'stylua',
  'lua-language-server',
  'prettierd',
  'rust-analyzer',
  'typescript-language-server',
  'json-lsp',
  'css-lsp',
  'html-lsp',
  'json-lsp',
  'sql-formatter',
}

M.install = function()
  local mr = require 'mason-registry'

  for _, tool in ipairs(M.tools) do
    local p = mr.get_package(tool)

    if not p:is_installed() then
      p:install()
    end
  end
end

return {
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      local mason = require 'mason'
      local mason_lspconfig = require 'mason-lspconfig'

      mason.setup {
        ui = {
          border = 'rounded',
          width = 0.5,
        },
      }

      mason_lspconfig.setup {
        automatic_installation = true,
      }

      M.install()
    end,
  },
}
