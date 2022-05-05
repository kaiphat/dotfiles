local Input = require("nui.input")
local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event

-- INPUT UI --
local input_ui

vim.ui.input = function(opts, on_confirm)
  if input_ui then
    -- ensure single ui.input operation
    vim.api.nvim_err_writeln("busy: another input is pending!")
    return
  end

  local function on_done(value)
    if input_ui then
      -- if it's still mounted, unmount it
      input_ui:unmount()
    end
    -- pass the input value
    on_confirm(value)
    -- indicate the operation is done
    input_ui = nil
  end

  local border_top_text = opts.prompt or "[Input]"
  local default_value = opts.default

  input_ui = Input({
    relative = "cursor",
    position = {
      row = 1,
      col = 0,
    },
    size = {
      -- minimum width 20
      width = math.max(20, type(default_value) == "string" and #default_value or 0),
    },
    border = {
      style = "rounded",
      highlight = "Normal",
      text = {
        top = border_top_text,
        top_align = "left",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal",
    },
  }, {
    default_value = default_value,
    on_close = function()
      on_done(nil)
    end,
    on_submit = function(value)
      on_done(value)
    end,
  })

  input_ui:mount()

  -- cancel operation if cursor leaves input
  input_ui:on(event.BufLeave, function()
    on_done(nil)
  end, { once = true })

  -- cancel operation if <Esc> is pressed
  input_ui:map("n", "<Esc>", function()
    on_done(nil)
  end, { noremap = true, nowait = true })
end

-- SELECT UI --
local select_ui = nil

vim.ui.select = function(items, opts, on_choice)
  if select_ui then
    vim.api.nvim_err_writeln("busy: another select is pending!")
    return
  end

  local function on_done(item, index)
    if select_ui then
      select_ui:unmount()
    end
    on_choice(item, index)
    select_ui = nil
  end

  local border_top_text = opts.prompt or "[Choose Item]"
  local kind = opts.kind or "unknown"
  local format_item = opts.format_item or tostring

  local relative = "editor"
  local position = "50%"

  if kind == "codeaction" then
    relative = "cursor"
    position = {
      row = 1,
      col = 0,
    }
  end

  local max_width = vim.api.nvim_win_get_width(0)
  local max_text_length = 0

  local menu_items = {}
  for index, item in ipairs(items) do
    item.index = index
    -- local item_text = string.sub(format_item(item), 0, max_width)
    local item_text = format_item(item)
    if #item_text > 0 then 
      if #item_text > max_width - 4 then
        max_text_length = max_width - 4
      else
        max_text_length = #item_text 
      end
    end
    table.insert(menu_items, Menu.item(item_text, item))
  end

  select_ui = Menu({
    relative = relative,
    position = position,
    border = {
      style = "rounded",
      text = {
        top = border_top_text,
        top_align = "center",
      },
    },
    size = {
      width = 20,
      height = 2
    }
  }, {
    max_width = 20,
    lines = {
      Menu.item("Item 1"),
    Menu.item("Item 2"),
    },
    on_close = function()
      on_done(nil, nil)
    end,
    on_submit = function(item)
      on_done(item, item.index)
    end,
  })

  select_ui:mount()

  select_ui:on(event.BufLeave, function()
    on_done(nil, nil)
  end, { once = true })
end
