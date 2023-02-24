if status is-interactive
    # Commands to run in interactive sessions can go here
end

# view
set -g theme_display_date yes
set -g theme_date_format "+%F %H:%M"
set -g theme_display_git_default_branch yes
set -g theme_color_scheme nord
set -g fish_prompt_pwd_dir_length 0

export LSCOLORS=Cxfxcxdxbxegedabagacad

# peco
set fish_plugins theme peco

function fish_user_key_bindings
  bind \cw peco_select_history
end

# export
set -x EDITOR nvim
set -x XDG_CONFIG_HOME /Users/katsura/.config
set -x PATH $PATH /Users/katsura/.poetry/bin

set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
eval (pyenv init - | source)

set -x PATH $PATH $HOME/bin
set -x PATH $HOME/.cargo/bin $PATH

set -x LDFLAGS -L/usr/local/opt/openblas/lib
set -x CPPFLAGS -I/usr/local/opt/openblas/include

set -x PKG_CONFIG_PATH /usr/local/opt/openblas/lib/pkgconfig

# alias
alias l='ls'
alias ll='ls -l'
alias cl='clear'
alias gcc=/usr/local/bin/gcc-8

