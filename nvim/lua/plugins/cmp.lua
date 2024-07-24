local function get_mappings(cmp)
	return {
		['<C-j>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				return cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
			else
				return cmp.complete()
			end
		end, { 'i', 's' }),
		['<C-k>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				return cmp.select_prev_item { behavior = cmp.SelectBehavior.Insert }
			else
				return cmp.complete()
			end
		end, { 'i', 's' }),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-o>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
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
		-- 'zbirenbaum/copilot-cmp',
		-- 'zbirenbaum/copilot.lua',
	},
	config = function()
		local cmp = require 'cmp'
		local types = require 'cmp.types'
		local luasnip = require 'luasnip'
		local compare = require 'cmp.config.compare'

		-- require('copilot_cmp').setup()

		compare.locality.lines_count = 300

		cmp.setup {
			sorting = {
				priority_weight = 2,
				-- comparators = {
				-- 	-- require('copilot_cmp.comparators').prioritize,
				--
				-- 	compare.offset,
				-- 	compare.exact,
				-- 	-- compare.scopes,
				-- 	compare.score,
				-- 	compare.recently_used,
				-- 	compare.locality,
				-- 	compare.kind,
				-- 	-- compare.sort_text,
				-- 	compare.length,
				-- 	compare.order,
				-- },
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
			formatting = {
				fields = { 'kind', 'abbr', 'menu' },
				format = function(entry, vim_item)
					-- replace kind with mini lsp icon
					local icon, _ = require('mini.icons').get('lsp', vim_item.kind)
					if icon ~= nil then
						vim_item.kind = icon
					end
					return vim_item
				end,
			},
			completion = {
				autocomplete = {
					types.cmp.TriggerEvent.TextChanged,
					types.cmp.TriggerEvent.InsertEnter,
				},
				completeopt = 'menuone,noinsert,preview',
				keyword_length = 0,
			},
			matching = {
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_fuzzy_matching = true,
				disallow_partial_matching = false,
				disallow_prefix_unmatching = true,
			},
			mapping = get_mappings(cmp),
			performance = {
				debounce = 60,
				throttle = 30,
				fetching_timeout = 500,
				confirm_resolve_timeout = 500,
				async_budget = 1,
				max_view_entries = 50,
			},
			sources = cmp.config.sources({
				-- { name = 'copilot', keyword_length = 1, priority = 200 },
				{ name = 'luasnip', keyword_length = 2, priority = 100 },
				{ name = 'nvim_lsp', keyword_length = 1, priority = 100 },
				{ name = 'path', keyword_length = 0, priority = 110 },
			}, {
				{
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
					keyword_length = 1,
					priority = 99,
				},
			}),
			experimental = {
				ghost_text = {
					hl_group = 'LspCodeLens',
				},
			},
		}

		cmp.setup.filetype('sql', {
			sources = {
				{ name = 'vim-dadbod-completion' },
				{ name = 'buffer' },
			},
		})
	end,
}
