#!/bin/bash
# Install oh-my-zsh and custom plugins

set -e

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing oh-my-zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  echo "oh-my-zsh installed."
else
  echo "oh-my-zsh already installed."
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

clone_if_missing() {
  local repo=$1
  local dest=$2
  if [ ! -d "$dest" ]; then
    echo "Installing $(basename $dest)..."
    git clone "$repo" "$dest"
  else
    echo "$(basename $dest) already installed."
  fi
}

clone_if_missing https://github.com/Aloxaf/fzf-tab "$ZSH_CUSTOM/plugins/fzf-tab"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

echo "Done."
