local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  }
end

vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup('plugins', {
  defaults = {
    lazy = false,
  },
  checker = {
    enabled = false,
  },
  change_detection = {
    enabled = false,
  },
  ui = {
    border = 'rounded',
  },
  performance = {
    rtp = {
      disabled_plugins = {
        '2html_plugin',
        'getscript',
        'getscriptPlugin',
        'gzip',
        'logipat',
        'netrw',
        'netrwPlugin',
        'netrwSettings',
        'netrwFileHandlers',
        'matchit',
        'tar',
        'tarPlugin',
        'rrhelper',
        'spellfile_plugin',
        'vimball',
        'vimballPlugin',
        'zip',
        'zipPlugin',
        'fzf',
        'health',
        'tohtml',
        'tutor',
      },
    },
  },
})
