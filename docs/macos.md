# Setup for macOS

## 1. Prerequisites

### Xcode & Homebrew
```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval $(/opt/homebrew/bin/brew shellenv)
```

### Core CLI tools
```bash
brew install \
    coreutils wget xz \
    ripgrep bat fd eza \
    git-delta jq ghq zoxide mise \
    lazygit tig
```

### fzf
```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --bin
```

## 2. Shell Setup

### Bash
```bash
brew install bash bash-completion
sudo sh -c 'echo /opt/homebrew/bin/bash >> /etc/shells'
chsh -s /opt/homebrew/bin/bash

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
brew install jandedobbeleer/oh-my-posh/oh-my-posh

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
git config --global credential.helper osxkeychain

brew install gh
gh auth login
```

## 5. Languages

### Node.js
```bash
brew install nodebrew
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

# powerline-shell (optional)
brew install pipx
pipx ensurepath
pipx install powerline-shell
```

### Go
```bash
brew install go gopls
```

### Rust
```bash
brew install rustup-init
rustup-init
exec $SHELL -l
```

## 6. Neovim

```bash
brew install neovim
nvim   # Lazy.nvim will auto-install plugins on first launch
```

## 7. Cloud & Kubernetes (optional)

```bash
brew install google-cloud-sdk
gcloud components install kubectl
brew install --ignore-dependencies kubectx
brew install kustomize
```

## 8. Database (optional)

```bash
brew install mysql
brew install --cask dbeaver-community
```

## 9. gRPC (optional)

```bash
brew install grpcurl
brew tap ktr0731/evans
brew install evans
```

## 10. Applications

```bash
brew install --cask hammerspoon
brew install --cask wezterm
brew install stats
```

> WezTerm: Go to `System Settings > Privacy & Security > Full Disk Access` and enable `wezterm`.

- [Docker Desktop](https://docs.docker.com/desktop/install/mac-install/)
- [Tailscale](https://tailscale.com/download/)

### asdf (optional, if not using mise)

```bash
brew install asdf
echo 'export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"' >> $HOME/.zshrc
mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"
```
