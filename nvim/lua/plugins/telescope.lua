local actions = require('telescope.actions')
local sorters = require('telescope.sorters')
local previewers = require('telescope.previewers')
local telescope = require('telescope')

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-ignore',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = " ",
    selection_caret = "﬌ ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      prompt_position = 'top',
      -- preview_width = 0.55,
      horizontal = {
        mirror = false,
        width = 0.95
      },
      vertical = {
        mirror = false,
        width = 0.95
      },
    },
    file_ignore_patterns = {
      -- 'dotfiles/',
      'node_modules/',
      'dist/',
      'data/',
      'docker_volumes_data/',
      'build/',
      'test/',
      '.git/',
      'assets/',
      '.vscode/',
      'ios/',
      -- 'android/',
      '.expo-schared',
      "node_modules\\",
      "dist\\",
      "docker_volumes_data\\",
      "data\\",
      "yarn.lock",
      "*.md",
      "build",
      "package-lock.json",
      "test",
      "__mocks__",
      ".git\\"
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
  },
}

telescope.load_extension "file_browser"
