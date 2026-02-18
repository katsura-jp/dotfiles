# Setup for Ubuntu

## 1. Prerequisites

### System packages
```bash
sudo apt update
sudo apt install -y \
    git wget curl htop vim tmux tree zip unzip \
    python3 python3-pip python3-dev \
    default-jre cmake \
    libncurses5-dev libncursesw5-dev \
    zlib1g-dev libssl-dev liblzma-dev \
    libbz2-dev libreadline-dev libsqlite3-dev \
    python3-tk tk-dev libffi-dev \
    dpkg-dev npm snapd
```

### Core CLI tools
```bash
sudo snap install ripgrep --classic

# Install from GitHub releases or cargo (apt versions are often outdated)
# eza: https://github.com/eza-community/eza
# fd: https://github.com/sharkdp/fd
# bat: https://github.com/sharkdp/bat
# delta: https://github.com/dandavison/delta
# zoxide: https://github.com/ajeetdsouza/zoxide
# ghq: https://github.com/x-motemen/ghq
# jq: sudo apt install jq
# mise: https://mise.jdx.dev/getting-started.html
# lazygit: https://github.com/jesseduffield/lazygit
```

### fzf
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
```

## 2. Shell Setup

### Bash
```bash
sudo apt install bash-completion

# git-completion
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
    -o ~/.git-completion.bash
```

### Zsh (oh-my-zsh)
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Prompt
```bash
# oh-my-posh
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

# starship (alternative)
curl -sS https://starship.rs/install.sh | sh
```

## 3. Dotfiles

```bash
git clone https://github.com/katsura-jp/dotfiles.git
cd dotfiles
make download_fonts
make link
make setup_zsh_plugins   # fzf-tab, zsh-autosuggestions, zsh-syntax-highlighting
```

## 4. Git

```bash
git config --global user.name '<name>'
git config --global user.email '<email>'
git config --global core.editor nvim
git config --global credential.helper store

# GitHub CLI
# See: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
sudo apt install gh
gh auth login
```

## 5. Languages

### Node.js
```bash
curl -L git.io/nodebrew | perl - setup
nodebrew setup
nodebrew install latest
nodebrew use latest
```

### Python
```bash
# uv (recommended)
curl -LsSf https://astral.sh/uv/install.sh | sh
source $HOME/.local/bin/env
uv python install 3.13

# tools
uv tool install ruff
uv tool install mypy
uv tool install pytest

# neovim integration
pip install neovim
```

### Go
```bash
sudo snap install go --classic
sudo snap install gopls --classic
```

### Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
exec $SHELL -l
```

## 6. Neovim

```bash
sudo snap install nvim --classic
nvim   # Lazy.nvim will auto-install plugins on first launch
```

## 7. Cloud & Kubernetes (optional)

```bash
# gcloud
sudo apt install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" \
    | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update && sudo apt install google-cloud-cli

# kubectl & kubectx
sudo snap install kubectl --classic
sudo snap install kubectx --classic
```

## 8. Database (optional)

```bash
sudo snap install mysql --beta
sudo snap install dbeaver-ce
```

## 9. Docker & NVIDIA Container Toolkit (optional)

See official docs:
- [Docker Engine](https://docs.docker.com/engine/install/ubuntu/)
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

## 10. Applications

- [Tailscale](https://tailscale.com/download/)

### asdf (optional, if not using mise)

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1
```
