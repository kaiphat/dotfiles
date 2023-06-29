local M = {}

M.col = function()
  return vim.opt.columns:get() - 1
end

M.client_notifs = {}

M.get_notif_data = function(client_id, token)
  if not M.client_notifs[client_id] then
    M.client_notifs[client_id] = {}
  end

  if not M.client_notifs[client_id][token] then
    M.client_notifs[client_id][token] = {}
  end

  return M.client_notifs[client_id][token]
end

M.spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' }

M.update_spinner = function(client_id, token, title)
  local state = M.get_notif_data(client_id, token)

  if state.spinner then
    local new_spinner = (state.spinner % #M.spinner_frames) + 1

    state.spinner = new_spinner
    state.notification = vim.notify(M.spinner_frames[new_spinner] .. ' ' .. title, nil, {
      hide_from_history = true,
      replace = state.notification,
    })

    if not state.is_report then
      vim.defer_fn(function()
        M.update_spinner(client_id, token, title)
      end, 100)
    end
  end
end

M.format_title = function(title, client_name)
  return client_name .. (#title > 0 and ': ' .. title or '')
end

M.format_message = function(message, percentage)
  return (percentage and percentage .. '%\t' or '') .. (message or '')
end

M.set_handlers = function()
  vim.lsp.handlers['$/progress'] = function(_, result, ctx)
    local client_id = ctx.client_id

    local val = result.value

    if not val.kind then
      return
    end

    local state = M.get_notif_data(client_id, result.token)
    local client_name = vim.lsp.get_client_by_id(client_id).name

    if val.kind == 'begin' then
      local title = M.format_title(val.title, client_name)

      state.notification = vim.notify(M.spinner_frames[1] .. ' ' .. title, 'info', {
        timeout = false,
      })

      state.spinner = 1
      M.update_spinner(client_id, result.token, title)
    elseif val.kind == 'report' and state then
      state.is_report = true

      state.notification = vim.notify(M.format_message(val.message, val.percentage), 'info', {
        replace = state.notification,
      })
    elseif val.kind == 'end' and state then
      state.notification = vim.notify(client_name .. ': complete', 'info', {
        replace = state.notification,
        timeout = 2000,
      })

      state.spinner = nil
    end
  end
end

M.get_stages = function(stages_util)
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
  config = function()
    local notify = require 'notify'
    local stages_util = require 'notify.stages.util'

    -- M.set_handlers()

    notify.setup {
      -- max_width = 40,
      minimum_width = 40,
      fps = 60,
      -- on_open = function(win)
      --   vim.wo[win].wrap = true
      --   vim.api.nvim_win_set_option(win, 'wrap', true)
      -- end,
      stages = M.get_stages(stages_util),
      render = 'minimal',
      background_colour = 'NormalFloat',
    }

    vim.notify = notify
  end,
}
