# Setup for macOS

## Install Xcode & Homebrew
```
xcode-select --install > /dev/null
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/opt/homebrew/bin/brew shellenv)
```

## Bash
```
brew install bash
sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
chsh -s /opt/homebrew/bin/bash
exec "$SHELL"

# fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
# bash-completion
brew install bash-completion
# git-completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
```

## Install standard softwares for development
```
brew install \
    coreutils \
    wget \
    xz \
    ripgrep \
    bat
brew install --cask hammerspoon
brew install --cask wezterm
```

## Dotfiles
```
git clone https://github.com/katsura-jp/dotfiles.git
cd dotfiles
make download_fonts
make link
```

## node.js
```
brew install nodebrew
nodebrew setup
nodebrew install latest
nodebrew use latest
```

## Neovim
```
brew install neovim
nvim
```

## Visual Studio Code
```
brew install --cask visual-studio-code

# install extentions
code --install-extension enkia.tokyo-night
code --install-extension asvetliakov.vscode-neovim
code --install-extension ms-python.python
code --install-extension golang.go
code --install-extension GitHub.copilot
code --install-extension eamodio.gitlens
code --install-extension Gruntfuggly.todo-tree
code --install-extension jeff-hykin.better-dockerfile-syntax
code --install-extension ms-azuretools.vscode-docker
code --install-extension MS-CEINTL.vscode-language-pack-ja
code --install-extension ms-vscode-remote.remote-ssh
code --install-extension ms-vscode-remote.remote-containers
code --install-extension ms-vscode.makefile-tools
code --install-extension ms-vsliveshare.vsliveshare
code --install-extension oderwat.indent-rainbow
code --install-extension PKief.material-icon-theme
code --install-extension ritwickdey.LiveServer
code --install-extension vscode-icons-team.vscode-icons
code --install-extension wayou.vscode-todo-highlight
code --install-extension njpwerner.autodocstring
code --install-extension christian-kohler.path-intellisense
code --install-extension ms-python.black-formatter
code --install-extension ms-python.isort

# sync
code --sync on
```

## Git
```
git config --global user.name '<name>'
git config --global user.email '<mail address>'
git config --global core.editor nvim
git config --global credential.helper osxkeychain

# GitHub CLI
brew install gh
gh auth login

# lazygit
brew install jesseduffield/lazygit/lazygit
# tig
brew install tig
```


## Python
```
# pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update
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
curl -sSf https://rye-up.com/get | bash
pipx install flake8 black isort mypy pytest
```



## Go
```
brew install go gopls
```

## Rust
```
brew install rustup-init
rustup-init
exec $SHELL -l
```

## gcloud / k8s
```
brew install google-cloud-sdk
# gcloud components update # if you already installed

gcloud components install kubectl
brew install --ignore-dependencies kubectx
brew install datawire/blackbird/telepresence-arm64
```

## SQL
```
brew install mysql
brew install --cask dbeaver-community
```

## gRPC
```
brew install grpcurl
brew tap ktr0731/evans
brew install evans
```

## Other
`システム環境設定` > `プライバシーとセキュリティ` > `フルディスクアクセス` から `wezterm` をONにする。
