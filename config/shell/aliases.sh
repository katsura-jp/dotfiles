# Common aliases and fzf settings (bash/zsh shared)

# fzf
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# eza (modern ls replacement)
if command -v eza > /dev/null 2>&1; then
  alias ls='eza --icons'
  alias ll='eza -alF --icons --git'
  alias la='eza -a --icons'
  alias l='eza -F --icons'
  alias tree='eza --tree --icons'
else
  if command -v dircolors > /dev/null 2>&1; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi

# lazygit
if command -v lazygit > /dev/null 2>&1; then
  alias lg="lazygit"
fi

# bat
if command -v batcat > /dev/null 2>&1; then
  alias bat="batcat"
  export FZF_CTRL_T_OPTS='--preview "batcat --color=always --style=numbers,header,grid --line-range :100 {}"'
elif command -v bat > /dev/null 2>&1; then
  export FZF_CTRL_T_OPTS='--preview "bat --color=always --style=numbers,header,grid --line-range :100 {}"'
fi

# fd + fzf integration
if command -v fd > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
elif command -v rg > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
  export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
fi
export FZF_LEGACY_KEYBINDINGS=0

# ghq + fzf
if command -v ghq > /dev/null 2>&1 && command -v fzf > /dev/null 2>&1; then
  ghq-fzf() {
    local repo
    repo=$(ghq list | fzf --preview "bat --color=always --style=header,grid $(ghq root)/{}/README.md 2>/dev/null || ls $(ghq root)/{}")
    if [ -n "$repo" ]; then
      cd "$(ghq root)/$repo"
    fi
  }
  alias repos="ghq-fzf"
fi

