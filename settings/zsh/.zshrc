# ~/.zshrc: executed by zsh for interactive shells.

# --------------------------------------------------
# oh-my-zsh
# --------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

plugins=(
  git
  fzf
  fzf-tab
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# --------------------------------------------------
# Shared settings (bash/zsh common)
# --------------------------------------------------

# OS-specific shared settings
if [ "$(uname)" == "Darwin" ]; then
  . $HOME/.config/shell/macos.sh
elif [ "$(uname)" = "Linux" ]; then
  . $HOME/.config/shell/linux.sh
fi

# Common environment variables
. $HOME/.config/shell/env.sh

# Common aliases
. $HOME/.config/shell/aliases.sh

# --------------------------------------------------
# Shared modules (bash/zsh common)
# --------------------------------------------------

# python
if [ -f $HOME/.config/shell/python.sh ]; then
  . $HOME/.config/shell/python.sh
fi

# Go
if [ -f $HOME/.config/shell/go.sh ]; then
  . $HOME/.config/shell/go.sh
fi

# Rust
if [ -f $HOME/.config/shell/rust.sh ]; then
  . $HOME/.config/shell/rust.sh
fi

# Node brew
if [ -d $HOME/.nodebrew ]; then
  . $HOME/.config/shell/nodebrew.sh
fi

# --------------------------------------------------
# Zsh-specific settings
# --------------------------------------------------

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

# fzf (zsh-specific)
if [ -f $HOME/.config/zsh/fzf.zsh ]; then
  . $HOME/.config/zsh/fzf.zsh
fi

# kubectl
if command -v kubectl > /dev/null 2>&1; then
  alias k=kubectl
fi

# zoxide
if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# mise
if command -v mise > /dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi

# starship prompt
if command -v starship > /dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# gcloud (zsh-specific)
if [ "$(uname)" == "Darwin" ] && [ -f /opt/homebrew/bin/brew ]; then
  if [ -d $(brew --prefix)/share/google-cloud-sdk ]; then
    . "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
    . "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"
  fi
fi
