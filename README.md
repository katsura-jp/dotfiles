# dotfiles

## Start Guide

### Install Dependency
**macOS**
```
# install xcode
xcode-select --install > /dev/null
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# install software
brew install bash coreutils ripgrep neovim xy
brew install hammerspoon --cask

# set bash
sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
chsh -s /opt/homebrew/bin/bash
touch ~/.bashrc
touch ~/.bash_profile

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

# install powerline-shell
pip install powerline-shell

# set git
git config --global user.name 'your name'
git config --global user.email 'your address'
git config --global core.editor nvim
git config --global credential.helper osxkeychain

# bash
# bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --no-modify-config
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
# bat
brew install bat

```

### Setup
```
sh setup.sh
```

## TODO:
- [x] neovim
- [x] hammerspoon
- [x] wezterm
- [ ] tmux
- [x] bash
- [ ] zsh
