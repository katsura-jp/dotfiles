# dotfiles

## Quick Start

- [macOS](./docs/macos.md)
- [Ubuntu](./docs/ubuntu.md)

```bash
git clone https://github.com/katsura-jp/dotfiles.git
cd dotfiles
make link
make setup_zsh_plugins
```

## Config

| software | path |
| :-- | :-- |
| neovim (>=0.8) | `config/nvim` |
| wezterm | `config/wezterm/` |
| bash | `settings/bash/`, `config/bash/` |
| zsh | `settings/zsh/`, `config/zsh/` |
| shell (shared) | `config/shell/` |
| git (delta) | `config/git/` |
| tmux | `config/tmux/` |
| fzf | `config/fzf/` |
| starship | `config/starship/` |
| oh-my-posh | `config/oh-my-posh/` |
| oh-my-zsh | `config/oh-my-zsh/` |
| powerline-shell | `config/powerline-shell/` |
| hammerspoon | `config/hammerspoon/` |

## Commands

| command | description |
| :-- | :-- |
| `make link` | Create symbolic links |
| `make unlink` | Remove symbolic links |
| `make download_fonts` | Download fonts (Inconsolata, Source Han Code JP, Moralerspace) |
| `make setup_zsh_plugins` | Install oh-my-zsh custom plugins (fzf-tab, autosuggestions, syntax-highlighting) |
