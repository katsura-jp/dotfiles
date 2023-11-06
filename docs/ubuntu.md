# Setup for Ubuntu

## Install standard softwares for development
```
sudo apt update
sudo apt install -y \
    git wget htop vim tmux tree zip unzip \
    python3 python3-pip python3-dev \
    default-jre cmake libncurses5-dev libncursesw5-dev \
    zlib1g-dev libssl-dev liblzma-dev \
    libbz2-dev libreadline-dev libsqlite3-dev \
    python3-tk tk-dev libffi-dev \
    dpkg-dev \
    npm unzip
sudo apt update
sudo apt install snapd

sudo snap install ripgrep --classic
```

## Bash
```
# bash-completion
sudo apt install bash-completion

# git-completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# fuzzy finder
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
```

## oh-my-posh & font
```
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
export PATH="$PATH:$HOME/.local/bin"

oh-my-posh font install Inconsolata

wget https://github.com/adobe-fonts/source-han-code-jp/releases/download/2.012R/SourceHanCodeJP.ttc -P ~/.local/share/fonts/
```

## [asdf](https://asdf-vm.com/guide/getting-started.html)
```
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0
```

## Dotfiles
```
git clone https://github.com/katsura-jp/dotfiles.git
cd dotfiles
make link
```

## node.js
```
curl -L git.io/nodebrew | perl - setup
nodebrew setup
nodebrew install latest
nodebrew use latest
```

## Neovim
```
sudo snap install nvim --classic
nvim
```

## (Optional) Visual Studio Code
```
sudo snap install visual-studio-code --classic
code --sync on
```

## Git
```
git config --global user.name '<name>'
git config --global user.email '<mail address>'
git config --global core.editor nvim
git config --global credential.helper store

# GitHub CLI
type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
&& sudo apt update \
&& sudo apt install gh -y
gh auth login

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# tig
git clone https://github.com/jonas/tig.git
make prefix=/usr/local
sudo make install prefix=/usr/local
rm -rf tig
```

## Python
```
# asdf
asdf plugin-add python

export PYTHON_VERSION='3.10.10'
asdf global python $PYTHON_VERSION


# install python software
pip install -U pip setuptools
pip install -U pipx
pipx ensurepath
exec $SHELL -l
pip install neovim

# install linter/formatter/tester
pipx install black
pipx install isort
pipx install mypy
pipx install pytest

# install package manager
pipx install pdm
pipx install poetry
pipx install pipenv
curl -sSf https://rye-up.com/get | bash
```

## Go
```
sudo snap install go --classic
sudo snap install gopls --classic
```

## Rust
```
sudo snap install rustup-init --classic
rustup update stable
exec $SHELL -l
```
## gcloud / k8s
```
# gcloud
sudo apt-get install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli

# gcloud components update # if you already installed
sudo snap install kubectl --classic
sudo snap install kubectx --classic

# telepresence

```

## SQL
```
sudo snap install mysql --beta
sudo snap install dbeaver-ce
```

## gRPC
```
```

## WezTerm
```
```

## [Docker](https://docs.docker.com/engine/install/ubuntu/) & [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# NVIDIA Container Toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
  && \
    sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
```

## Tailscale
```
```

## ttyrec&ttygif
```
sudo apt install ttyrec ttygif
```

## (Optional) Other
```
```

## Reference
- [GitHub CLI](https://github.com/cli/cli#linux--bsd)
- [lazygit](https://github.com/jesseduffield/lazygit#ubuntu)
- [tig](https://jonas.github.io/tig/INSTALL.html)
