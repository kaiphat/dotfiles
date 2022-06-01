local cmp = load('cmp')
if not cmp then return end

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
      local luasnip = u.load('luasnip')
      if not luasnip then return end

      luasnip.lsp_expand(args.body)
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
    -- ['<C-e>'] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'luasnip' },
    {
      name = 'nvim_lsp',
      -- max_item_count = 10,
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
  },
  experimental = {
    native_menu = false
  }
}
