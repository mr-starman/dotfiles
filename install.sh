#!/bin/bash

mkdir -p ~/.config
mkdir -p ~/.vim_undo_files

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
ln -s ~/dotfiles/tmux/tmux.conf ~/.tmux.conf
