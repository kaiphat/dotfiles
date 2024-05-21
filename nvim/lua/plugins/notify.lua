local M = {}

M.col = function()
	return vim.opt.columns:get() - 1
end

M.get_stages = function()
	local stages_util = require 'notify.stages.util'

	return {
		function(state)
			local next_height = state.message.height + 2
			local next_row = stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.TOP_DOWN)

			if not next_row then
				return nil
			end
			if next_row == 0 then
				next_row = 1
			end
			return {
				relative = 'editor',
				anchor = 'NE',
				width = state.message.width,
				height = state.message.height,
				col = M.col(),
				row = next_row,
				border = 'rounded',
				style = 'minimal',
				opacity = 50,
			}
		end,
		function()
			return {
				opacity = { 100 },
				col = { M.col() },
			}
		end,
		function(state, win)
			local slot = stages_util.slot_after_previous(win, state.open_windows, stages_util.DIRECTION.TOP_DOWN)

			if slot == 0 then
				slot = 1
			end

			return {
				row = {
					slot,
					frequency = 30,
					complete = function()
						return true
					end,
				},
				col = { M.col() },
				time = true,
			}
		end,
		function()
			return {
				opacity = {
					0,
					frequency = 2,
					complete = function(cur_opacity)
						return cur_opacity <= 4
					end,
				},
				col = { M.col() },
			}
		end,
	}
end

return {
	'rcarriga/nvim-notify',
	event = 'BufReadPre',
	enabled = false,
	config = function()
		local notify = require 'notify'

		notify.setup {
			minimum_width = 40,
			fps = 30,
			-- stages = M.get_stages(stages_util),
			stages = 'static',
			render = 'minimal', -- wrapped-compact, minimal
			background_colour = 'NormalFloat',
		}

		vim.notify = notify
	end,
}
