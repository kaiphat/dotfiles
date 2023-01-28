return {
  'jose-elias-alvarez/null-ls.nvim',
  event = 'BufReadPre',
  config = function()
    local null_ls = require 'null-ls'
    local formattings = null_ls.builtins.formatting

    null_ls.setup {
      debounce = 150,
      sources = {
        formattings.prettierd.with({
          filetypes = {
            'html',
            'json',
            'yaml',
            'markdown',
            'css',
            'scss',
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
            'js',
            'ts',
          },
          -- extra_args = { '--single-quote', '--semi', 'false' },
        }),
        formattings.stylua
      }
    }
  end
}
