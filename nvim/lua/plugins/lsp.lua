local M = {}

M.set_lsp_symbols = function()
  local char = '│'

  for _, hint in ipairs { 'Error', 'Information', 'Hint', 'Warning' } do
    vim.fn.sign_define('LspDiagnosticsSign' .. hint, {
      text = char,
      numhl = 'LspDiagnosticsSign' .. hint,
    })
  end
end

M.add_mappings = function()
  map('n', 'gd', function()
    vim.cmd 'vs'
    vim.lsp.buf.definition()
  end)
  map('n', 'ga', function()
    vim.lsp.buf.definition()
  end)
  map('n', 'K', function()
    vim.lsp.buf.hover()
  end)
  map('n', '<leader>lk', function()
    vim.lsp.buf.signature_help()
  end)
  map('n', '<space>le', function()
    vim.diagnostic.open_float()
  end)
  map('n', '[d', function()
    vim.diagnostic.goto_prev()
  end)
  map('n', ']d', function()
    vim.diagnostic.goto_next()
  end)
  map('n', '<space>lq', function()
    vim.diagnostic.setqflist()
  end)
  map('n', '<space>ls', function()
    vim.diagnostic.show()
  end)
  map('n', '<space>la', function()
    vim.lsp.buf.code_action()
  end)
  map('n', '<space>lr', function()
    vim.lsp.buf.rename()
  end)
  map('n', '<leader>lf', function()
    vim.lsp.buf.format {
      timeout_ms = 5000,
    }
  end)
end

M.set_handlers = function()
  vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- virtual_text = false,
    virtual_text = {
      spacing = 8,
      prefix = ' ',
      -- severity = {
      -- Specify a range of severities
      --   min = vim.diagnostic.severity.ERROR,
      -- },
    },
    signs = false,
    underline = true,
    update_in_insert = false,
  })

  vim.lsp.handlers['textDocument/definition'] = function(_, result)
    if not result or vim.tbl_isempty(result) then
      print '[LSP] Could not find definition'
      return
    end

    if vim.tbl_islist(result) then
      vim.lsp.util.jump_to_location(result[1], 'utf-8')
    else
      vim.lsp.util.jump_to_location(result, 'utf-8')
    end
  end
end

M.on_attach = function(client)
  if client.supports_method 'textDocument/semanticTokens' then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.get_servers = function()
  return {
    -- tsserver = {
    --   flags = {
    --     debounce_text_changes = 150,
    --   },
    --   disable_commands = false,
    --   debug = false,
    -- },
    typescript = {
      custom_server = require 'typescript',
      custom_settings = {
        server = {
          on_attach = M.on_attach,
          capabilities = M.get_capabilities(),
          flags = {
            debounce_text_changes = 150,
          },
        },
      },
    },
    cssls = {},
    sqlls = {},
    html = {},
    pylsp = {},
    lua_ls = {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
          },
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = {
              'vim',
            },
          },
          format = {
            enable = false,
          },
        },
      },
    },
    emmet_ls = {
      is_not_highlight = true,
      filetypes = { 'html', 'typescriptreact', 'javascriptreact', 'css', 'sass', 'scss', 'less' },
      init_options = {
        html = {
          options = {
            ['bem.enabled'] = true,
          },
        },
      },
    },
    rust_analyzer = {
      settings = {
        ['rust-analyzer'] = {
          assist = {
            importGranularity = 'module',
            importPrefix = 'self',
          },
          diagnostics = {
            enable = true,
            enableExperimental = true,
          },
          cargo = {
            loadOutDirsFromCheck = true,
          },
          procMacro = {
            enable = true,
          },
          inlayHints = {
            chainingHints = true,
            parameterHints = true,
            typeHints = true,
          },
        },
      },
    },
  }
end

M.get_capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  capabilities.textDocument.completion.completionItem = {
    documentationFormat = { 'markdown', 'plaintext' },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      },
    },
  }

  return capabilities
end

return {
  {
    'jose-elias-alvarez/typescript.nvim',
    enabled = true,
    event = 'BufReadPre',
    config = function()
      map('n', '<leader>ti', ':TypescriptAddMissingImports<cr>')
      map('n', '<leader>tr', ':TypescriptRenameFile<cr>')
      map('n', '<leader>td', ':TypescriptRemoveUnused<cr>')
      map('n', '<leader>to', ':TypescriptOrganizeImports<cr>')
    end,
  },

  {
    'pmizio/typescript-tools.nvim',
    enabled = false,
    event = 'BufReadPre',
    config = function()
      local ts = require 'typescript-tools'

      ts.setup {}
    end,
  },

  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'jose-elias-alvarez/null-ls.nvim',
      -- 'pmizio/typescript-tools.nvim',
      'jose-elias-alvarez/typescript.nvim',
    },
    config = function()
      local config = require 'lspconfig'

      M.set_handlers()
      M.add_mappings()

      for server_name, opts in pairs(M.get_servers()) do
        local server = opts.custom_server or config[server_name]
        local settings = opts.custom_settings
          or merge({
            on_attach = M.on_attach,
            capabilities = M.get_capabilities(),
            flags = {
              debounce_text_changes = 150,
            },
          }, opts)

        server.setup(settings)
      end
    end,
  },
}
