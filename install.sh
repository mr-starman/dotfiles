#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX="backup.$(date +%Y%m%d%H%M%S)"

link_path() {
  local source="$1"
  local target="$2"

  if [ ! -e "$source" ]; then
    printf 'Skipping missing source: %s\n' "$source" >&2
    return
  fi

  mkdir -p "$(dirname -- "$target")"

  if [ -L "$target" ] || [ -f "$target" ]; then
    rm -f -- "$target"
  elif [ -e "$target" ]; then
    mv -- "$target" "$target.$BACKUP_SUFFIX"
  fi

  ln -s -- "$source" "$target"
}

mkdir -p "$HOME/.config"
mkdir -p "$HOME/.vim_undo_files"
mkdir -p "$HOME/.config/Code/User"
mkdir -p "$HOME/.local/bin"

link_path "$DOTFILES_DIR/bash/bash_aliases" "$HOME/.bash_aliases"
link_path "$DOTFILES_DIR/bash/bash_logout" "$HOME/.bash_logout"
link_path "$DOTFILES_DIR/bash/bash_profile" "$HOME/.bash_profile"
link_path "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc"
link_path "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
link_path "$DOTFILES_DIR/git/git-prompt.sh" "$HOME/.git-prompt.sh"
link_path "$DOTFILES_DIR/bash/inputrc" "$HOME/.inputrc"
link_path "$DOTFILES_DIR/bash/digrc" "$HOME/.digrc"
link_path "$DOTFILES_DIR/vim" "$HOME/.vim"
link_path "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
link_path "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"
link_path "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"
link_path "$DOTFILES_DIR/tmux" "$HOME/.tmux"
link_path "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
link_path "$DOTFILES_DIR/vscode/user/settings.json" "$HOME/.config/Code/User/settings.json"
link_path "$DOTFILES_DIR/vscode/user/keybindings.json" "$HOME/.config/Code/User/keybindings.json"
link_path "$DOTFILES_DIR/bat" "$HOME/.config/bat"
link_path "$DOTFILES_DIR/opencode" "$HOME/.config/opencode"

link_path "$DOTFILES_DIR/scripts/listify" "$HOME/.local/bin/listify"
link_path "$DOTFILES_DIR/scripts/listifyq" "$HOME/.local/bin/listifyq"
link_path "$DOTFILES_DIR/scripts/maintenance.sh" "$HOME/.local/bin/maintenance.sh"
