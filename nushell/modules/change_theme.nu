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
]

def replace [file closure] {
    nu-open ($file | path relative-to '') | lines | each $closure | save -f $file
}

export def main [] {
    let theme = $themes | to text | fzf

    if $theme == null {
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

    sd "themes/[a-zA-Z_]+.nu" $"themes/($theme).nu" ~/dotfiles/nushell/config.nu
    sd "themes/[a-zA-Z_]+.conf" $"themes/($theme).conf" ~/dotfiles/kitty/kitty.conf
    sd "themes/[a-zA-Z_]+.toml" $"themes/($theme).toml" ~/dotfiles/alacritty/alacritty.toml
    sd "wezterm.themes.[a-zA-Z_]+" $"wezterm.themes.($theme)" ~/dotfiles/wezterm/wezterm.lua
    sd "themes/[a-zA-Z_]+" $"themes/($theme)" ~/dotfiles/ghostty/config

    replace ~/dotfiles/nvim/lua/plugins/themes.lua { |$it|
        $it 
            | str replace -r "(vim.o.background\\s*=\\s*')(.*)(')" $"${1}($theme_type)${3}"
            | str replace -r "(return require\\('themes.'\\s*..\\s*themes.)(\\w+)" $"${1}($theme)"
    }
    replace ~/dotfiles/.tmux.conf { |$it|
        $it | str replace -r "(dark_theme=)[01]" $"${1}($dark_theme_enabled)"
    }

    tmux source-file ~/dotfiles/.tmux.conf
}
