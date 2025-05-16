def main [] {
    let paths = [
        ~/.gitconfig 
        ~/.psqlrc 
        ~/.less 
        ~/.zshrc 
        ~/.tmux.conf 
        ~/.rndebuggerrc 
        ~/.config/kitty 
        ~/.config/pgcli 
        ~/.config/litecli 
        ~/.config/starship.toml 
        ~/.config/fish/config.fish 
        ~/.config/zk 
        ~/.config/nvim 
        ~/.config/alacritty 
        ~/.config/fontconfig/fonts.conf 
        ~/.config/wezterm 
        ~/.config/helix 
        ~/.config/picom 
        ~/.config/bspwm 
        ~/.config/sxhkd 
        ~/.config/rofi 
        ~/.config/polybar 
        ~/.config/nushell 
        "~/Library/Application Support/nushell"
        ~/.config/zathura 
        ~/.config/i3 
        ~/.config/zellij 
        ~/.config/dunst 
        ~/.config/watson 
        ~/.config/lazygit 
        ~/.config/btop 
        ~/.config/ghostty 
        ~/.config/yazi 
        ~/.config/gh-dash 
        "~/Library/Application Support/usql"
    ]

    $paths | each {
        print "----------------------------------------"

        let path = $in | path relative-to ''
        let item = $path | path basename
        let dir = $path | path dirname 

        print $path
        print $item
        print $dir

        if ($in | str starts-with '/') {
            print $'($path) is unsafe'
            exit 1
        }

        if ($in == '~') {
            print $'($path) is unsafe'
            exit 1
        }

        if not ($'~/dotfiles/($item)' | path exists) {
            print $'($item) not found in dotfiles'
            exit 1
        }

        rm -rf $path

        if not ($dir | path exists) {
            mkdir $dir
        }
        ln -s $'($env.HOME)/dotfiles/($item)' $path
        
        print "----------------------------------------"
    }
}
