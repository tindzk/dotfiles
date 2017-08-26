#!/bin/sh
ln -s ~/dotfiles/autostart.sh ~/autostart.sh
ln -s ~/dotfiles/keyboard.sh  ~/keyboard.sh

ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/profile ~/.profile
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/mpv ~/.mpv
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/konsole ~/.local/share/konsole
ln -s ~/dotfiles/inputrc ~/.inputrc
ln -s ~/dotfiles/screenrc ~/.screenrc

mkdir -p ~/.config/zathura/
ln -s ~/dotfiles/zathurarc ~/.config/zathura/zathurarc

mkdir -p ~/.config/polybar/
ln -s ~/dotfiles/polybar/config ~/.config/polybar/config
ln -s ~/dotfiles/polybar/launch.sh ~/.config/polybar/launch.sh

mkdir -p ~/.config/i3/
ln -s ~/dotfiles/i3/config ~/.config/i3/config
