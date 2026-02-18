# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)

case $- in
    *i*) ;;
      *) return;;
esac

# history
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# --------------------------------------------------
# Shared settings (bash/zsh common)
# --------------------------------------------------

# OS-specific shared settings
if [ "$(uname)" == "Darwin" ]; then
  . $HOME/.config/shell/macos.sh
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  . $HOME/.config/shell/linux.sh
fi

# Common environment variables
. $HOME/.config/shell/env.sh

# Common aliases
. $HOME/.config/shell/aliases.sh

# --------------------------------------------------
# Bash-specific settings
# --------------------------------------------------

# OS-specific bash settings
if [ "$(uname)" == "Darwin" ]; then
  . $HOME/.config/bash/macos.bash
fi

# prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Environment variables
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

# bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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
# Bash-specific modules
# --------------------------------------------------

# fzf
if [ -f $HOME/.config/bash/fzf.bash ]; then
  . $HOME/.config/bash/fzf.bash
fi

# Git completion
if [ -f $HOME/.git-completion.bash ]; then
  . $HOME/.git-completion.bash
fi

# kubectl
if command -v kubectl > /dev/null 2>&1; then
  if [ ! -f $HOME/.config/bash/kubectl-completion.bash ]; then
    kubectl completion bash > $HOME/.config/bash/kubectl-completion.bash
  fi
  . $HOME/.config/bash/kubectl-completion.bash
  alias k=kubectl
  complete -F __start_kubectl k
fi

# zoxide
if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

# mise
if command -v mise > /dev/null 2>&1; then
  eval "$(mise activate bash)"
fi

# starship prompt
if command -v starship > /dev/null 2>&1; then
  eval "$(starship init bash)"
fi
