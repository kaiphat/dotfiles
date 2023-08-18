#! /bin/bash

source ~/dotfiles/arch_init/packages.sh
sudo chsh -s $(which fish)
/usr/bin/env fish ~/dotfiles/arch_init/fish_init.fish
