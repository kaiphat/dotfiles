local telescope = load('telescope')
if not telescope then return end

local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')

local ignore_patterns = {
  'docker_volumes_data/',
  'data/',
  '.data/',
  'test/',
  '__mocks__/',
  '.git/',

  'package-lock.json',
  'yarn.lock',
  '*.log',
  '.gitignore',
  '*.md',
}

local vimgrep_arguments = {
  'rg',
  '--color=never',
  '--no-heading',
  '--with-filename',
  '--line-number',
  '--column',
  '--smart-case',
  '--trim',
  '--hidden',
}

local fd_arguments = {
  'fdfind',
  '-t',
  'f',
  '--hidden',
}

local add_ignore_patterns = function()
  for _, pattern in pairs(ignore_patterns) do
    table.insert(vimgrep_arguments, '-g')
    table.insert(vimgrep_arguments, '!'..pattern)
  end

  for _, pattern in pairs(ignore_patterns) do
    table.insert(fd_arguments, '-E')
    table.insert(fd_arguments, pattern)
  end
end

local add_no_ignore = function()
  table.insert(fd_arguments, '--no-ignore')
  table.insert(vimgrep_arguments, '--no-ignore')
end


add_ignore_patterns()
-- add_no_ignore()

telescope.setup {
  defaults = {
    vimgrep_arguments = vimgrep_arguments,
    prompt_prefix = " ",
    selection_caret = "﬌ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = 'top',
      -- preview_width = 0.55,
      preview_height = 0.6,
      horizontal = {
        preview_cutoff = 40,
        mirror = false,
        width = 0.95
      },
      vertical = {
        mirror = false,
        width = 0.95,
        height = 0.98,
      },
    },
    file_sorter =  sorters.get_fuzzy_file,
    generic_sorter =  sorters.get_generic_fuzzy_sorter,
    path_display = {},
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' },
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    buffer_previewer_maker = previewers.buffer_previewer_maker,
    mappings = {
      i = {
        ["<C-w>"] = function()
          vim.api.nvim_input "<c-s-w>"
        end,
      }
    }
  },
  extensions = {
    file_browser = {
      mappings = {
      }
    },
    -- fzf = {
    --   fuzzy = true,
    --   override_generic_sorter = true,
    --   override_file_sorter = true,
    --   case_mode = "ignore_case",
    -- }
  },
}

telescope.load_extension "file_browser"

map('n', '<leader>ff', function()
  require'telescope.builtin'.find_files {
    find_command = fd_arguments
  }
end)
map('n', '<leader>fe', function()
  require'telescope'.extensions.file_browser.file_browser {
    hidden = true,
    grouped = true
  }
end)
map('n', '<leader>fb', ':Telescope buffers<cr>')
map('n', '<leader>fs', ':Telescope git_status<cr>')
map('n', '<leader>fo', ':Telescope oldfiles<cr>')
map('n', '<leader>fp', ':Telescope resume<cr>')
map('n', '<leader>fi', function()
  require'telescope.builtin'.lsp_references {
    include_declaration = true,
    include_current_line = true,
    trim_text = true
  }
end)
map('n', '<leader>fg', function()
  require'telescope.builtin'.live_grep {
    hidden = true,
    disable_coordinates = true
  }
end)
map('n', '<leader>fh', function()
  local path = getCurrentPath()
  require'telescope'.extensions.file_browser.file_browser {
    cwd = path,
    hidden = true,
    grouped = true,
    hide_parent_dir = true
  }
end)

