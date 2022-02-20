require 'nvim-treesitter.install'.compilers = { "clang", "gcc" }

require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  }
}

local parser_configs = require 'nvim-treesitter.parsers'.get_parser_configs()
