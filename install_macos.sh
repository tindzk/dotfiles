#!/bin/sh
ln -s ~/dotfiles/zshrc ~/.zshrc
ln -s ~/dotfiles/profile ~/.profile
ln -s ~/dotfiles/gitconfig ~/.gitconfig
ln -s ~/dotfiles/ideavimrc ~/.ideavimrc
ln -s ~/dotfiles/wezterm.lua ~/.wezterm.lua
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
ln -s ~/dotfiles/nvim ~/.config/nvim

mkdir -p ~/.cargo
ln -s ~/dotfiles/macos/cargo/config.toml ~/.cargo/config.toml

mkdir -p ~/Library/Application\ Support/nushell
ln -s ~/dotfiles/macos/nushell/config.nu ~/Library/Application\ Support/nushell/config.nu

# Karabiner rewrites karabiner.json atomically, so link the directory, not the file
mkdir -p ~/.config
ln -s ~/dotfiles/macos/karabiner ~/.config/karabiner
