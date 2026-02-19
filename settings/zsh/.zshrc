# ~/.zshrc: executed by zsh for interactive shells.

# --------------------------------------------------
# oh-my-zsh
# --------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

# fzf must be in PATH before oh-my-zsh loads (for fzf-tab)
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

plugins=(
  git
  fzf
  fzf-tab
  wd
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# --------------------------------------------------
# Shared settings (bash/zsh common)
# --------------------------------------------------

# OS-specific shared settings
if [ "$(uname)" = "Darwin" ]; then
  . $HOME/.config/shell/macos.sh
elif [ "$(uname)" = "Linux" ]; then
  . $HOME/.config/shell/linux.sh
fi

# Common environment variables
. $HOME/.config/shell/env.sh

# Common aliases
. $HOME/.config/shell/aliases.sh

# Don't expand aliases before completion (prevents eza options showing for ls)
setopt COMPLETE_ALIASES

# Completion colors (LS_COLORS)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# fzf-tab: preview for file/directory completions
zstyle ':fzf-tab:complete:*:*' fzf-preview \
  '[ -d "$realpath" ] && eza -1 --color=always --icons "$realpath" || [ -f "$realpath" ] && bat --color=always --line-range :50 "$realpath" 2>/dev/null'

# fzf-tab: press '/' to enter directory (continuous completion)
zstyle ':fzf-tab:*' continuous-trigger 'right'

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

# fzf: completion & key-bindings are handled by oh-my-zsh fzf plugin
# config/zsh/fzf.zsh is NOT sourced here (it would override fzf-tab's Tab binding)

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

# Local overrides (not in dotfiles repo)
if [ -f ~/.bashenv ]; then
    . ~/.bashenv
fi

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Export definitions.
if [ -f ~/.bash_exports ]; then
    . ~/.bash_exports
fi

# gcloud (zsh-specific)
if [ "$(uname)" = "Darwin" ] && [ -f /opt/homebrew/bin/brew ]; then
  _brew_prefix="$(brew --prefix)"
  if [ -d "$_brew_prefix/share/google-cloud-sdk" ]; then
    . "$_brew_prefix/share/google-cloud-sdk/path.zsh.inc"
    . "$_brew_prefix/share/google-cloud-sdk/completion.zsh.inc"
  fi
  unset _brew_prefix
fi
