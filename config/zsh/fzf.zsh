# fzf zsh-specific settings
# NOTE: fzf PATH and FZF_DEFAULT_OPTS are in config/shell/aliases.sh (shared)

# Auto-completion
[[ $- == *i* ]] && source $HOME/.fzf/shell/completion.zsh 2> /dev/null

# Key bindings
[ -f $HOME/.fzf/shell/key-bindings.zsh ] && source $HOME/.fzf/shell/key-bindings.zsh
