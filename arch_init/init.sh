#! /bin/bash

source ~/dotfiles/packages.sh
sudo chsh -s $(which fish)
/usr/bin/env fish ~/dotfiles/fish_init.fish
