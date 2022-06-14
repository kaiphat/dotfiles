local packer = load("packer")
if not packer then return end

local function r(path)
  return 'require"plugins.'..path..'"'
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

packer.startup (
  function(use)
    use {
      'wbthomason/packer.nvim',
      'nvim-lua/plenary.nvim',
      'rktjmp/lush.nvim',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp',
      'ray-x/lsp_signature.nvim',
      'lewis6991/impatient.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
      'nvim-treesitter/nvim-treesitter-context',
    }

    use {
      'ggandor/lightspeed.nvim',
      config = r('lightspeed')
    }
    use {
      'nvim-lua/popup.nvim',
      after = 'plenary.nvim',
    }

    use {
      '~/.config/nvim/theme',
      config = function()
        vim.cmd 'colorscheme theme'
      end
    }

    use {
      'kyazdani42/nvim-web-devicons',
      after = 'theme',
    }

    use {
      'feline-nvim/feline.nvim',
      after = 'nvim-web-devicons',
      config = r('statusline'),
    }

    use {
      'j-hui/fidget.nvim',
      after = 'nvim-lspconfig',
      config = r('fidget')
    }

    use {
      'jose-elias-alvarez/null-ls.nvim',
      after = 'nvim-lspconfig',
      config = r('null')
    }

    use {
      'neovim/nvim-lspconfig',
      config = r('lsp'),
      after = 'feline.nvim',
      setup = function()
        vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end
    }

    use {
      'lewis6991/gitsigns.nvim',
      after = 'feline.nvim',
      config = r('gitsigns'),
    }

    use {
      'NTBBloodbath/rest.nvim',
      opt = true,
      ft = { 'http' },
      config = r('rest'),
    }

    use {
      'alvan/vim-closetag',
      event = 'InsertEnter',
      config = r('closetag')
    }

    use {
      'junegunn/vim-easy-align',
      cmd = { 'EasyAlign' },
    }

    use {
      'kyazdani42/nvim-tree.lua',
      cmd = {
        'NvimTreeToggle',
        'NvimTreeClose',
        'NvimTreeOpen',
      },
      config = r('nvim_tree')
    }

    use {
      'nvim-treesitter/nvim-treesitter',
      config = r('tree_sitter')
    }

    use {
      'norcalli/nvim-colorizer.lua',
      event = 'BufRead',
      config = r('colorizer')
    }

    use {
      'lukas-reineke/indent-blankline.nvim',
      event = 'BufRead',
      config = r('blankline'),
      setup = function()
        lazy_load "indent-blankline.nvim"
      end,
    }

    use {
      'windwp/nvim-autopairs',
      after = 'nvim-cmp',
      event = 'InsertEnter',
      config = r('auto_pairs')
    }

    use {
      'b3nj5m1n/kommentary',
      config = r('kommentary'),
    }

    use {
      'nvim-neorg/neorg',
      ft = 'norg',
      after = 'nvim-treesitter',
      config = r('neorg')
    }

    use {
      'beauwilliams/focus.nvim',
      event = { 'BufRead' },
      config = r('focus')
    }

    use {
      'nvim-telescope/telescope.nvim',
      config = r('telescope'),
    }

    use {
      'hrsh7th/nvim-cmp',
      config = r('cmp'),
    }

    use {
      'L3MON4D3/LuaSnip',
      config = r('luasnip'),
      after = 'nvim-cmp'
    }

    use {
      'saadparwaiz1/cmp_luasnip',
      after = 'LuaSnip'
    }

    use {
      'hrsh7th/cmp-buffer',
      after = 'cmp_luasnip',
    }

    -- use {
    --   'Vonr/align.nvim'
    -- }
  end
)

