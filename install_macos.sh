#!/bin/sh
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/profile ~/.profile
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/nvim ~/.config/nvim

mkdir -p ~/.cargo
ln -s ~/dotfiles/macos/cargo/config.toml ~/.cargo/config.toml
