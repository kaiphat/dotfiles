### UBUNTU ###

# disable fn keys
 echo options hid_apple fnmode=0 | sudo tee -a /etc/modprobe.d/hid_apple.conf
 sudo update-initramfs -u -k all

# get all mon fonts
 fc-list : family spacing outline scalable | grep -e spacing=100 -e spacing=90 | grep -e outline=True | grep -e scalable=True

# fish plugins
  curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
  fisher install jethrokuan/z
  fisher install pure-fish/pure
  fisher install acomagu/fish-async-prompt
  fisher install jorgebucaran/autopair.fish
  fisher install jorgebucaran/nvm.fish

# change node modules and yarn access
  sudo chown -R $USER /usr/local/lib/node_modules

# change badge icons size
  cd ~/.themes
  to find .icon-grid { icon-size: 30px }
  change
  Alt+F2 type r Enter

### NVIM ###

# python
  sudo apt install python3-pip
  pip uninstall -y neovim pynvim msgpack greenlet
  pip install neovim

### KITTY ###

# font support
  mkdir ~/.config/fontconfig/fonts.conf

  ```
  <?xml version="1.0"?>
  <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
  <fontconfig>
  <match target="scan">
      <test name="family">
          <string>mononoki Nerd Font</string>
      </test>
      <edit name="spacing">
          <int>100</int>
      </edit>
  </match>
  </fontconfig>
  ```
  fc-cache -r
