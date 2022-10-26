local u = require 'utils'

local Job = load("plenary.job")
if not Job then return end

local telescope = load('telescope')
if not telescope then return end

local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')
local themes = require("telescope.themes")

local ignore_patterns = {
  'docker_volumes_data/',
  'node_modules/',
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

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
    },
    file_ignore_patterns = {},

    prompt_prefix = "  ",
    selection_caret = " ",
    entry_prefix = " ",

    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    -- layout_strategy = "horizontal",
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = 'top',
      horizontal = {
        preview_height = 0.6,
        preview_cutoff = 40,
        width = 0.95
      },
      vertical = {
        preview_height = 0.6,
        width = 0.7,
        height = 0.96,
      },
      cursor = {
        width = 50,
        height = 14,
        borderchars = {
          prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
          results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
          preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
      },
    },
    file_sorter = sorters.get_fuzzy_file,
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    path_display = { 'truncate' },
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
    results_title = '',
    mappings = {
      i = {
        ["<C-w>"] = function()
          vim.api.nvim_input "<c-s-w>"
        end,
      }
    },
  },

  extensions = {
    file_browser = {
      layout_config = {
        prompt_position = 'top',
        vertical = {
          preview_height = 0.3,
          width = 0.7,
          height = 0.96,
        },
      },
      mappings = {
      }
    },

    ['ui-select'] = {
      themes.get_cursor()
    },

    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  },
}

telescope.load_extension 'fzf'
telescope.load_extension 'file_browser'
telescope.load_extension 'ui-select'

map('n', '<leader>ff', function()
  require 'telescope.builtin'.find_files {
    find_command = {
      'fdfind',
      '-t',
      'f',
      '-E', 'node_modules/',
      '-E', '.git/',
    },
    hidden = true,
    no_ignore = true,
  }
end)

map('n', '<leader>fj', function()
  require 'telescope.builtin'.find_files {
    hidden = false,
    no_ignore = false,
  }
end)

-- map('n', '<leader>ff', function()
--   local fd_arguments = {
--     'fdfind',
--     '-t',
--     'f',
--   }

--   for _, pattern in pairs(ignore_patterns) do
--     table.insert(fd_arguments, '-E')
--     table.insert(fd_arguments, pattern)
--   end

--   require 'telescope.builtin'.find_files {
--     find_command = fd_arguments,
--     hidden = true,
--     no_ignore = false,
--   }
-- end)

map('n', '<leader>fb', ':Telescope buffers<cr>')
map('n', '<leader>fs', ':Telescope git_status<cr>')
map('n', '<leader>fo', ':Telescope oldfiles<cr>')
map('n', '<leader>fp', ':Telescope resume<cr>')

map('n', '<leader>fi', function()
  require 'telescope.builtin'.lsp_references {
    include_declaration = true,
    include_current_line = true,
    trim_text = true
  }
end)

map('n', '<leader>fq', function()
  require 'telescope.builtin'.live_grep {
    hidden = true,
    disable_coordinates = true,
    additional_args = function()
      local vimgrep_arguments = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--trim',
        '--hidden=false',
        '--no-ignore=true',
        '-g=!node_modules/',
      }

      return vimgrep_arguments
    end
  }
end)

map('n', '<leader>fl', function()
  require 'telescope.builtin'.live_grep {
    hidden = true,
    disable_coordinates = true,
    additional_args = function()
      local vimgrep_arguments = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--trim',
        '--hidden',
      }

      for _, pattern in pairs(ignore_patterns) do
        table.insert(vimgrep_arguments, '-g=!' .. pattern)
      end

      return vimgrep_arguments
    end
  }
end)

map('n', '<leader>fk', function()
  require 'telescope.builtin'.grep_string {
    disable_coordinates = true,
    additional_args = function()
      local vimgrep_arguments = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
        '--smart-case',
        '--trim',
        '--hidden',
      }

      for _, pattern in pairs(ignore_patterns) do
        table.insert(vimgrep_arguments, '-g=!' .. pattern)
      end

      return vimgrep_arguments
    end
  }
end)

map('n', '<leader>fe', function()
  require 'telescope'.extensions.file_browser.file_browser {
    hidden = true,
    grouped = true,
    hide_parent_dir = true
  }
end)

map('n', '<leader>fh', function()
  local path = u.getCurrentPath()
  require 'telescope'.extensions.file_browser.file_browser {
    cwd = path,
    hidden = true,
    grouped = true,
    hide_parent_dir = true
  }
end)

map('n', '<leader>ec', function()
  require 'telescope.builtin'.find_files {
    cwd = '~/dotfiles/nvim',
    hidden = true,
  }
end)

map('n', '<leader>en', function()
  require 'telescope'.extensions.file_browser.file_browser {
    cwd = '~/notes',
    grouped = true
  }
end)
