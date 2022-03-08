#!/bin/sh
xdg-settings set default-web-browser firefox.desktop

ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/profile ~/.profile
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/mpv ~/.config/mpv
ln -s ~/dotfiles/gitconfig ~/.gitconfig
# ln -s ~/dotfiles/konsole ~/.local/share/konsole
ln -s ~/dotfiles/inputrc ~/.inputrc
# ln -s ~/dotfiles/screenrc ~/.screenrc
ln -s ~/dotfiles/vimpcrc ~/.vimpcrc

mkdir -p ~/.xkb/symbols/
# Sway
ln -s ~/dotfiles/xkb/symbols/us-custom ~/.xkb/symbols/us-custom
ln -s ~/dotfiles/xkb/symbols/ua-custom ~/.xkb/symbols/ua-custom
ln -s ~/dotfiles/xkb/symbols/de-custom ~/.xkb/symbols/de-custom
ln -s ~/dotfiles/xkb/symbols/tr-custom ~/.xkb/symbols/tr-custom
# i3
sudo ln -s ~/dotfiles/xkb/symbols/us-custom /usr/share/X11/xkb/symbols/us-custom
sudo ln -s ~/dotfiles/xkb/symbols/ua-custom /usr/share/X11/xkb/symbols/ua-custom
sudo ln -s ~/dotfiles/xkb/symbols/de-custom /usr/share/X11/xkb/symbols/de-custom
sudo ln -s ~/dotfiles/xkb/symbols/tr-custom /usr/share/X11/xkb/symbols/tr-custom

mkdir -p ~/.config/zathura/
ln -s ~/dotfiles/zathurarc ~/.config/zathura/zathurarc

mkdir -p ~/.config/polybar/
ln -s ~/dotfiles/polybar/config ~/.config/polybar/config
ln -s ~/dotfiles/polybar/launch.sh ~/.config/polybar/launch.sh

mkdir -p ~/.config/sway/
ln -s ~/dotfiles/sway/config ~/.config/sway/config

ln -s ~/dotfiles/bspwm ~/.config/bspwm
ln -s ~/dotfiles/sxhkd ~/.config/sxhkd

ln -s ~/dotfiles/xsession ~/.xsession

ln -s ~/dotfiles/termite ~/.config/termite
ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/tigrc ~/.tigrc
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc

rmdir ~/.config/ranger
ln -s ~/dotfiles/ranger ~/.config/ranger

# pgweb uses `open` instead of `xdg-open`
mkdir ~/bin
ln -s $(which xdg-open) ~/bin/open
ln -s ~/dotfiles/bin/chromium ~/bin/chromium
ln -s ~/dotfiles/bin/chromium-dev ~/bin/chromium-dev
ln -s ~/dotfiles/bin/firefox-dev ~/bin/firefox-dev
ln -s ~/dotfiles/bin/lock ~/bin/lock
ln -s ~/dotfiles/bin/matlab ~/bin/matlab
ln -s ~/dotfiles/bin/reconnect ~/bin/reconnect
ln -s ~/dotfiles/bin/skype ~/bin/skype
ln -s /opt/sublime_merge/sublime_merge ~/bin/smerge
ln -s ~/dotfiles/bin/output ~/bin/output

mkdir -p ~/.config/git/
ln -s ~/dotfiles/gitattributes ~/.config/git/attributes

rm ~/.IdeaIC2019.2/config/idea.properties
ln -s ~/dotfiles/idea.properties ~/.IdeaIC2019.2/config/idea.properties

mkdir -p ~/.config/kitty/
ln -s ~/dotfiles/kitty.conf ~/.config/kitty/kitty.conf

mkdir -p ~/.config/waybar/
ln -s ~/dotfiles/waybar/config ~/.config/waybar/config
ln -s ~/dotfiles/waybar/style.css ~/.config/waybar/style.css

ln -s ~/dotfiles/seed.toml ~/.config/seed.toml

ln -s ~/dotfiles/dbus-1 ~/.local/share/dbus-1

ln -s ~/dotfiles/editorconfig ~/.editorconfig

sudo cp ~/dotfiles/sway@.service /etc/systemd/system/sway@.service
sudo systemctl daemon-reload
sudo systemctl enable sway@7
sudo systemctl restart sway@7

sudo cp logind.conf /etc/systemd/logind.conf
sudo cp 90-backlight.rules /etc/udev/rules.d/90-backlight.rules
cp userChrome.css ~/.mozilla/firefox/*.default/chrome/userChrome.css

mkdir -p ~/.config/octave
cp ~/dotfiles/octave/qt-settings ~/.config/octave/qt-settings
ln -s ~/dotfiles/octaverc ~/.octaverc
