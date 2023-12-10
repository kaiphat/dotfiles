local M = {}

M.has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
end

M.buffer_source = {
	name = 'buffer',
	option = {
		get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
		indexing_interval = 100,
		indexing_batch_size = 1000,
		max_indexed_line_length = 1024 * 40,
		keyword_pattern = [[\k\+]],
	},
}

M.source_comparator = function(item1, item2)
	local sources = {
		codeium = 60,
		nvim_lsp = 30,
		luasnip = 31,
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

M.get_format = function()
	return {
		fields = { 'kind', 'abbr', 'menu' },
		format = require('lspkind').cmp_format {
			mode = 'symbol',
			maxwidth = 40,
			ellipsis_char = '...',
			symbol_map = {
				TypeParameter = 'T',
				Codeium = '󰇈',
			},
		},
	}
end

M.get_mappings = function()
	local cmp = require 'cmp'
	local luasnip = require 'luasnip'

	return {
		['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
		['<C-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
		['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
		['<C-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-e>'] = cmp.mapping.complete(),
		-- ['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
		['<C-o>'] = cmp.mapping.confirm {
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
			elseif M.has_words_before() then
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
	}
end

return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-nvim-lsp',
		'saadparwaiz1/cmp_luasnip',
		'hrsh7th/cmp-buffer',
		'onsails/lspkind.nvim',
	},
	config = function()
		local cmp = require 'cmp'
		local types = require 'cmp.types'
		local luasnip = require 'luasnip'
		local compare = require 'cmp.config.compare'

		compare.locality.lines_count = 300

		cmp.setup {
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
				expand = function(args) luasnip.lsp_expand(args.body) end,
			},
			window = {
				completion = {
					border = 'rounded',
					winhighlight = 'NormalFloat:FloatBorder,CursorLine:Visual,Search:None',
					col_offset = -3,
					side_padding = 1,
					scrollbar = false,
				},
				documentation = {
					border = 'rounded',
					scrollbar = false,
					winhighlight = 'NormalFloat:FloatBorder,CursorLine:Visual,Search:None',
				},
			},
			formatting = M.get_format(),
			completion = {
				autocomplete = {
					types.cmp.TriggerEvent.TextChanged,
				},
				completeopt = 'menu,menuone,noinsert',
				keyword_length = 1,
			},
			matching = {
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_fuzzy_matching = true,
				disallow_partial_matching = false,
				disallow_prefix_unmatching = true,
			},
			mapping = M.get_mappings(),
			performance = {
				debounce = 60,
				throttle = 30,
				fetching_timeout = 500,
				confirm_resolve_timeout = 500,
				async_budget = 1,
				max_view_entries = 200,
			},
			sources = cmp.config.sources {
				{ name = 'codeium', group_index = 2 },
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				M.buffer_source,
				{ name = 'path' },
			},
			experimental = {
				ghost_text = {
					hl_group = 'LspCodeLens',
				},
			},
		}

		cmp.setup.filetype('norg', {
			sources = cmp.config.sources {
				{ name = 'neorg' },
				{ name = 'codeium' },
				{ name = 'luasnip' },
				{ name = 'path' },
				M.buffer_source,
			},
		})
	end,
}
