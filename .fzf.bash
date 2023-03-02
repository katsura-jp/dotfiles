# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/katsura/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source $HOME/.fzf/shell/completion.bash 2> /dev/null

# Key bindings
# ------------
source $HOME/config/fzf/shell/key-bindings.bash
