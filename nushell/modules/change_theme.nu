const themes = [
  "rose_pine_dark"
  "rose_pine_light"
  "catppuccin_dark"
  "ayu_dark"
  "ayu_light"
  "tokyo_dark"
  "github_light"
  "dark"
  "github_dark"
  "solarized_light"
  "solarized_dark"
  "poimandres_dark"
  "gruvbox_light"
  "gruvbox_dark"
  "lume_dark"
]

def replace [file closure] {
  open ($file | path relative-to '') | lines | each $closure | save -f $file
}

export def main [] {
  let theme = ($themes | to text | fzf)

  if ($theme | is-empty) {
    return
  }

  mut theme_type = 'dark'
  mut dark_theme_enabled = 1

  if ($theme =~ 'light') {
    $theme_type = 'light'
    $dark_theme_enabled = 0
  }

  let theme_type = $theme_type
  let dark_theme_enabled = $dark_theme_enabled

  # Standard regex replacements
  sed -i "" -E $"s|themes/[a-zA-Z_]+\\.nu|themes/($theme).nu|" ~/dotfiles/nushell/config.nu
  sed -i "" -E $"s|themes/[a-zA-Z_]+\\.conf|themes/($theme).conf|" ~/dotfiles/kitty/kitty.conf
  sed -i "" -E $"s|themes/[a-zA-Z_]+\\.toml|themes/($theme).toml|" ~/dotfiles/alacritty/alacritty.toml
  sed -i "" -E $"s|wezterm\\.themes\\.[a-zA-Z_]+|wezterm.themes.($theme)|" ~/dotfiles/wezterm/wezterm.lua
  sed -i "" -E $"s|themes/[a-zA-Z_]+|themes/($theme)|" ~/dotfiles/ghostty/config

  # Replacing custom `replace` blocks with inline sed
  sed -i "" -E $"s|\(vim.o.background = ')\(.*)\(')|\\1($theme_type)\\3|" ~/dotfiles/nvim/lua/plugins/themes.lua
  sed -i "" -E $"s|\(require 'themes\\.)\([a-zA-Z0-9_]+)|\\1($theme)|" ~/dotfiles/nvim/lua/plugins/themes.lua
  sed -i "" -E $"s|\(dark_theme=)[01]|\\1($dark_theme_enabled)|" ~/dotfiles/.tmux.conf

  tmux source-file ~/dotfiles/.tmux.conf
}
