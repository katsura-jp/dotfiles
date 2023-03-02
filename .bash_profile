if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# bash_it
export BASH_IT="$HOME/.bash_it"
export GIT_HOSTING='git@git.domain.com'
unset MAILCHECK
export IRC_CLIENT='irssi'
export TODO="t"
export SCM_CHECK=true
source $BASH_IT/bash_it.sh
