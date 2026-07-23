# Common environment variables (bash/zsh shared)

export LANG=en_US.UTF-8
export EDITOR=nvim
export PATH="$PATH:$HOME/.local/bin"
export CLOUDSDK_PYTHON_SITEPACKAGES=1

# bat (also used by delta for syntax highlighting)
export BAT_THEME="ansi"

# k9s: keep config under ~/.config/k9s (default is ~/Library/Application Support/k9s on macOS)
export K9S_CONFIG_DIR="$HOME/.config/k9s"

export CLAUDE_CODE_DISABLE_EXPERIMENTAL_BETAS=1

# Machine-local secrets (not tracked in git)
LOCAL_ENV="$(cd "$(dirname "$0")" && pwd)/env.local.sh"
[ -f "$LOCAL_ENV" ] && . "$LOCAL_ENV"
unset LOCAL_ENV
