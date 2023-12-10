set themes \
    dark            \
    rose_pine_dark  \
    rose_pine_light \
    github_light    \
    github_dark

echo "select theme:"
for i in (seq 1 (count $themes))
    echo "    $i - $themes[$i]"
end

read -P "number: " theme_index

if test $theme_index -lt 1
    echo "invalid index"
    exit 0
end
if test $theme_index -gt (count $themes)
    echo "invalid index"
    exit 0
end

set selected_theme $themes[$theme_index]


set dark_theme_enabled
switch $selected_theme
    case "*dark*"
        set dark_theme_enabled 1
    case "*light*"
        set dark_theme_enabled 0
end

echo $dark_theme_enabled

sed -i '' -E "s/dark_theme\=[01]/dark_theme=$dark_theme_enabled/" ~/dotfiles/.tmux.conf
sed -i '' -E "s/themes\.[a-zA-Z_]+/themes.$selected_theme/" ~/dotfiles/nvim/lua/plugins/themes.lua
sed -i '' -E "s/themes\/[a-zA-Z_]+\.toml/themes\/$selected_theme.toml/" ~/dotfiles/alacritty/alacritty.toml

tmux source-file ~/dotfiles/.tmux.conf
