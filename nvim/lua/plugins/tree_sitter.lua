local install = load('nvim-treesitter.install')
if not install then return end

local config = load('nvim-treesitter.configs')
if not config then return end

local context = load('treesitter-context')
if not context then return end

install.compilers = { "clang", "gcc" }

config.setup {
  ensure_installed = {
    'javascript',
    'rust',
    'typescript',
    'toml',
    'yaml',
    'vim',
    'tsx',
    'markdown',
    'json',
    'lua',
    'make',
    'css',
    'html',
    'scss',
    'dockerfile',
    'json5',
    'fish'
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
    disable = {
    }
  },
}

context.setup {
  enable = true
}
