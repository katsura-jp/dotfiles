if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

# direnv
if command -v direnv > /dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# asdf
if [ -f $HOME/.config/bash/asdf.bash ]; then
  . $HOME/.config/bash/asdf.bash
fi

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac
