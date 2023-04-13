# dotfiles

## Start Guide

### Install Dependency
**macOS**
```
# install xcode
xcode-select --install > /dev/null
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/opt/homebrew/bin/brew shellenv)

# install software
brew install bash coreutils ripgrep neovim xz wget
brew install --cask hammerspoon
brew install --cask visual-studio-code
brew install --cask wezterm

# git
git config --global user.name '<name>'
git config --global user.email '<mail address>'
git config --global core.editor nvim
git config --global credential.helper osxkeychain

# install dotfiles
git clone https://github.com/katsura-jp/dotfiles.git
cd dotfiles
make link

# set bash
sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
chsh -s /opt/homebrew/bin/bash

# install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
exec "$SHELL"

# set python version
export PYTHON_VERSION='3.10.10'
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# install python software
pip install -U pip setuptools
brew install pipx
pipx ensurepath
exec $SHELL -l
pipx install powerline-shell
pip install neovim
pipx install pdm poetry

# npm
brew install nodebrew
nodebrew setup
nodebrew install latest
nodebrew use latest

# bash
# bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --no-modify-config
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin

# Go lang
brew install go gopls

# Rust
brew install rustup-init
rustup-init
exec $SHELL -l

# gcloud
brew install google-cloud-sdk
# gcloud components update # if you already installed
gcloud components install kubectl
brew install --ignore-dependencies kubectx
```

### Setup
```
make link
```

## Config
| software | path |
| :--      | :--  |
| neovim (>=0.8)  | `config/nvim` |
| wezterm | `config/wezterm/` |
| fuzzy finder | `config/fzf`, `.fzf.bash` |
| bash | `.bashrc`, `.bash_profile` |
| powerline-shell | `config/powerline-shell` |
| hammerspoon | `.hammerspoon` |



