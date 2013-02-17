#!/bin/bash
#
# File: setup_dotfiles.sh
# Description: setup dotfiles and custom scripts
#

PREFIX="$HOME/bin/dotfiles"


function set_link {
    SRC="$1"
    TGT="$2"

    if [ -s "$SRC" ]; then
        echo "$SRC already exists."
    else
        ln -s $TGT $SRC 
        if [ "$?" = 0 ]; then
            echo "$SRC configured!"
        fi
    fi
}


case $1 in
    '--ssh') set_link "$HOME/.ssh/config" "$PREFIX/ssh/config";;
    '--vim') set_link "$HOME/.vimrc" "$PREFIX/vim/vimrc";;
    '--git') set_link "$HOME/.gitconfig" "$PREFIX/git/gitconfig";;
    *)
        set_link "$HOME/.ssh/config" "$PREFIX/ssh/config"
        set_link "$HOME/.vimrc" "$PREFIX/vim/vimrc" 
        set_link "$HOME/.gitconfig" "$PREFIX/git/gitconfig"
        ;;
esac
