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

function set_ssh {
    set_link "$HOME/.ssh/config" "$PREFIX/ssh/config"
}

function set_vim {
    set_link "$HOME/.vimrc" "$PREFIX/vim/vimrc" 
}

function set_git {
    set_link "$HOME/.gitconfig" "$PREFIX/git/gitconfig"
}

case $1 in
    '--ssh') set_ssh;;
    '--vim') set_vim;;
    '--git') set_git;;
    *)
        set_ssh
        set_vim
        set_git
        ;;
esac
