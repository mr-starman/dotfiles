#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SUFFIX="backup.$(date +%Y%m%d%H%M%S)"
DRY_RUN=false
SKIP_BOOTSTRAP=false

show_help() {
  cat <<EOF
Usage: $(basename "$0") [OPTIONS]

Options:
  --dry-run    Print what would be done without making changes
  --skip-bootstrap
               Do not download TPM
  --help       Display this help message

Sets up dotfiles by symlinking configs and bootstrapping TPM.
EOF
  exit 0
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --skip-bootstrap) SKIP_BOOTSTRAP=true; shift ;;
    --help) show_help ;;
    *) echo "Unknown option: $1. Use --help for usage."; exit 1 ;;
  esac
done

run() {
  if $DRY_RUN; then
    printf '[dry-run] %s\n' "$*"
  else
    "$@"
  fi
}

link_path() {
  local source="$1"
  local target="$2"

  if [ ! -e "$source" ]; then
    printf 'Skipping missing source: %s\n' "$source" >&2
    return
  fi

  if $DRY_RUN; then
    printf '[dry-run] mkdir -p -- %s\n' "$(dirname -- "$target")"
    if [ -L "$target" ] && [ "$(readlink -- "$target")" = "$source" ]; then
      printf 'Already linked: %s\n' "$target"
      return
    elif [ -L "$target" ] || [ -e "$target" ]; then
      printf '[dry-run] mv -- %s %s.%s\n' "$target" "$target" "$BACKUP_SUFFIX"
    fi
    printf '[dry-run] ln -s -- %s %s\n' "$source" "$target"
    return
  fi

  mkdir -p "$(dirname -- "$target")"

  if [ -L "$target" ] && [ "$(readlink -- "$target")" = "$source" ]; then
    printf 'Already linked: %s\n' "$target"
    return
  elif [ -L "$target" ] || [ -e "$target" ]; then
    mv -- "$target" "$target.$BACKUP_SUFFIX"
  fi

  ln -s -- "$source" "$target"
}

install_tpm() {
  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [ -x "$tpm_dir/tpm" ]; then
    printf 'TPM already installed at %s\n' "$tpm_dir"
    return
  fi
  if [ -d "$tpm_dir" ]; then
    if find "$tpm_dir" -mindepth 1 -print -quit | grep -q .; then
      printf 'Cannot install TPM: non-empty invalid directory at %s\n' "$tpm_dir" >&2
      return 1
    fi
    run rmdir -- "$tpm_dir"
  fi
  printf 'Installing TPM...\n'
  run git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
}

# Directories
run mkdir -p "$HOME/.config"
run mkdir -p "$HOME/.vim_undo_files"
run mkdir -p "$HOME/.config/Code/User"
run mkdir -p "$HOME/.local/bin"

# Shell
link_path "$DOTFILES_DIR/bash/bash_aliases" "$HOME/.bash_aliases"
link_path "$DOTFILES_DIR/bash/bash_logout" "$HOME/.bash_logout"
link_path "$DOTFILES_DIR/bash/bash_profile" "$HOME/.bash_profile"
link_path "$DOTFILES_DIR/bash/bashrc" "$HOME/.bashrc"
link_path "$DOTFILES_DIR/bash/inputrc" "$HOME/.inputrc"
link_path "$DOTFILES_DIR/bash/digrc" "$HOME/.digrc"

# Git
link_path "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
link_path "$DOTFILES_DIR/git/git-prompt.sh" "$HOME/.git-prompt.sh"

# Editors
link_path "$DOTFILES_DIR/vim" "$HOME/.vim"
link_path "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Terminal
link_path "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"
link_path "$DOTFILES_DIR/tmux" "$HOME/.tmux"
link_path "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# Tools
link_path "$DOTFILES_DIR/fastfetch" "$HOME/.config/fastfetch"
link_path "$DOTFILES_DIR/bat" "$HOME/.config/bat"
link_path "$DOTFILES_DIR/opencode" "$HOME/.config/opencode"

# VS Code
link_path "$DOTFILES_DIR/vscode/user/settings.json" "$HOME/.config/Code/User/settings.json"
link_path "$DOTFILES_DIR/vscode/user/keybindings.json" "$HOME/.config/Code/User/keybindings.json"

# Scripts
link_path "$DOTFILES_DIR/scripts/listify" "$HOME/.local/bin/listify"
link_path "$DOTFILES_DIR/scripts/listifyq" "$HOME/.local/bin/listifyq"
link_path "$DOTFILES_DIR/scripts/maintenance.sh" "$HOME/.local/bin/maintenance.sh"

# Plugin managers
if ! $SKIP_BOOTSTRAP; then
  install_tpm
fi

if ! $DRY_RUN; then
  printf '\nDone. Restart your shell or run: source ~/.bashrc\n'
  printf 'Run :PlugInstall in Vim to install plugins.\n'
fi
