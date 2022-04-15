require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  }
}

