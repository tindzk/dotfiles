#!/bin/sh
xdg-settings set default-web-browser firefox.desktop

ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/profile ~/.profile
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/mpv ~/.config/mpv
ln -s ~/dotfiles/gitconfig ~/.gitconfig
# ln -s ~/dotfiles/konsole ~/.local/share/konsole
ln -s ~/dotfiles/inputrc ~/.inputrc
# ln -s ~/dotfiles/screenrc ~/.screenrc
ln -s ~/dotfiles/vimpcrc ~/.vimpcrc

mkdir -p ~/.config/zathura/
ln -s ~/dotfiles/zathurarc ~/.config/zathura/zathurarc

mkdir -p ~/.config/polybar/
ln -s ~/dotfiles/polybar/config ~/.config/polybar/config
ln -s ~/dotfiles/polybar/launch.sh ~/.config/polybar/launch.sh

mkdir -p ~/.config/i3/
ln -s ~/dotfiles/i3/config ~/.config/i3/config

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

mkdir -p ~/.config/git/
ln -s ~/dotfiles/gitattributes ~/.config/git/attributes

ln -s ~/dotfiles/idea.properties ~/.IdeaIC2018.3/config/idea.properties
