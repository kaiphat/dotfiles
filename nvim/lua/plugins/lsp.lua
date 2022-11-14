local util = require 'vim.lsp.util'

local config = load('lspconfig')
if not config then return end

local cmp_nvim_lsp = load('cmp_nvim_lsp')
if not cmp_nvim_lsp then return end

local typescript = load('typescript')
if not typescript then return end

-- CAPABILITIES --
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

capabilities.textDocument.completion.completionItem.documentationFormat = { "markdown", "plaintext" }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    "documentation",
    "detail",
    "additionalTextEdits",
  },
}

local function lspSymbol(name, icon)
  vim.fn.sign_define('LspDiagnosticsSign' .. name, { text = icon, numhl = 'LspDiagnosticsSign' .. name })
end

lspSymbol('Error', '│')
lspSymbol('Information', '│')
lspSymbol('Hint', '│')
lspSymbol('Warning', '│')

local null_ls_format = function(client, bufnr)
  map('n', '<leader>lf', function()
    local params = util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr)
  end, { buffer = bufnr })
end

-- FUNCTIONS --
local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  map('n', 'gd', ':lua vim.lsp.buf.definition()<cr>')
  map('n', 'ga', ':vs<cr>:lua vim.lsp.buf.definition()<cr>')
  map('n', 'K', ':lua vim.lsp.buf.hover()<cr>')
  map('n', '<leader>lk', ':lua vim.lsp.buf.signature_help()<cr>')
  map('n', '<space>le', ':lua vim.diagnostic.open_float()<cr>')
  map('n', '[d', ':lua vim.diagnostic.goto_prev()<cr>')
  map('n', ']d', ':lua vim.diagnostic.goto_next()<cr>')
  map('n', '<space>lq', ':lua vim.diagnostic.set_loclist()<cr>')
  map('n', '<space>la', ':lua vim.lsp.buf.code_action()<cr>')
  map('n', '<space>lr', ':lua vim.lsp.buf.rename()<cr>')
  map('n', '<space>lf', function()
    vim.lsp.buf.format {
      async = true,
      bufnr = bufnr,
    }
  end)

  if client.server_capabilities.document_highlight then
    local group = 'lsp_document_highlight'
    vim.api.nvim_create_augroup(group, { clear = false })
    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = group,
    })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    -- virtual_text = false,
    virtual_text = {
      spacing = 8,
      prefix = " "
    },
    signs = false,
    underline = true,
    update_in_insert = false
  }
)

-- SERVERS --
typescript.setup {
  disable_commands = false,
  debug = false,
  server = {
    on_attach = function(client, bufnr)
      client.server_capabilities.document_highlight = true
      client.server_capabilities.document_formatting = false
      client.server_capabilities.document_range_formatting = false

      on_attach(client, bufnr)
      null_ls_format(client, bufnr)
    end,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 150,
    }
  }
}

config.jsonls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    null_ls_format(client, bufnr)
  end
}

config.pylsp.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    null_ls_format(client, bufnr)
  end,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          ignore = { 'W391' },
          maxLineLength = 100
        }
      }
    }
  }
}

config.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    client.server_capabilities.document_highlight = true
    on_attach(client, bufnr)
  end,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      diagnostics = {
        enable = true,
        enableExperimental = true,
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
      inlayHints = {
        chainingHints = true,
        parameterHints = true,
        typeHints = true,
      },
    }
  }
}

config.cssls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

config.html.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

config.sumneko_lua.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.document_highlight = true
    on_attach(client, bufnr)
    null_ls_format(client, bufnr)
  end,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {
          'vim',
        }
      }
    }
  }
}
