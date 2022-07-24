if [[ -f "$HOME/.zprofile" ]]; then
    source $HOME/.zprofile
fi
if [[ -f "$HOME/.zshrc" ]]; then
    source $HOME/.zshrc
fi
if [[ -f "$HOME/.zlogin" ]]; then
    source $HOME/.zlogin
fi

# drastically improve performance for ohmyzsh's git plugin
DISABLE_UNTRACKED_FILES_DIRTY="true"

source .bashrc_local
