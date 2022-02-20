local null_ls = require('null-ls')

null_ls.setup {
  sources = {
    null_ls.builtins.formatting.prettier.with({
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
        "ts" 
      },
      extra_args = { '--single-quote', '--semi', 'false' },
    }),
    null_ls.builtins.formatting.stylua
  }
}
