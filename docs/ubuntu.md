# Setup for Ubuntu
```
# Install basic softwares
sudo apt update
sudo apt install -y \
    git wget htop vim tmux tree zip unzip \
    python3 python3-pip python3-dev \
    default-jre cmake libncurses5-dev libncursesw5-dev \
    zlib1g-dev libssl-dev liblzma-dev \
    libbz2-dev libreadline-dev libsqlite3-dev \
    python3-tk tk-dev libffi-dev \
    dpkg-dev \
    npm
sudo apt update
sudo apt install snapd

sudo snap install nvim --classic
sudo snap install ripgrep --classic

# git
git config --global user.name '<name>'
git config --global user.email '<mail address>'
git config --global core.editor nvim
git config --global credential.helper store

# install dotfiles
git clone https://github.com/katsura-jp/dotfiles.git
cd dotfiles
sudo make download_fonts
make link

# install pyenv
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
git clone https://github.com/pyenv/pyenv-update.git ~/.pyenv/plugins/pyenv-update
exec "$SHELL"

# set python version
export PYTHON_VERSION='3.10.10'
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION

# install python software
pip install -U pip setuptools
python -m pip install --user pipx
pipx ensurepath
exec $SHELL -l
pipx install powerline-shell
pip install neovim
pipx install pdm
pip install poetry pipenv 
curl -sSf https://rye-up.com/get | bash

# npm
export NPM_CONFIG_PREFIX=$HOME/.npm-global
mkdir $NPM_CONFIG_PREFIX
npm config set prefix $NPM_CONFIG_PREFIX
export PATH=$NPM_CONFIG_PREFIX/bin:$PATH
npm install -g n
export N_PREFIX=$HOME/n
n stable
node -v

# bash
# bash-it
git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
~/.bash_it/install.sh --no-modify-config
# fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin

# bash-completion
sudo apt install bash-completion
# git-completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash

# Go lang
sudo snap install go --classic
sudo snap install gopls --classic

# Rust
sudo snap install rustup-init --classic
rustup update stable
exec $SHELL -l

# gcloud
sudo apt-get install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update && sudo apt-get install google-cloud-cli

# gcloud components update # if you already installed
sudo snap install kubectl --classic
sudo snap install kubectx --classic

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

# SQL
sudo snap install mysql --beta
sudo snap install dbeaver-ce
```

## Reference
- [GitHub CLI](https://github.com/cli/cli#linux--bsd)
- [lazygit](https://github.com/jesseduffield/lazygit#ubuntu)
- [tig](https://jonas.github.io/tig/INSTALL.html)
