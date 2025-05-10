#!/bin/bash

mkdir -p ~/.config
mkdir -p ~/.vim_undo_files
mkdir -p ~/.config/Code/User
mkdir -p ~/.local/bin

rm -f ~/.bash_aliases
rm -f ~/.bash_logout
rm -f ~/.bash_profile
rm -f ~/.bashrc
rm -f ~/.gitconfig
rm -f ~/.git-prompt.sh
rm -f ~/.inputrc
rm -f ~/.digrc
rm -f ~/.vim
rm -f ~/.config/nvim
rm -rf ~/.config/alacritty
rm -f ~/.tmux.conf
rm -f ~/.tmux
rm -f ~/.config/Code/User/settings.json
rm -rf ~/.config/Code/User/snippets
rm -f ~/.config/Code/User/keybindings.json
rm -rf ~/.config/bat
rm -rf ~/.local/bin/listify
rm -rf ~/.local/bin/listifyq
rm -rf ~/.local/bin/maintenance.sh

ln -s ~/dotfiles/bash/bash_aliases ~/.bash_aliases
ln -s ~/dotfiles/bash/bash_logout ~/.bash_logout
ln -s ~/dotfiles/bash/bash_profile ~/.bash_profile
ln -s ~/dotfiles/bash/bashrc ~/.bashrc
ln -s ~/dotfiles/git/gitconfig ~/.gitconfig
ln -s ~/dotfiles/git/git-prompt.sh ~/.git-prompt.sh
ln -s ~/dotfiles/bash/inputrc ~/.inputrc
ln -s ~/dotfiles/bash/digrc ~/.digrc
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/nvim ~/.config/nvim
ln -s ~/dotfiles/alacritty ~/.config/alacritty
ln -s ~/dotfiles/tmux ~/.tmux
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -s ~/dotfiles/vscode/user/settings.json ~/.config/Code/User/settings.json
ln -s ~/dotfiles/vscode/user/snippets ~/.config/Code/User/snippets
ln -s ~/dotfiles/vscode/user/keybindings.json ~/.config/Code/User/keybindings.json
ln -s ~/dotfiles/bat ~/.config/bat

ln -s ~/dotfiles/scripts/listify ~/.local/bin/listify
ln -s ~/dotfiles/scripts/listifyq ~/.local/bin/listifyq
ln -s ~/dotfiles/scripts/maintenance.sh ~/.local/bin/maintenance.sh
