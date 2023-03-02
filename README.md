# dotfiles

## Start Guide

### Install Dependency
**macOS**
```
brew install git coreutils ripgrep
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

```

### Setup
```
mkdir --ignore-fail-on-non-empty ~/.config
ln -s ~/dotfiles/config/nvim ~/.config/nvim
ln -s ~/dotfiles/config/wezterm ~/.config/wezterm
```

## TODO:
- [x] neovim
- [x] hammerspoon
- [x] wezterm
- [ ] tmux
- [x] bash
- [ ] zsh
- [x] fish
