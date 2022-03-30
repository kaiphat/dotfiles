local config = require 'lspconfig'
local util = require 'lspconfig/util'

local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

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

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local function map(mode, keys, cmd) 
    vim.api.nvim_buf_set_keymap(bufnr, mode, keys, cmd, { noremap = true, silent = true })
  end

  -- map('n',   'gD',           '<Cmd>lua   vim.lsp.buf.declaration()<cr>')
  map('n',   'gd',           ':lua vim.lsp.buf.definition()<cr>')
  map('n',   'ga',           ':vs<cr>:lua vim.lsp.buf.definition()<cr>')
  map('n',   'K',            ':lua vim.lsp.buf.hover()<cr>')
  map('n',   '<leader>lk',   ':lua vim.lsp.buf.signature_help()<cr>')
  map('n',   '<space>le',    ':lua vim.diagnostic.open_float()<cr>')
  -- map('n',   '[d',           ':lua   vim.diagnostic.goto_prev()<cr>')
  -- map('n',   ']d',           ':lua   vim.diagnostic.goto_next()<cr>')
  map('n',   '<space>lq',    ':lua vim.diagnostic.set_loclist()<cr>')
  map('n',   '<space>la',    ':lua vim.lsp.buf.code_action()<cr>')
  map('n',   '<space>lr',    ':lua vim.lsp.buf.rename()<cr>')
  map('n',   '<space>lf',    ':lua vim.lsp.buf.formatting()<cr>')

  if client.resolved_capabilities.document_highlight then
      vim.cmd [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]]
  end
end

vim.o.updatetime = 600
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, { focus=false })]]

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- virtual_text = {
    --   spacing = 14,
    --   prefix = " "
    -- },
    signs = false,
    underline = true,
    virtual_text = false,
    update_in_insert = false
  }
)

config.tsserver.setup {
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false

    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
  init_options = {
    usePlaceholders = true,
    hostInfo = "neovim"
  },
  flags = {
    debounce_text_changes = 150,
  }
}

config.cssls.setup {
  on_attach = on_attach
}

config.html.setup {
  on_attach = on_attach
}

local function lspSymbol(name, icon)
   vim.fn.sign_define('LspDiagnosticsSign' .. name, { text = icon, numhl = 'LspDiagnosticsSign' .. name })
end

lspSymbol('Error', '│')
lspSymbol('Information', '│')
lspSymbol('Hint', '│')
lspSymbol('Warning', '│')
