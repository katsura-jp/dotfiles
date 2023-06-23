# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source $HOME/.fzf/shell/completion.bash 2> /dev/null

# Key bindings
# ------------
source $HOME/.config/fzf/shell/key-bindings.bash


export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
# history sharing
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# key-bind
# bind -r "\C-p" "previous-history"
bind -r "\C-p"

