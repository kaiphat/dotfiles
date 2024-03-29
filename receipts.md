# LINUX

## change font and themes

lxappearence

## change cursor

https://wiki.archlinux.org/title/Cursor_themes

## nvidia drivers

-   `sudo pacman -S --needed nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader`
-   `sudo pacman -S linux-headers`

## prevent C-d exit for fish

-   funced fish_user_key_bindings
-   add `bind \cd delete-char` to end
-   save and close
-   funcsave fish_user_key_bindings

## change default shell

-   which $shell
-   chsh -s $which_output

## disable fn keys

`echo options hid_apple fnmode=0 | sudo tee -a /etc/modprobe.d/hid_apple.conf`
`sudo update-initramfs -u -k all`

## get all mon fonts

fc-list : family spacing outline scalable | grep -e spacing=100 -e spacing=90 | grep -e outline=True | grep -e scalable=True

## fish plugins

curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fisher install jethrokuan/z
fisher install pure-fish/pure
fisher install acomagu/fish-async-prompt

<!-- fisher install jorgebucaran/autopair.fish -->

fisher install jorgebucaran/nvm.fish

## change node modules and yarn access

sudo chown -R $USER /usr/local/lib/node_modules

## change badge icons size

cd ~/.themes
to find .icon-grid { icon-size: 30px }
change
Alt+F2 type r Enter

## patch fonts

sudo docker run -v ~/.local/share/fonts/from:/in -v ~/.local/share/fonts/to:/out nerdfonts/patcher -c --careful

## create pem keys

openssl genrsa > privkey.pem
openssl req -new -x509 -key privkey.pem > fullchain.pem

## copy several files and change name for every

pax -rw -s/rpc_dev/rpc/ [rpc_dev]\* .

## fix flash

`fdisk -l` to list the devices table
`fdisk /dev/sdb`
p to print the partition table of the device
d to delete partitions
n to create a new partition if you don't know how to use it you can press m to launch help
t to assign the tipe of partition, I usually use linux ext4
w to write the new partition table in the device Is very important to press w
OR `sudo pacman -S gparted` GUI for flash format

## format flash

`sudo mkfs.vfat -n 'kaiphat' /dev/sdb1 -v -c -F 32`

## setup razer

-   install `openrazer-daemon`
-   run `sudo gpasswd -a $USER plugdev`
-   `yay -S razergenie`
-   run program, set 1600 dpi

## create bootable usb with windows image

I tried `balena etcher` and `ventory`, but had success only with `woeusb`.

-   NVIM

## python

sudo apt install python3-pip
pip uninstall -y neovim pynvim msgpack greenlet
pip install neovim

-   Arch

## change loading message

-   `sudo nvim /boot/loader/loader.conf`
-   `timeout 0`
-   `sudo nvim /boot/loader/entries/2023-03-10_10-26-33_linux.conf`
-   add `rw quiet splash`

## wifi

-   check dhcpcd

-   check iwd or reload
-   `sudo systemctl enable iwd.service`
-   `sudo systemctl enable dhcpcd.service`
-   `ip link set wlan0 up`
-   `iwctl`
-   `device list`
-   add to `/etc/iwd/main.conf`
    [General]
    EnableNetworkConfiguration=true
-   `station wlan0 scan`
-   `station wlan0 get-networks`
-   `iwctl station wlan0 connect {name} --passphrase {password}`

-   or you can `sudo pacman -S networkmanager`
-   `nmcli device wifi list`
-   `nmcli device connect {name} password {password}`
-   disable dhcpcd service

## connect device by usb

-   `yay -S jmtpfs`
-   `mkdir ~/mnt`
-   `jmtpfs ~/mnt`

## plymouth

1. Install `mkinitcpio`
2. Update linux kernel
3. sudo nvim /etc/mkinitcpio.conf
   `MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)`
   add to HOOKS `plymouth` `HOOKS=(base udev plymouth autodetect modconf kms keyboard keymap consolefont block filesystems fsck)`
   and commect splash image if needed
4. sudo mkinitcpio -p linux
5. ❯ sudo nvim /etc/default/grub
6. Add `quiet splash` to GRUB_CMDLINE_LINUX_DEFAULT
7. ❯ sudo grub-mkconfig -o /boot/grub/grub.cfg
8. ❯ sudo nvim /etc/plymouth/plymouthd.conf

```toml
[Daemon]
Theme=bgrt
ShowDelay=0
DeviceTimeout=0
```

9. ❯ sudo plymouth-set-default-theme -R bgrt
10. reboot

## picom

`https://github.com/jonaburg/picom`

# postgres

## restore from backup

`pg_restore -h 127.0.0.1 -p 28162 -d estatex -U postgres  ~/backup.sql`

# anything

## rust completion not working in neovim

-   `sudo rustup component add rust-src`

## install zathura macos

brew tap zegervdv/zathura
brew install zathura
brew install zathura-pdf-poppler
mkdir -p $(brew --prefix zathura)/lib/zathura
ln -s $(brew --prefix zathura-pdf-poppler)/libpdf-poppler.dylib $(brew --prefix zathura)/lib/zathura/libpdf-poppler.dylib

## path to ssh in git config

```toml
[core]
sshCommand = ssh -i ~/.ssh/id_rsa_iliyapunko
```
