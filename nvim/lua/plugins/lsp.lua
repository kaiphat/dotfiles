local function set_lsp_maps()
  map("n", "<leader>ti", ":TypescriptAddMissingImports<cr>")
  map("n", "<leader>tr", ":TypescriptRenameFile<cr>")
  map("n", "<leader>td", ":TypescriptRemoveUnused<cr>")
  map("n", "<leader>to", ":TypescriptOrganizeImports<cr>")
end

local function set_lsp_symbols()
  local char = "│"

  for _, hint in ipairs({ "Error", "Information", "Hint", "Warning" }) do
    vim.fn.sign_define("LspDiagnosticsSign" .. hint, {
      text = char,
      numhl = "LspDiagnosticsSign" .. hint,
    })
  end
end

local function has_formatter(buf)
  local sources = require("null-ls.sources")
  local available = sources.get_available(vim.api.nvim_buf_get_option(buf, "filetype"), "NULL_LS_FORMATTING")
  return #available > 0
end

local function setup_formatting(client, buf)
  map("n", "<leader>lf", function()
    vim.lsp.buf.format({
      filter = function(cl)
        local is_null_ls = cl.name == "null-ls"
        local is_support = client.supports_method("textDocument/formatting")

        if not is_null_ls and is_support then
          return true
        end

        if is_null_ls and has_formatter(buf) then
          return true
        end

        return false
      end,
      bufnr = buf,
    })
  end, { buffer = buf })
end

local servers = {
  typescript = {
    disable_commands = false,
    debug = false,
  },
  cssls = {},
  html = {},
  sumneko_lua = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
        },
        runtime = {
          version = "LuaJIT",
        },
        diagnostics = {
          globals = {
            "vim",
          },
        },
      },
    },
  },
  emmet_ls = {
    is_not_highlight = true,
    filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
    init_options = {
      html = {
        options = {
          ["bem.enabled"] = true,
        },
      },
    },
  },
  rust_analyzer = {
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

local function on_attach(client, bufnr)
  setup_formatting(client, bufnr)

  map("n", "gd", ":lua vim.lsp.buf.definition()<cr>")
  map("n", "ga", ":vs<cr>:lua vim.lsp.buf.definition()<cr>")
  map("n", "K", ":lua vim.lsp.buf.hover()<cr>")
  map("n", "<leader>lk", ":lua vim.lsp.buf.signature_help()<cr>")
  map("n", "<space>le", ":lua vim.diagnostic.open_float()<cr>")
  map("n", "[d", ":lua vim.diagnostic.goto_prev()<cr>")
  map("n", "]d", ":lua vim.diagnostic.goto_next()<cr>")
  map("n", "<space>lq", ":lua vim.diagnostic.set_loclist()<cr>")
  map("n", "<space>la", ":lua vim.lsp.buf.code_action()<cr>")
  map("n", "<space>lr", ":lua vim.lsp.buf.rename()<cr>")

  if client.server_capabilities.document_highlight then
    local group = "lsp_document_highlight"

    vim.api.nvim_create_augroup(group, { clear = false })

    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = group,
    })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

return {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "jose-elias-alvarez/null-ls.nvim",
    "jose-elias-alvarez/typescript.nvim",
  },
  config = function()
    local config = require("lspconfig")
    local typescript = require("typescript")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    set_lsp_symbols()
    set_lsp_maps()

    -- FUNCTIONS --
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      -- virtual_text = false,
      virtual_text = {
        spacing = 8,
        prefix = " ",
      },
      signs = false,
      underline = true,
      update_in_insert = false,
    })

    for server, opts in pairs(servers) do
      if server == "typescript" then
        typescript.setup(vim.tbl_deep_extend("force", {}, opts, {
          server = {
            on_attach = function(client, buf)
              client.server_capabilities.document_highlight = true

              on_attach(client, buf)
            end,
            capabilities = capabilities,
            flags = {
              debounce_text_changes = 150,
            },
          },
        }))
      else
        config[server].setup(vim.tbl_deep_extend("force", {
          on_attach = function(client, buf)
            client.server_capabilities.document_highlight = not (opts.is_not_highlight or false)

            on_attach(client, buf)
          end,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
        }, opts))
      end
    end
  end,
}
