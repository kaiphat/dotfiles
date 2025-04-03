#!/opt/homebrew/bin/fish

set paths \
    ~/.gitconfig \
    ~/.psqlrc \
    ~/.less \
    ~/.zshrc \
    ~/.tmux.conf \
    ~/.rndebuggerrc \
    ~/.config/kitty \
    ~/.config/pgcli \
    ~/.config/litecli \
    ~/.config/starship.toml \
    ~/.config/fish/config.fish \
    ~/.config/zk \
    ~/.config/nvim \
    ~/.config/alacritty \
    ~/.config/fontconfig/fonts.conf \
    ~/.config/wezterm \
    ~/.config/helix \
    ~/.config/picom \
    ~/.config/bspwm \
    ~/.config/sxhkd \
    ~/.config/rofi \
    ~/.config/polybar \
    ~/.config/nushell \
    "$HOME/Library/Application Support/nushell" \
    ~/.config/zathura \
    ~/.config/i3 \
    ~/.config/zellij \
    ~/.config/dunst \
    ~/.config/watson \
    ~/.config/lazygit \
    ~/.config/btop \
    ~/.config/ghostty \
    ~/.config/yazi \
    ~/.config/gh-dash \
    "$HOME/Library/Application Support/usql"

for path in $paths
    echo "----------------------------------"
    set item (basename $path)

    if test ! -e ~/dotfiles/$item
        echo "$item not found in dotfiles"
        exit 1
    end

    if test -e ~/dotfiles/$item
        echo "rm $path"
        rm -rf $path
    end

    if test ! -e $path
        mkdir -p (dirname $path)
        echo "link ~/dotfiles/$item $path"
        ln -s ~/dotfiles/$item $path
    end
end
