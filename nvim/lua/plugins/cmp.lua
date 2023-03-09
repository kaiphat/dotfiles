local function has_words_before()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

local function source_comparator(item1, item2)
  local sources = {
    nvim_lsp = 30,
    luasnip = 31,
    treesitter = 30,
    buffer = 20,
  }

  local a = sources[item1.source.name] or 0
  local b = sources[item2.source.name] or 0

  if a == b then
    return nil
  else
    return a > b
  end
end

return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-buffer',
    'ray-x/cmp-treesitter',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local compare = require 'cmp.config.compare'

    compare.locality.lines_count = 300

    cmp.setup {
      preselect = cmp.PreselectMode.Item,
      sorting = {
        priority_weight = 2,
        comparators = {
          compare.offset,
          compare.exact,
          -- compare.scopes,
          compare.score,
          compare.recently_used,
          compare.locality,
          compare.kind,
          -- compare.sort_text,
          compare.length,
          compare.order,
        },
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = {
          border = 'rounded',
          winhighlight = 'NormalFloat:FloatBorder,CursorLine:Visual,Search:None',
          col_offset = -2,
          side_padding = 0,
          scrollbar = false,
        },
        documentation = {
          border = 'rounded',
          scrollbar = false,
          winhighlight = 'NormalFloat:FloatBorder,CursorLine:Visual,Search:None',
        },
      },
      formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
          local is_treesitter = entry.source.name == 'treesitter'

          local kind = require('lspkind').cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            preset = 'default',
          }(entry, vim_item)

          local strings = vim.split(kind.kind, '%s', { trimempty = true })

          if is_treesitter then
            kind.kind = ' ' .. ''
          else
            kind.kind = ' ' .. strings[1]
          end
          kind.menu = ' '

          return kind
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
        keyword_length = 0,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        -- ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require('luasnip').jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      performance = {},
      sources = cmp.config.sources {
        {
          name = 'nvim_lsp',
        },
        {
          name = 'luasnip',
        },
        {
          name = 'path',
        },
        {
          name = 'buffer',
          option = {
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
            keyword_pattern = [[\k\+]],
          },
        },
        {
          name = 'treesitter',
        },
      },
      experimental = {
        ghost_text = {
          hl_group = 'LspCodeLens',
        },
      },
    }
  end,
}
