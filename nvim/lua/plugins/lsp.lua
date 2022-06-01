local util = require 'vim.lsp.util'

local config = require 'lspconfig'

local config = load('lspconfig')
if not config then return end

local lsp_signature = load('lsp_signature')
if not lsp_signature then return end

local cmp_nvim_lsp = load('cmp_nvim_lsp')
if not cmp_nvim_lsp then return end

local nvim_lsp_ts_utils = load('nvim-lsp-ts-utils')
if not nvim_lsp_ts_utils then return end

lsp_signature.setup {
  bind = true,
  handler_opts = {
    border = "rounded"
  },
  hint_prefix = " ",
  hint_enable = false
}

-- CAPABILITIES --
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

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

-- AUTO HIGHLIGHTS --
-- vim.api.nvim_create_autocmd("CursorHold", {
--   callback = function()
--     local opts = {
--       focusable = false,
--       close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--       border = 'rounded',
--       source = 'always',
--       prefix = ' ',
--       scope = 'cursor',
--     }
--     vim.diagnostic.open_float(nil, opts)
--   end
-- })

-- FUNCTIONS --
local function format(client, bufnr)
  vim.keymap.set('n', '<leader>f', function()
    local params = util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr) 
  end, { buffer = bufnr })
end

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- map('n',   'gD',           '<Cmd>lua   vim.lsp.buf.declaration()<cr>')
  map('n',   'gd',           ':lua vim.lsp.buf.definition()<cr>')
  map('n',   'ga',           ':vs<cr>:lua vim.lsp.buf.definition()<cr>')
  map('n',   'K',            ':lua vim.lsp.buf.hover()<cr>')
  map('n',   '<leader>lk',   ':lua vim.lsp.buf.signature_help()<cr>')
  map('n',   '<space>le',    ':lua vim.diagnostic.open_float()<cr>')
  map('n',   '[d',           ':lua vim.diagnostic.goto_prev()<cr>')
  map('n',   ']d',           ':lua vim.diagnostic.goto_next()<cr>')
  map('n',   '<space>lq',    ':lua vim.diagnostic.set_loclist()<cr>')
  map('n',   '<space>la',    ':lua vim.lsp.buf.code_action()<cr>')
  map('n',   '<space>lr',    ':lua vim.lsp.buf.rename()<cr>')
  map('n',   '<space>lf',    ':lua vim.lsp.buf.format({ async = true })<cr>')

  if client.server_capabilities.document_highlight then
    local group = 'lsp_document_highlight'
    vim.api.nvim_create_augroup(group, {})
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      group = group,
      buffer = 0,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd('CursorMoved', {
      group = group,
      buffer = 0,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

vim.o.updatetime = 600
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    -- virtual_text = {
    --   spacing = 4,
    --   prefix = " "
    -- },
    signs = false,
    underline = true,
    update_in_insert = false
  }
)

config.tsserver.setup {
  on_attach = function(client, bufnr)
    local ts_utils = nvim_lsp_ts_utils
    ts_utils.setup({})
    ts_utils.setup_client(client)

    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false

    format(client, bufnr)
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  init_options = {
    usePlaceholders = true,
    hostInfo = "neovim"
  },
  init_options = nvim_lsp_ts_utils.init_options,
  flags = {
    debounce_text_changes = 150,
  }
}

config.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    format(client, bufnr)
    on_attach(client, bufnr)
  end,
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
    }
  }
}

config.cssls.setup {
  on_attach = function(client, bufnr)
    format(client, bufnr)
    on_attach(client, bufnr)
  end,
}

config.html.setup {
  on_attach = function(client, bufnr)
    format(client, bufnr)
    on_attach(client, bufnr)
  end,
}

local function lspSymbol(name, icon)
   vim.fn.sign_define('LspDiagnosticsSign' .. name, { text = icon, numhl = 'LspDiagnosticsSign' .. name })
end

lspSymbol('Error', '│')
lspSymbol('Information', '│')
lspSymbol('Hint', '│')
lspSymbol('Warning', '│')
