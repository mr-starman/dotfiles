# dotfiles

Personal dotfiles managed as symlinks from `$HOME`.

## Install

```sh
git clone git@github.com:mr-starman/dotfiles.git && cd dotfiles
./install.sh
```

The installer:

- Symlinks shell, Git, editor, terminal, and tool configs into `~/`
- Creates targets inside directories (`~/.config/...`) as needed
- Backs up existing files/directories to `<target>.backup.<timestamp>` before replacing them (files and existing symlinks are replaced without a backup)
- Bootstraps [TPM](https://github.com/tmux-plugins/tpm) and [vim-plug](https://github.com/junegunn/vim-plug)
- Skips missing sources with a warning

Run `./install.sh --dry-run` to preview actions without changing anything, or `--help` for usage.

## Post-install

| Step | Command |
| --- | --- |
| Reload shell | `source ~/.bashrc` |
| Install Vim plugins (vim-plug) | `vim +PlugInstall` |
| Install tmux plugins (TPM) | `tmux` then `prefix + I` |

After installing tmux plugins, start a tmux session and load the [Catppuccin theme](https://github.com/catppuccin/tmux) via the status line.

## Layout

| Path | Manages |
| --- | --- |
| `bash/` | `~/.bashrc`, `~/.bash_aliases`, `~/.bash_profile`, `~/.bash_logout`, `~/.inputrc`, `~/.digrc` |
| `git/` | `~/.gitconfig`, `~/.git-prompt.sh` |
| `vim/` | `~/.vim` (config + vendored vim-plug) |
| `nvim/` | `~/.config/nvim` (Lazy.nvim, plugin versions pinned in `nvim/lazy-lock.json`) |
| `alacritty/` | `~/.config/alacritty` |
| `tmux/` | `~/.tmux` + `~/.tmux.conf` (TPM plugins under `tmux/plugins/`) |
| `fastfetch/` | `~/.config/fastfetch` |
| `bat/` | `~/.config/bat` |
| `opencode/` | `~/.config/opencode` |
| `vscode/` | `~/.config/Code/User` settings and keybindings |
| `scripts/` | `~/.local/bin` (`listify`, `listifyq`, `maintenance.sh`) |

## Prerequisites

Install these before running the installer so validation tools and themes work:

- `alacritty`, `tmux` (+ TPM), `fastfetch`, `bat`
- `vim` and `neovim` (with `lazy.nvim` bootstrapped at first launch)
- `fzf`, `rg` (used by shell and editor configs)
- `curl`, `git`

Other configs reference extra tools (`pacman`, `yay`, `docker`, `minikube`, jq, etc.); those aliases are harmless if the tools are absent.