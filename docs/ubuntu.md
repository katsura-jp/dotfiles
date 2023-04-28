# Ubuntuの初期設定
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
```

# setup
```
sudo make download_fonts
```