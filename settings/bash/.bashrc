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

# language
export LANG=en_US.UTF-8

# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ "$(uname)" == "Darwin" ]; then
  # macOS settings
  . $HOME/.config/bash/macos.bash
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  # Linux settings
  . $HOME/.config/bash/linux.bash
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

# enable color support of ls and also add handy aliases
if command -v dircolors > /dev/null 2>&1; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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


export PATH="$PATH:$HOME/.local/bin"

export EDITOR=nvim
export CLOUDSDK_PYTHON_SITEPACKAGES=1

# --------------------------------------------------

# python
if [ -f $HOME/.config/bash/python.bash ]; then
  . $HOME/.config/bash/python.bash
fi

# Go
if [ -f $HOME/.config/bash/go.bash ]; then
  . $HOME/.config/bash/go.bash
fi

# Rust
if [ -f $HOME/.config/bash/rust.bash ]; then
  . $HOME/.config/bash/rust.bash
fi

# fzf
if [ -f $HOME/.config/bash/fzf.bash ]; then
  . $HOME/.config/bash/fzf.bash
fi

# Node brew
if [ -d $HOME/.nodebrew ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
fi

# Git completion
if [ -f $HOME/.git-completion.bash ]; then
  . $HOME/.git-completion.bash
fi

# lazygit
if command -v lazygit > /dev/null 2>&1; then
  alias lg="lazygit"
fi

# bat
if command -v batcat > /dev/null 2>&1; then
  alias bat="batcat"
  export FZF_CTRL_T_OPTS='--preview "batcat --color=always --style=numbers,header,grid --line-range :100 {}"'
elif type "bat" > /dev/null 2>&1; then
  export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers,header,grid --line-range :100 {}"'
fi

# rigrep
if command -v rg > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
  export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
  export FZF_LEGACY_KEYBINDINGS=0
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

# oh-my-posh
if command -v oh-my-posh > /dev/null 2>&1; then
  unset PROMPT_COMMAND
  eval "$(oh-my-posh init bash --config $HOME/.config/oh-my-posh/theme/dracula.omp.json | sed 's|\[\[ -v MC_SID \]\]|[[ -n "$MC_SID" ]]|')"
fi

# npm
if command -v nodebrew > /dev/null 2>&1; then
  . $HOME/.config/bash/nodebrew.bash
fi
