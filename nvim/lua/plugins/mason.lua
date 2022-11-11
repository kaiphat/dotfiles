local mason = load('mason')
if not mason then return end

local mason_lspconfig = load("mason-lspconfig")
if not mason_lspconfig then return end

mason_lspconfig.setup {
  automatic_installation = true,
}

mason.setup {
  ui = {
    check_outdated_packages_on_open = false,
  },
}
