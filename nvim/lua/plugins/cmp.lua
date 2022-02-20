local cmp = require 'cmp'

local sources = {
  buffer     = '[BUF]',
  nvim_lsp   = '[LSP]',
  path       = '[PATH]',
  treesitter = '[TS]',
  spell      = '[SP]',
  neorg      = '[NEO]'
}

cmp.setup {
  snippet = {
    expand = function(args) 
      vim.fn['vsnip#anonymous'](args.body)
    end
  },
  formatting = {
    format = function(entry, vim_item)
      local icon = require 'sources.icons'.icons[vim_item.kind]

      vim_item.kind = string.format('%s %s', icon, vim_item.kind)
      vim_item.menu = sources[entry.source.name]

      return vim_item
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  },
  sources = {
    {
      name = 'nvim_lsp',
      max_item_count = 10,
    },
    {
      name = 'buffer',
      max_item_count = 10,
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      }
    },
    { name = 'path' },
    { name = 'spell' },
    { name = 'treesitter' },
    { name = 'neorg' }
  },
  experimental = {
    native_menu = false
  }
}
