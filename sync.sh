#!/bin/fish

set paths                  \
  .psqlrc                  \
  .config/starship.toml   \
  .less                    \
  .zshrc                   \
  .tmux.conf               \
  .gitconfig               \
  .rndebuggerrc            \
  .config/nvim             \
  .config/kitty            \
  .config/pgcli            \
  .config/fish/config.fish \
  .config/zk               \
  .config/alacritty        \
  .config/fontconfig/fonts.conf \
  .config/wezterm/wezterm.lua \
  .config/helix \
  .config/picom \
  .config/bspwm \
  .config/sxhkd \
  .config/rofi \
  .config/polybar \
  .config/nushell \
  .config/zathura \
  .config/awesome \
  .config/i3 \
  .config/dunst

set dotfiles ~/dotfiles

for path in $paths
  set fullpath ~/$path
  set item (basename $path)

  if test ! -e $dotfiles/$item
    cp -r $fullpath $dotfiles 
  end

  if test -e $dotfiles/$item
    rm -rf $fullpath
  end

  if test ! -e $fullpath
    mkdir -p (dirname $fullpath)
    ln -s $dotfiles/$item $fullpath
  end
end


