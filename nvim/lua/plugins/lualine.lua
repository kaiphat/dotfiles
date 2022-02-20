function clone(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[clone(orig_key)] = clone(orig_value)
        end
        setmetatable(copy, clone(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

local colors = {
  lightest_blue = '#404060',
  cyan          = '#a3b8ef',
  light_blue    = '#9398cf',
}

local active_mode = {
  a = { fg = colors.lightest_blue, bg = colors.cyan },
  b = { fg = colors.lightest_blue, bg = colors.lightest_blue },
  c = { fg = colors.lightest_blue, bg = colors.lightest_blue },
  x = { fg = colors.lightest_blue, bg = colors.lightest_blue },
  y = { fg = colors.lightest_blue, bg = colors.light_blue },
  z = { fg = colors.lightest_blue, bg = colors.cyan },
}

local inactive_mode = {
  a = { fg = colors.cyan, bg = colors.lightest_blue },
  b = { fg = colors.cyan, bg = colors.lightest_blue },
  c = { fg = colors.cyan, bg = colors.lightest_blue },
  x = { fg = colors.cyan, bg = colors.lightest_blue },
  y = { fg = colors.cyan, bg = colors.lightest_blue },
  z = { fg = colors.cyan, bg = colors.lightest_blue },
}

local theme = {
 normal = clone(active_mode),
 insert = clone(active_mode),
 visual = clone(active_mode),
 replace = clone(active_mode),
 inactive = clone(inactive_mode),
}

local getPath = function()
  local path = vim.fn.expand('%:p')
  path = path:gsub("%/home/ilya/work/", "")
  path = path:gsub("%/home/ilya", "~")
  return path
end

local checkPath = function()
  return getPath() == ''
end

local getPosition = function()
  local current_line = vim.fn.line(".")
  local total_line = vim.fn.line("$")

  if current_line < 10 then
    current_line = '00' .. current_line
  elseif current_line < 100 and current_line > 9 then
    current_line = '0' .. current_line
  end

  if total_line < 10 then
    total_line = '00' .. total_line
  elseif total_line < 100 and total_line > 9 then
    total_line = '0' .. total_line
  end

  return ' '..current_line..':'..total_line
end

local getTime = function()
  return os.date('%H:%M')
end

local getGitData = function(type)
  local signs = vim.b.gitsigns_status_dict or {head = 0, added = 0, changed = 0, removed = 0}
  return signs[type]
end

local getBranch = function() 
  local head = getGitData('head')
  if head == '' then return '' end
  return ' '..head
end

local getLspInfo = function() 
  local diagnosticList = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  return { errors = table.getn(diagnosticList) }
end

local checkDiff = function(type)
  return function()
    local value = getGitData(type) or 0
    if value == 0 or checkPath() then return false end
    return true
  end
end

local getDiff = function(symbol, type)
  return function()
    if not checkDiff(type)() then return '' end
    return symbol..getGitData(type)
  end
end

local checkErrors = function()
  local value = getLspInfo().errors or 0  
  if value == 0 or checkPath() then return false end
  return true
end

local getErrors = function()
  if not checkErrors() then return '' end
  return '✗'..getLspInfo().errors
end

require'lualine'.setup {
  options = {
    theme = theme,
    component_separators = {''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = { 'NvimTree' },
    always_divide_middle = true
  },
  sections = {
    lualine_a = { getPath },
    lualine_b = {
      {
        getDiff('+', 'added'),
        cond = checkDiff('added'),
        color = { fg = '#7eca9c' }
      },
      {
        getDiff('~', 'changed'),
        cond = checkDiff('changed'),
        color = { fg = '#EBCB8B' }
      },
      {
        getDiff('-', 'removed'),
        cond = checkDiff('removed'),
        color = { fg = '#e06c75' }
      },
      {
        getErrors,
        cond = checkErrors,
        color = { fg = '#ff75a0' }
      }
    },
    lualine_c = {},
    lualine_x = {
      {
        getDiff(' ', 'head'),
        color = { fg = '#EBCB8B' }
      }
    },
    lualine_y = { getPosition },
    lualine_z = { getTime }
  },
  inactive_sections = {
    lualine_a = { getPath, },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  }
}

