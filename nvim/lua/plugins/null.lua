local null_ls = load('null-ls')
if not null_ls then return end

local formattings = null_ls.builtins.formatting

-- local formatting = 
null_ls.setup {
  sources = {
    formattings.prettier.with({
      filetypes = {
        "html",
        "json",
        "yaml",
        "markdown",
        "css",
        "scss",
        "javascript",
        "typescript",
        "javascriptreact",
        "typescriptreact",
        "js",
        "ts",
      },
      -- extra_args = { '--single-quote', '--semi', 'false' },
    }),
    formattings.stylua
  }
}
