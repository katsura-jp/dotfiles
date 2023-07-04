if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

# direnv
if command -v direnv > /dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac
