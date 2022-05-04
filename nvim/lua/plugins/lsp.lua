local config = require 'lspconfig'
local util = require 'lspconfig/util'
local map = require('utils').map
local util = require 'vim.lsp.util'

local function format(client, bufnr)
  vim.keymap.set('n', '<leader>f', function()
    local params = util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr) 
  end, {buffer = bufnr})
end

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- map('n',   'gD',           '<Cmd>lua   vim.lsp.buf.declaration()<cr>')
  map('n',   'gd',           ':lua vim.lsp.buf.definition()<cr>')
  map('n',   'ga',           ':vs<cr>:lua vim.lsp.buf.definition()<cr>')
  map('n',   'K',            ':lua vim.lsp.buf.hover()<cr>')
  map('n',   '<leader>lk',   ':lua vim.lsp.buf.signature_help()<cr>')
  map('n',   '<space>le',    ':lua vim.diagnostic.open_float()<cr>')
  map('n',   '[d',           ':lua   vim.diagnostic.goto_prev()<cr>')
  map('n',   ']d',           ':lua   vim.diagnostic.goto_next()<cr>')
  map('n',   '<space>lq',    ':lua vim.diagnostic.set_loclist()<cr>')
  map('n',   '<space>la',    ':lua vim.lsp.buf.code_action()<cr>')
  map('n',   '<space>lr',    ':lua vim.lsp.buf.rename()<cr>')
  map('n',   '<space>lf',    ':lua vim.lsp.buf.format({ async = true })<cr>')

  if client.server_capabilities.document_highlight then
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
  flags = {
    debounce_text_changes = 150,
  }
}

config.rust_analyzer.setup {
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
