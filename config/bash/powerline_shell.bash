function _update_ps1() {
    if type powerline-shell > /dev/null 2>&1; then
        PS1=$(powerline-shell $?)
    fi
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
