# brew
if [ -f /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)

    # gcloud
    if [ -d $(brew --prefix)/share/google-cloud-sdk ]; then
        . "$(brew --prefix)/share/google-cloud-sdk/path.bash.inc"
    fi
    # bash_completion
    if [ -r $(brew --prefix)/etc/profile.d/bash_completion.sh ]; then
        . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
    fi

fi

