-- local M = {}
--
-- M.has_words_before = function()
-- 	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
-- 	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
-- end
--
-- M.source_comparator = function(item1, item2)
-- 	local sources = {
-- 		nvim_lsp = 30,
-- 		luasnip = 31,
-- 		buffer = 20,
-- 	}
--
-- 	local a = sources[item1.source.name] or 0
-- 	local b = sources[item2.source.name] or 0
--
-- 	if a == b then
-- 		return nil
-- 	else
-- 		return a > b
-- 	end
-- end
--
-- M.get_sources = function()
-- 	local cmp = require 'cmp'
--
-- 	return cmp.config.sources {
-- 		{ name = 'nvim_lsp' },
-- 		{ name = 'luasnip' },
-- 		{ name = 'path' },
-- 		{
-- 			name = 'buffer',
-- 			option = {
-- 				get_bufnrs = function()
-- 					local bufs = {}
--
-- 					for _, win in ipairs(vim.api.nvim_list_wins()) do
-- 						table.insert(bufs, vim.api.nvim_win_get_buf(win))
-- 					end
--
-- 					return bufs
-- 				end,
-- 				indexing_interval = 300,
-- 				indexing_batch_size = 100,
-- 				max_indexed_line_length = 1024 * 400,
-- 				keyword_pattern = [[\k\+]],
-- 			},
-- 		},
-- 		{ name = 'neorg' }
-- 	}
-- end
--
-- M.get_format = function()
-- 	return {
-- 		fields = { 'kind', 'abbr', 'menu' },
--
-- 		format = function(entry, vim_item)
-- 			local kind = require('lspkind').cmp_format {
-- 				mode = 'symbol_text',
-- 				maxwidth = 40,
-- 				-- preset = 'default',
-- 			}(entry, vim_item)
--
-- 			local strings = vim.split(kind.kind, '%s', { trimempty = true })
--
-- 			if strings[1] == 'TypeParameter' then strings[1] = 'T' end
--
-- 			kind.kind = ' ' .. strings[1] .. ' '
-- 			kind.menu = entry.completion_item.detail
--
-- 			return kind
-- 		end,
-- 	}
-- end
--
-- M.get_mappings = function()
-- 	local cmp = require 'cmp'
-- 	local luasnip = require 'luasnip'
--
-- 	return {
-- 		['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
-- 		['<C-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
-- 		['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
-- 		['<C-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
-- 		['<C-d>'] = cmp.mapping.scroll_docs(-4),
-- 		['<C-f>'] = cmp.mapping.scroll_docs(4),
-- 		['<C-e>'] = cmp.mapping.complete(),
-- 		-- ['<C-e>'] = cmp.mapping.close(),
-- 		['<CR>'] = cmp.mapping.confirm {
-- 			behavior = cmp.ConfirmBehavior.Insert,
-- 			select = true,
-- 		},
-- 		['<C-o>'] = cmp.mapping.confirm {
-- 			behavior = cmp.ConfirmBehavior.Insert,
-- 			select = true,
-- 		},
-- 		['<Tab>'] = cmp.mapping(function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
-- 			elseif luasnip.expandable() then
-- 				luasnip.expand()
-- 			elseif luasnip.expand_or_jumpable() then
-- 				luasnip.expand_or_jump()
-- 			elseif M.has_words_before() then
-- 				cmp.complete()
-- 			else
-- 				fallback()
-- 			end
-- 		end, { 'i', 's' }),
-- 		['<S-Tab>'] = cmp.mapping(function(fallback)
-- 			if cmp.visible() then
-- 				cmp.select_prev_item()
-- 			elseif require('luasnip').jumpable(-1) then
-- 				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
-- 			else
-- 				fallback()
-- 			end
-- 		end, { 'i', 's' }),
-- 	}
-- end
--
-- M.add_autocmd = function()
-- 	vim.api.nvim_create_autocmd({ 'TextChangedI', 'TextChangedP' }, {
-- 		callback = function()
-- 			local line = vim.api.nvim_get_current_line()
-- 			local cursor = vim.api.nvim_win_get_cursor(0)[2]
--
-- 			local current = string.sub(line, cursor, cursor + 1)
-- 			if current == '.' or current == ',' or current == ' ' then require('cmp').close() end
--
-- 			local before_line = string.sub(line, 1, cursor + 1)
-- 			local after_line = string.sub(line, cursor + 1, -1)
-- 			if not string.match(before_line, '^%s+$') then
-- 				if after_line == '' or string.match(before_line, ' $') or string.match(before_line, '%.$') then
-- 					require('cmp').complete()
-- 				end
-- 			end
-- 		end,
-- 		pattern = '*',
-- 	})
-- end
--
-- return {
-- 	'hrsh7th/nvim-cmp',
-- 	event = 'InsertEnter',
-- 	dependencies = {
-- 		'hrsh7th/cmp-path',
-- 		'hrsh7th/cmp-nvim-lsp',
-- 		'saadparwaiz1/cmp_luasnip',
-- 		'hrsh7th/cmp-buffer',
-- 		'onsails/lspkind.nvim',
-- 	},
-- 	config = function()
-- 		local cmp = require 'cmp'
-- 		local types = require 'cmp.types'
-- 		local luasnip = require 'luasnip'
-- 		local compare = require 'cmp.config.compare'
--
-- 		compare.locality.lines_count = 300
--
-- 		cmp.setup {
-- 			preselect = cmp.PreselectMode.Item,
-- 			sorting = {
-- 				priority_weight = 2,
-- 				comparators = {
-- 					compare.offset,
-- 					compare.exact,
-- 					-- compare.scopes,
-- 					compare.score,
-- 					compare.recently_used,
-- 					compare.locality,
-- 					compare.kind,
-- 					-- compare.sort_text,
-- 					compare.length,
-- 					compare.order,
-- 				},
-- 			},
-- 			snippet = {
-- 				expand = function(args) luasnip.lsp_expand(args.body) end,
-- 			},
-- 			window = {
-- 				completion = {
-- 					border = 'rounded',
-- 					winhighlight = 'NormalFloat:FloatBorder,CursorLine:Visual,Search:None',
-- 					col_offset = -4,
-- 					side_padding = 0,
-- 					scrollbar = false,
-- 				},
-- 				documentation = {
-- 					border = 'rounded',
-- 					scrollbar = false,
-- 					winhighlight = 'NormalFloat:FloatBorder,CursorLine:Visual,Search:None',
-- 				},
-- 			},
-- 			formatting = M.get_format(),
-- 			completion = {
-- 				autocomplete = {
-- 					types.cmp.TriggerEvent.TextChanged,
-- 				},
-- 				completeopt = 'menu,menuone,noinsert',
-- 				keyword_length = 1,
-- 			},
-- 			matching = {
-- 				disallow_fuzzy_matching = true,
-- 				disallow_fullfuzzy_matching = true,
-- 				disallow_partial_fuzzy_matching = true,
-- 				disallow_partial_matching = false,
-- 				disallow_prefix_unmatching = true,
-- 			},
-- 			mapping = M.get_mappings(),
-- 			performance = {
-- 				debounce = 100,
-- 				throttle = 100,
-- 				fetching_timeout = 1000,
-- 			},
-- 			sources = M.get_sources(),
-- 			experimental = {
-- 				ghost_text = {
-- 					hl_group = 'LspCodeLens',
-- 				},
-- 			},
-- 		}
-- 	end,
-- }
--
--

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
				expand = function(args) luasnip.lsp_expand(args.body) end,
			},
			window = {
				completion = {
					border = 'rounded',
					winhighlight = 'NormalFloat:FloatBorder,CursorLine:Visual,Search:None',
					col_offset = -4,
					side_padding = 0,
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
				debounce = 100,
				throttle = 100,
				fetching_timeout = 1000,
			},
			sources = M.get_sources(),
			experimental = {
				ghost_text = {
					hl_group = 'LspCodeLens',
				},
			},
		}
	end,
}
