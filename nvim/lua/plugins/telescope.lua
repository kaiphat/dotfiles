local u = require 'utils'

return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
  config = function()
    local telescope = require 'telescope'
    local builtin = require 'telescope.builtin'
    local sorters = require 'telescope.sorters'
    local previewers = require 'telescope.previewers'
    local themes = require 'telescope.themes'
    local fb_actions = telescope.extensions.file_browser.actions

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

        prompt_prefix = '  ',
        selection_caret = ' ',
        entry_prefix = ' ',

        initial_mode = 'insert',
        selection_strategy = 'reset',
        sorting_strategy = 'ascending',
        -- layout_strategy = 'horizontal',
        layout_strategy = 'vertical',
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
              prompt = { '─', '│', ' ', '│', '╭', '╮', '│', '│' },
              results = { '─', '│', '─', '│', '├', '┤', '╯', '╰' },
              preview = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
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
            ['<C-w>'] = function()
              vim.api.nvim_input '<c-s-w>'
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
            ['i'] = {
              ['<C-u>'] = fb_actions.goto_parent_dir,
            }
          }
        },

        ['ui-select'] = {
          themes.get_cursor()
        },

        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        }
      },
    }

    telescope.load_extension 'fzf'
    telescope.load_extension 'file_browser'
    telescope.load_extension 'ui-select'

    map('n', '<leader>fb', function ()
      builtin.buffers {
        ignore_current_buffer = true,
        cwd_only = true,
        sort_lastused = true,
        trim_text = true,
        show_all_buffers = false,
      }
    end)
    map('n', '<leader>fs', ':Telescope git_status<cr>')
    map('n', '<leader>fo', function()
      builtin.oldfiles {
      }
    end)
    map('n', '<leader>fp', ':Telescope resume<cr>')

    map('n', '<leader>fi', function()
      builtin.lsp_references {
        include_declaration = true,
        include_current_line = false,
        trim_text = true
      }
    end)

    map('n', '<leader>fj', function()
      builtin.find_files {
        find_command = {
          'fd',
          '-t=f',
          '-E=test/',
        },
        hidden = false,
        no_ignore = false,
      }
    end)

    local function find_all_files()
      builtin.find_files {
        find_command = {
          'fd',
          '-t',
          'f',
          '-E', 'node_modules/',
          '-E', '.git/',
          '-E', 'dist/',
        },
        hidden = true,
        no_ignore = true,
      }
    end

    map('n', '<leader>fJ', find_all_files)
    map('n', '<leader>FJ', find_all_files)

    map('n', '<leader>fk', function()
      local path = u.get_current_path()
      telescope.extensions.file_browser.file_browser {
        cwd = path,
        hidden = true,
        grouped = true,
        hide_parent_dir = true,
        git_status = false
      }
    end)

    local function file_browser_root()
      telescope.extensions.file_browser.file_browser {
        hidden = true,
        grouped = true,
        hide_parent_dir = true,
        git_status = false
      }
    end

    map('n', '<leader>fK', file_browser_root)
    map('n', '<leader>FK', file_browser_root)

    map('n', '<leader>fl', function()
      builtin.live_grep {
        hidden = true,
        disable_coordinates = true,
        additional_args = function()
          local vimgrep_arguments = {
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--ignore-case',
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

    local function live_grep_all()
      builtin.live_grep {
        hidden = true,
        disable_coordinates = true,
        additional_args = function()
          local vimgrep_arguments = {
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--ignore-case',
            '--trim',
            '--hidden=false',
            '--no-ignore=true',
            '-g=!node_modules/',
            '-g=!dist/',
          }

          return vimgrep_arguments
        end
      }
    end

    map('n', '<leader>fL', live_grep_all)
    map('n', '<leader>FL', live_grep_all)

    map('n', '<leader>fh', function()
      builtin.grep_string {
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

    map('n', '<leader>ec', function()
      builtin.find_files {
        cwd = '~/dotfiles/nvim',
        hidden = true,
      }
    end)

    map('n', '<leader>es', function()
      builtin.find_files {
        cwd = '~/dotfiles',
        hidden = true,
      }
    end)

    map('n', '<leader>en', function()
      telescope.extensions.file_browser.file_browser {
        cwd = '~/notes',
        grouped = true
      }
    end)
  end
}
