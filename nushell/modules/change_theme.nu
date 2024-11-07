export def main [] {
    let themes = [
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
    ]

    let theme = $themes | to text | fzf

    print $theme
    # if not theme return

    if $theme == null {
        print 'null'
        return
    }

    mut theme_type = 'dark'
    mut dark_theme_enabled = 1

    if ($theme =~ 'light') {
        $theme_type = 'light'
        $dark_theme_enabled = 0
    }

    sed -i '' -E $"s/background \\= '[a-z]+'/background = '($theme_type)'/" ~/dotfiles/nvim/lua/options.lua
    sed -i '' -E $"s/dark_theme\\=[01]/dark_theme=($dark_theme_enabled)/" ~/dotfiles/.tmux.conf
    sed -i '' -E $"s/themes\\.[a-zA-Z_]+/themes.($theme)/" ~/dotfiles/nvim/lua/plugins/themes.lua
    sed -i '' -E $"s/themes\\/[a-zA-Z_]+\\.toml/themes\\/($theme).toml/" ~/dotfiles/alacritty/alacritty.toml
    sed -i '' -E $"s/themes\\/[a-zA-Z_]+\\.conf/themes\\/($theme).conf/" ~/dotfiles/kitty/kitty.conf
    sed -i '' -E $"s/themes\\/[a-zA-Z_]+\\.nu/themes\\/($theme).nu/" ~/dotfiles/nushell/config.nu
    sed -i '' -E $"s/wezterm\\.themes\\.[a-zA-Z_]+/wezterm\\.themes\\.($theme)/" ~/dotfiles/wezterm/wezterm.lua

    tmux source-file ~/dotfiles/.tmux.conf
}