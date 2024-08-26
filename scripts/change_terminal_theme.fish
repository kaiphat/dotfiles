set selected_theme (cat ~/dotfiles/scripts/themes.txt | tr '\|' '\t' | fzf -d '\t' --with-nth 1)

if test -z "$selected_theme"
    echo "not choosed"
    exit 0
end

set dark_theme_enabled
set theme_type

switch $selected_theme
    case "*dark*"
        set dark_theme_enabled 1
        set theme_type "dark"
    case "*light*"
        set dark_theme_enabled 0
        set theme_type "light"
end

sed -i '' -E "s/background \= '[a-z]+'/background = '$theme_type'/" ~/dotfiles/nvim/lua/options.lua
sed -i '' -E "s/dark_theme\=[01]/dark_theme=$dark_theme_enabled/" ~/dotfiles/.tmux.conf
sed -i '' -E "s/themes\.[a-zA-Z_]+/themes.$selected_theme/" ~/dotfiles/nvim/lua/plugins/themes.lua
sed -i '' -E "s/themes\/[a-zA-Z_]+\.toml/themes\/$selected_theme.toml/" ~/dotfiles/alacritty/alacritty.toml
sed -i '' -E "s/wezterm\.themes\.[a-zA-Z_]+/wezterm\.themes\.$selected_theme/" ~/dotfiles/wezterm/wezterm.lua

tmux source-file ~/dotfiles/.tmux.conf
