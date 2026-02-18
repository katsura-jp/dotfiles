# fzf bash-specific settings
# NOTE: fzf PATH and FZF_DEFAULT_OPTS are in config/shell/aliases.sh (shared)

# Auto-completion
[[ $- == *i* ]] && source $HOME/.fzf/shell/completion.bash 2> /dev/null

# Key bindings
source $HOME/.config/fzf/shell/key-bindings.bash

# history sharing across sessions
PROMPT_COMMAND="history -a; history -c; history -r${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

# key-bind
bind -r "\C-p"
