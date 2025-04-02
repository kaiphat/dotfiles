return {
	{
		'folke/flash.nvim',
		event = 'VeryLazy',
		enabled = false,
		opts = {
			labels = 'jkldfsaghqweruiopzxcvnmt',
			search = {
				multi_window = false,
				-- * exact: exact match -- default
				-- * search: regular search
				-- * fuzzy: fuzzy search
				mode = 'exact',
				-- incremental = true,
			},
			label = {
				-- just in current position
				after = { 0, 0 },
				before = false,
			},
			modes = {
				search = {
					enabled = false,
				},
				char = {
					enabled = true,
					config = function(opts) end,
					autohide = true,
					jump_labels = false,
					highlight = {
						matches = false,
						backdrop = false,
					},
				},
			},
		},
		keys = {
			-- {
			-- 	's',
			-- 	function()
			-- 		local Flash = require 'flash'
			--
			-- 		local function format(opts)
			-- 			return {
			-- 				{ opts.match.label1, 'FlashMatch' },
			-- 				{ opts.match.label2, 'FlashLabel' },
			-- 			}
			-- 		end
			--
			-- 		Flash.jump {
			-- 			search = { mode = 'search' },
			-- 			label = {
			-- 				after = false,
			-- 				before = { 0, 0 },
			-- 				uppercase = false,
			-- 				format = format,
			-- 			},
			-- 			action = function(match, state)
			-- 				state:hide()
			-- 				Flash.jump {
			-- 					search = { max_length = 0 },
			-- 					highlight = { matches = false },
			-- 					label = { format = format },
			-- 					matcher = function(win)
			-- 						-- limit matches to the current label
			-- 						return vim.tbl_filter(function(m)
			-- 							return m.label == match.label and m.win == win
			-- 						end, state.results)
			-- 					end,
			-- 					labeler = function(matches)
			-- 						for _, m in ipairs(matches) do
			-- 							m.label = m.label2 -- use the second label
			-- 						end
			-- 					end,
			-- 				}
			-- 			end,
			-- 			labeler = function(matches, state)
			-- 				local from = vim.api.nvim_win_get_cursor(0)
			--
			-- 				table.sort(matches, function(a, b)
			-- 					local dfrom = from[1] * vim.go.columns + from[2]
			-- 					local da = a.pos[1] * vim.go.columns + a.pos[2]
			-- 					local db = b.pos[1] * vim.go.columns + b.pos[2]
			-- 					return math.abs(dfrom - da) < math.abs(dfrom - db)
			-- 				end)
			--
			-- 				local labels = state:labels()
			--
			-- 				for m, match in ipairs(matches) do
			-- 					match.label1 = labels[math.floor((m - 1) / #labels) + 1]
			-- 					match.label2 = labels[(m - 1) % #labels + 1]
			-- 					match.label = match.label1
			-- 				end
			-- 			end,
			-- 		}
			-- 	end,
			-- },
		},
	},
}
