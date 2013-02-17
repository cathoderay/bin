#!/bin/bash
#
# File: setup_dotfiles.sh
# Description: setup dotfiles and custom scripts
#


PREFIX="$HOME/bin/dotfiles"


function set_ssh {
    SRC="$HOME/.ssh/config"
    TGT="$PREFIX/ssh/config"

    if [ -s "$SRC" ]; then
        echo "$SRC already exists."
    else
        ln -s $TGT $SRC
        if [ "$?" = 0 ]; then
            echo "$SRC configured!"
        fi
    fi
}

function set_vim {
    SRC="$HOME/.vimrc"
    TGT="$PREFIX/vim/vimrc"

    if [ -s "$SRC" ]; then
        echo "$SRC already exists."
    else
        ln -s $TGT $SRC 
        if [ "$?" = 0 ]; then
            echo "$SRC configured!"
        fi
    fi
}

function set_git {
    SRC="$HOME/.gitconfig"
    TGT="$PREFIX/git/gitconfig"

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
    '--ssh') set_ssh ;;
    '--git') set_git ;;
    '--vim') set_vim ;;
    *)
        set_ssh
        set_git
        set_vim
        ;;
esac
