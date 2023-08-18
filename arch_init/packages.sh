#! /bin/bash

pacman_packages=(\
  "fish" \
  "yarn" \
  "nodejs" \
  "sxiv" \
  "unrar" \
  "unzip" \
  "xdotool" \
  "jq" \
  "xautolock" \
  "dunst" \
  "polkit-gnome" \
  "xorg-xsetroot" \
  "fd" \
  "ripgrep" \
  "scrot" \
  "xclip" \
  "postgresql" \
  "networkmanager" \

  # applications
  "telegram-desktop" \
  "alacritty" \
  "zathura" \
  "zathura-pdf-mupdf" \
)

yay_packages=( \
  "jmtpfs" \
  "brave-bin" \
)

sudo pacman -Syu --noconfirm

for package in "${pacman_packages[@]}"; do
  sudo pacman -S --needed --noconfirm $package
done

for package in "${yay_packages[@]}"; do
  if yay -Qs $package > /dev/null; then
    echo $prefix $package "exists"
  else
    echo $prefix $package "start installation"
    yay -S --cleanafter --noconfirm $package
  fi
done

