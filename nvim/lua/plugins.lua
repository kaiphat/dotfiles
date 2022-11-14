local fn = vim.fn

local packer = load("packer")
if not packer then return end

local function r(path)
  return 'require"plugins.' .. path .. '"'
end

packer.init {
  git = {
    clone_timeout = 6000
  },
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'rounded' }
    end
  },
  auto_clean = true,
  compile_on_sync = true,
  disable_commands = true
}

local packer_bootstrap
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  }

  vim.cmd "packadd packer.nvim"
end

packer.startup(
  function(use)
    use {
      'wbthomason/packer.nvim',
      'nvim-lua/plenary.nvim',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'lewis6991/impatient.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'nvim-treesitter/nvim-treesitter-context',
      'nvim-lua/popup.nvim',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'kyazdani42/nvim-web-devicons',
      'nvim-telescope/telescope-ui-select.nvim',
      'jose-elias-alvarez/typescript.nvim',
      'nvim-treesitter/playground',
      'MunifTanjim/nui.nvim',
      'onsails/lspkind.nvim',
      'williamboman/mason-lspconfig.nvim',
    }

    use {
      'ThePrimeagen/harpoon',
      config = r('harpoon')
    }

    use {
      'williamboman/mason.nvim',
      config = r('mason')
    }

    use {
      'nvim-neo-tree/neo-tree.nvim',
      config = r('neotree'),
      branch = 'v2.x',
    }

    use {
      'kylechui/nvim-surround',
      config = r('surround'),
    }

    use {
      'folke/noice.nvim',
      config = r('noice')
    }

    use {
      'sindrets/diffview.nvim',
      config = r('diffview')
    }

    use {
      'phaazon/hop.nvim',
      branch = 'v2',
      config = r('hop')
    }

    use {
      'Pocco81/true-zen.nvim',
      config = r('zen')
    }

    use {
      'rcarriga/nvim-notify',
      config = r('notify')
    }

    use {
      'feline-nvim/feline.nvim',
      config = r('statusline'),
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      config = r('null')
    }

    use {
      'neovim/nvim-lspconfig',
      config = r('lsp'),
      setup = function()
        vim.defer_fn(function()
          vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
        end, 0)
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      config = r('gitsigns'),
    }

    use {
      'junegunn/vim-easy-align',
      cmd = { 'EasyAlign' },
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      config = r('tree_sitter')
    }

    use {
      'norcalli/nvim-colorizer.lua',
      config = r('colorizer')
    }

    use {
      'lukas-reineke/indent-blankline.nvim',
      config = r('blankline'),
      setup = function()
        lazy_load "indent-blankline.nvim"
      end,
    }

    use {
      'windwp/nvim-autopairs',
      config = r('auto_pairs')
    }

    use {
      'b3nj5m1n/kommentary',
      config = r('kommentary'),
    }

    use {
      'nvim-neorg/neorg',
      ft = 'norg',
      config = r('neorg')
    }

    use 'anuvyklack/middleclass'
    use {
      'anuvyklack/windows.nvim',
      config = r('windows'),
    }

    use {
      'nvim-telescope/telescope.nvim',
      config = r('telescope'),
      tag = '0.1.0',
    }

    use {
      'hrsh7th/nvim-cmp',
      config = r('cmp'),
    }

    use {
      'L3MON4D3/LuaSnip',
      config = r('luasnip'),
    }

    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
    }

    -- use {
    --   '~/.config/nvim/theme',
    --   config = function()
    --     vim.cmd 'colorscheme theme'
    --   end
    -- }

    -- use {
    --   'Vonr/align.nvim'
    -- }

    if packer_bootstrap then
      require('packer').sync()
    end
  end
)

vim.api.nvim_create_user_command('PackerStatus', function()
  require('packer').status()
end, {})

vim.api.nvim_create_user_command('PackerSync', function()
  require('packer').sync()
end, {})
