#! /bin/bash

prefix=":::::::::::::::::::"

sudo pacman -Syu
yay -Syu

if ! command -v yay &> /dev/null; then
  pacman -S --needed git base-devel &&
  git clone https://aur.archlinux.org/yay.git &&
  cd yay &&
  makepkg -si
fi

if ! command -v fish &> /dev/null; then
  sudo pacman -S --needed --noconfirm fish
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
  fisher install jethrokuan/z
  fisher install pure-fish/pure
  fisher install acomagu/fish-async-prompt
  fisher install jorgebucaran/nvm.fish
fi

if ! command -v rustc &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

# cargo install \
#   bob-nvim
#
# if ! command -v nvim &> /dev/null; then
#   bob install latest
#   bob use latest
# fi

sudo pacman -S --needed --noconfirm \
  yarn \
  sxiv \
  unrar \
  unzip \
  xdotool \
  jq \
  zathura \
  zathura-pdf-mupdf \
  alacritty \
  wezterm \
  xautolock \
  dunst \
  polkit-gnome \
  xorg-xsetroot \
  fd \
  ripgrep \
  bspwm \
  sxhkd \
  telegram-desktop \
  scrot \
  xclip \
  ttf-victor-mono-nerd \
  ttf-jetbrains-mono-nerd \
  ttf-mononoki-nerd \
  otf-cascadia-code-nerd \
  ttc-iosevka-ss12 \
  postgresql \
  networkmanager \

yay_packages=( \
  "brave-bin" \
  "jmtpfs"
)

for package in "${yay_packages[@]}"; do
  if yay -Qs $package > /dev/null; then
    echo $prefix $package "exists"
  else
    echo $prefix $package "start installation"
    yay -S --cleanafter --noconfirm $package
  fi
done


