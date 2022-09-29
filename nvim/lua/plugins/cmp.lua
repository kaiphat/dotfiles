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
      local luasnip = load('luasnip')
      if not luasnip then return end

      luasnip.lsp_expand(args.body)
    end
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = function(entry, vim_item)
      local icon = require 'sources.icons'.icons[vim_item.kind]

      vim_item.kind = string.format('%s %s', icon, vim_item.kind)
      vim_item.menu = sources[entry.source.name]

      return vim_item
    end,
  },
  mapping = cmp.mapping.preset.insert {
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
  sources = cmp.config.sources {
    {
      name = 'luasnip',
      priority = 10
    },
    {
      name = 'nvim_lsp',
      priority = 9
    },
    {
      name = 'path',
      priority = 8
    },
    {
      name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      },
      priority = 7
    },
  }
}
