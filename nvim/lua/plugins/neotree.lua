local u = require 'utils'

vim.g.neo_tree_remove_legacy_commands = 1

return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  config = function()
    local tree = require 'neo-tree'

    tree.setup {
      popup_border_style = 'rounded',

      default_component_configs = {
        git_status = {
          symbols = {
            unstaged = '',
          },
        },
      },
      window = {
        position = 'float',
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        popup = {
          size = {
            width = '60%',
            height = '60%',
          },
        },
        mappings = {
          ['<2-LeftMouse>'] = 'open',
          ['o'] = 'open',
          ['/'] = 'noop',
          ['f'] = 'fuzzy_finder',
          ['s'] = 'open_vsplit',
          ['S'] = 'open_split',
          ['<esc>'] = 'revert_preview',
          ['h'] = function(state)
            local node = state.tree:get_node()
            local parent_node = state.tree:get_node(node:get_parent_id())
            if parent_node:is_expanded() then
              require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
              require('neo-tree.sources.filesystem').toggle_directory(state, parent_node)

              local pn = state.tree:get_node(state.tree:get_node():get_parent_id())

              if not pn:is_expanded() then
                require('neo-tree.sources.filesystem.commands').navigate_up(state)
              end
            end
          end,
          ['l'] = function(state)
            local node = state.tree:get_node()
            if node.type == 'directory' then
              if not node:is_expanded() then
                require('neo-tree.sources.filesystem').toggle_directory(state, node)
              elseif node:has_children() then
                require('neo-tree.ui.renderer').focus_node(state, node:get_child_ids()[1])
              end
            else
              require('neo-tree.sources.filesystem.commands').open(state)
            end
          end,
          ['u'] = function(state)
            require('neo-tree.sources.filesystem.commands').navigate_up(state)
          end,
          ['i'] = function(state)
            require('neo-tree.sources.filesystem.commands').set_root(state)
          end,
          -- ['P'] = { 'toggle_preview', config = { use_float = true } },
          ['t'] = 'open_tabnew',
          ['C'] = 'close_node',
          ['z'] = 'close_all_nodes',
          ['a'] = {
            'add',
            config = {
              show_path = 'none', -- 'none', 'relative', 'absolute'
            },
          },
          ['P'] = function(state)
            local node = state.tree:get_node()
            require('neo-tree.ui.renderer').focus_node(state, node:get_parent_id())
          end,
          ['A'] = 'add_directory',
          ['d'] = 'delete',
          ['r'] = 'rename',
          ['y'] = 'copy_to_clipboard',
          ['x'] = 'cut_to_clipboard',
          ['p'] = 'paste_from_clipboard',
          ['c'] = 'copy',
          ['m'] = 'move',
          ['q'] = 'close_window',
          ['R'] = 'refresh',
          ['?'] = 'show_help',
          ['<'] = 'prev_source',
          ['>'] = 'next_source',
        },
      },
      buffers = {
        bind_to_cwd = false,
      },
      filesystem = {
        bind_to_cwd = false,
        filtered_items = {
          hide_gitignored = false,
          hide_hidden = false,
          hide_dotfiles = false,
        },
      },
    }

    local root_path = u.get_current_path()
    local cmd = require 'neo-tree.command'

    map('n', '<leader>o', function()
      cmd.execute {
        source = 'filesystem',
        position = 'float',
        dir = vim.fn.expand '%:p:h',
        reveal_file = vim.fn.expand '%:p',
      }
    end)
    map('n', '<leader>O', function()
      cmd.execute {
        source = 'filesystem',
        position = 'float',
        dir = root_path,
      }
    end)
    map('n', '<leader><C-o>', function()
      cmd.execute {
        source = 'git_status',
        position = 'float',
      }
    end)
  end,
}
