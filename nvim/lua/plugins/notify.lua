local notify = load 'notify'
if not notify then return end

local stages_util = require("notify.stages.util")

local col = vim.opt.columns:get() - 1

notify.setup {
  max_width = 60,
  minimum_width = 30,
  fps = 60,
  on_open = function(win)
    vim.wo[win].wrap = true
    vim.api.nvim_win_set_option(win, 'wrap', true)
  end,
  stages = {
    function(state)
      local next_height = state.message.height
      local next_row = stages_util.available_slot(state.open_windows, next_height, stages_util.DIRECTION.TOP_DOWN)
      if not next_row then
        return nil
      end
      return {
        relative = "editor",
        anchor = "NE",
        width = state.message.width,
        height = state.message.height,
        col = col,
        row = next_row + 1,
        border = "rounded",
        style = "minimal",
        opacity = 0,
      }
    end,
    function()
      return {
        opacity = { 100 },
        col = { col },
      }
    end,
    function()
      return {
        col = { col },
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
        col = { col },
      }
    end,
  },
  render = 'minimal',
}

vim.notify = notify
