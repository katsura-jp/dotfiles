# Setup for macOS

## Install Xcode & Homebrew
```
xcode-select --install > /dev/null
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/opt/homebrew/bin/brew shellenv)
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

## fuzzy finder
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
```

## Bash
```
brew install bash
sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
chsh -s /opt/homebrew/bin/bash
exec "$SHELL"

# bash-completion
brew install bash-completion

# git-completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
```

## Zsh
```
echo >> $HOME/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
touch $HOME/.zshrc

# bash-completion
brew install zsh-completion

# git-completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh -o ~/.git-completion.zsh
```


## oh-my-posh
```
brew install jandedobbeleer/oh-my-posh/oh-my-posh
oh-my-posh font install Inconsolata
oh-my-posh font install monaspace
```

## [asdf](https://asdf-vm.com/guide/getting-started.html)
```
brew install asdf

echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> $HOME/.zshrc

# zsh
mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"

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
# asdf
asdf plugin add python
asdf list all python
export PYTHON_VERSION='3.13.11'
asdf install python $PYTHON_VERSION
asdf set -u python $PYTHON_VERSION

# install uv
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env

# install python 3.13
uv python list
uv python install 3.13
uv python pin 3.13 --global

# install python software
pip install -U pip setuptools
brew install pipx
pipx ensurepath
exec $SHELL -l
pipx install powerline-shell
pip install neovim

# install linter/formatter/tester
uv tool install ruff
uv tool install black
uv tool install isort
uv tool install mypy
uv tool install pytest
```

## oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

brew install kustomize
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

## [inshellisense](https://github.com/microsoft/inshellisense)
```
brew install fig

npm install -g @microsoft/inshellisense
inshellisense --shell bash
inshellisense bind
```

## WezTerm
`システム環境設定` > `プライバシーとセキュリティ` > `フルディスクアクセス` から `wezterm` をONにする。

## Docker
https://docs.docker.com/desktop/install/mac-install/

## Tailscale
https://tailscale.com/download/

## Others
- Obsidian
- Arc Browser
- [Cron](https://cron.com/download/macos)
- [Stats](https://github.com/exelban/stats)

```
brew tap FelixKratz/formulae
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

brew install helm

brew install obsidian
brew install --cask arc
brew install --cask cron
brew install stats

brew install ttyrec
brew install ttygif
```


