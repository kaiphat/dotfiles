#
# MODULES
#

#
# ALIASES
#

old-alias g = git
old-alias t = tmux
old-alias n = nvim
old-alias d = docker
old-alias y = yarn
old-alias dc = docker-compose

alias tn = t new-session -s
alias ta = t attach-session
alias td  = t detach

alias dcr = dc restart
alias di = docker inspect
def ds [] {
  let containers = (docker ps -q | lines);
  docker stop $containers;
}
def dps [name = ''] {
  let containers = (docker ps -a | from ssv | select ID STATUS CREATED NAMES PORTS);
  if $name == '' {
    $containers
  } else {
    $containers | where NAMES =~ $name
  }
}

alias todo = nvim ~/notes/deals.norg -c 'set signcolumn=no'
alias notes = nvim ~/notes/notes.norg -c 'set signcolumn=no'

alias nest = npx @nestjs/cli
alias nvim-start = (nvim --startuptime _s.log -c exit and tail -100 _s.log | bat and rm _s.log)

### PROJECT ALIASES ###
# gladwin
alias gladwin-prod-kuber-namespace = aws eks update-kubeconfig --region eu-central-1 --name gladwin-frankfurt-prod"
alias gladwin-stage-kuber-namespace = aws eks update-kubeconfig --region eu-central-1 --name gladwin-frankfurt-stage"
alias gladwin-dev-kuber-namespace = cat ~/.kube/config-dev > ~/.kube/config

alias gladwin-prod-db = kubectl -n 768-gladwin-tech-production port-forward pod/acid-gladwindb-2 8000:5432
alias gladwin-dev-db = kubectl -n 768-gladwin-tech-develop port-forward pod/acid-gladwindb-1 5432:5432
alias gladwin-stage-db = kubectl -n 768-gladwin-tech-staging port-forward pod/acid-gladwindb-0 8000:5432

alias gladwin-prod-redis = kubectl -n 768-gladwin-tech-production port-forward pod/rfr-redis-0 27777:26379

# green
alias green-prod-db = ssh -4 -L 1234:10.1.1.210:5432 green
alias green-master-db = ssh -4 -L 1234:localhost:27182 pp-master

#
# THEME
#
let base00 = "#24273a" # base
let base01 = "#1e2030" # mantle
let base02 = "#363a4f" # surface0
let base03 = "#494d64" # surface1
let base04 = "#5b6078" # surface2
let base05 = "#cad3f5" # text
let base06 = "#f4dbd6" # rosewater
let base07 = "#b7bdf8" # lavender
let base08 = "#ed8796" # red
let base09 = "#f5a97f" # peach
let base0a = "#eed49f" # yellow
let base0b = "#a6da95" # green
let base0c = "#8bd5ca" # teal
let base0d = "#8aadf4" # blue
let base0e = "#c6a0f6" # mauve
let base0f = "#f0c6c6" # flamingo

let theme = {
    separator: $base03
    leading_trailing_space_bg: $base04
    header: $base0b
    date: $base0e
    filesize: $base0d
    row_index: $base0c
    bool: $base08
    int: $base0b
    duration: $base08
    range: $base08
    float: $base08
    string: $base04
    nothing: $base08
    binary: $base08
    cellpath: $base08
    hints: dark_gray

    shape_garbage: { fg: "#bbbbbb" bg: "#FF0000" attr: b}
    shape_bool: $base0d
    shape_int: { fg: $base0e attr: b}
    shape_float: { fg: $base0e attr: b}
    shape_range: { fg: $base0a attr: b}
    shape_internalcall: { fg: $base0c attr: b}
    shape_external: $base0c
    shape_externalarg: { fg: $base0b attr: b}
    shape_literal: $base0d
    shape_operator: $base0a
    shape_signature: { fg: $base0b attr: b}
    shape_string: $base0b
    shape_filepath: $base0d
    shape_globpattern: { fg: $base0d attr: b}
    shape_variable: $base0e
    shape_flag: { fg: $base0d attr: b}
    shape_custom: {attr: b}
}

#
# CONFIG
#
let carapace_completer = {|spans|
  carapace $spans.0 nushell $spans | from json
}

let-env config = {
  ls: {
    use_ls_colors: true # use the LS_COLORS environment variable to colorize output
    clickable_links: true # enable or disable clickable links. Your terminal has to support links.
  }
  rm: {
    always_trash: false # always act as if -t was given. Can be overridden with -p
  }
  cd: {
    abbreviations: true # allows `cd s/o/f` to expand to `cd some/other/folder`
  }
  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
    trim: {
      methodology: wrapping # wrapping or truncating
      wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
      truncating_suffix: "..." # A suffix used by the 'truncating' methodology
    }
  }
  history: {
    max_size: 20000 # Session has to be reloaded for this to take effect
    sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
    file_format: "plaintext" # "sqlite" or "plaintext"
  }
  completions: {
    case_sensitive: false # set to true to enable case-sensitive completions
    quick: true  # set this to false to prevent auto-selecting completions when only one remains
    partial: true  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix or fuzzy
    external: {
      enable: true
      completer: $carapace_completer
    }
  }
  filesize: {
    metric: true # true => KB, MB, GB (ISO standard), false => KiB, MiB, GiB (Windows standard)
    format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  }
  show_banner: false
  color_config: $theme
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2
  use_ansi_coloring: true
  edit_mode: vi # emacs, vi
  menus: [
      {
        name: completion_menu
        only_buffer_difference: false
        marker: ""
        type: {
            layout: columnar
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
        }
        style: {
            text: $base0e
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: ""
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: "? "
        type: {
            layout: description
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "# "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "# "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
  ]
  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: emacs # Options: emacs vi_normal vi_insert
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_x
      mode: emacs
      event: {
        until: [
          { send: menu name: history_menu }
          { send: menupagenext }
        ]
      }
    }
    {
      name: history_previous
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
      }
    }
    # Keybindings used to trigger the user defined menus
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: control
      keycode: char_y
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}

#
# UTILS
#

def check_env [name] {
  (env | where name == $name | length) != 0
}

#
# PLUGINS
#

source ~/.zoxide.nu
source ~/.cache/starship/init.nu
