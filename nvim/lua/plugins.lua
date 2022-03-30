vim.cmd('packadd packer.nvim')

local packer = require'packer'

packer.init {
  git = {
    clone_timeout = 6000
  },
  display = {
    open_fn = function()
      return require('packer.util').float { border = 'single' }
    end
  },
  auto_clean = true,
  compile_on_sync = true,
}

return packer.startup (
  function(use)
    use {
      'wbthomason/packer.nvim',
      event = 'VimEnter'
    }

    use {
      'neovim/nvim-lspconfig',
      after = 'packer.nvim',
      config = function()
        require 'plugins.lsp'
      end
    }

    use {
      'feline-nvim/feline.nvim',
      after = 'theme',
      config = 'require "plugins.statusline"'
    }

    use {
      'nvim-lua/plenary.nvim'
    }

    use {
      'nvim-lua/popup.nvim',
      after = 'plenary.nvim',
    }

    use {
      'lewis6991/gitsigns.nvim',
      event = 'BufRead',
      config = function()
        require 'plugins.gitsigns'
      end
    }

    use {
      'windwp/nvim-autopairs',
      after = 'nvim-cmp',
      event = 'InsertEnter',
      config = function()
        require 'plugins.auto_pairs'
      end
    }

    use {
      'hrsh7th/nvim-cmp',
      -- event = 'InsertEnter',
      config = function()
        require 'plugins.cmp'
      end,
    }

   use {
      'hrsh7th/cmp-nvim-lsp',
      after = 'nvim-cmp',
   }

   use {
      'hrsh7th/cmp-buffer',
      after = 'cmp-nvim-lsp',
   }

   use {
     'hrsh7th/vim-vsnip',
      after = 'cmp-buffer'
   }

    -- !!!!
    -- use {
    --   'ms-jpq/coq_nvim',
    --   branch = 'coq'
    -- }

    use {
      'kyazdani42/nvim-tree.lua',
      cmd = {
        'NvimTreeToggle',
        'NvimTreeClose',
        'NvimTreeOpen',
      },
      config = function()
        require 'plugins.nvim_tree'
      end
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      event = 'VimEnter',
      config = function()
        require 'plugins.tree_sitter'
      end
    }

    use {
      'nvim-telescope/telescope.nvim',
      module = "telescope",
      cmd = "Telescope",
      requires = {
         {
            "nvim-telescope/telescope-file-browser.nvim",
         },
      },
      config = function()
        require 'plugins.telescope'
      end
    }

    use { "nvim-telescope/telescope-file-browser.nvim" }

    use {
      'Pocco81/TrueZen.nvim',
      cmd = {
        'TZAtaraxis',
        'TZMinimalist',
        'TZFocus'
      },
      config = function()
        require 'plugins.zen'
      end
    }

    use {
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufRead',
      config = function()
        require('plugins.blankline')
      end
    }

    use {
      'norcalli/nvim-colorizer.lua',
      after = 'packer.nvim',
      config = function()
        require('plugins.colorizer')
      end
    }

    use {
      'kyazdani42/nvim-web-devicons',
      after = 'lush.nvim',
    }

    use {
      'phaazon/hop.nvim',
      cmd = { 'HopChar1' },
      config = function()
        require 'plugins.hop'
      end
    }

    use {
      'b3nj5m1n/kommentary',
      event = 'BufRead',
      config = function()
        require 'plugins.kommentary'
      end
    }

    use {
      'sindrets/diffview.nvim',
      cmd = { 'DiffviewOpen' },
      config = function()
        require 'plugins.diffview'
      end
    }

    use {
      'junegunn/vim-easy-align',
      cmd = { 'EasyAlign' },
    }

    use {
      'alvan/vim-closetag',
      config = function()
        require 'plugins.closetag'
      end
    }

    use {
      'tpope/vim-fugitive',
      cmd = {
        'Git'
      }
    }

    use {
      '~/.config/nvim/theme',
      after = 'lush.nvim',
      config = function()
        vim.cmd 'colorscheme theme'
      end
    }

    use {
      'rktjmp/lush.nvim'
    }

    use {
      'j-hui/fidget.nvim',
      config = 'require"plugins.fidget"'
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      config = 'require"plugins.null"'
    }

    use {
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'make'
    }

    use {
      'L3MON4D3/LuaSnip',
      config = 'require"plugins.luasnip"'
    }

  end
)

