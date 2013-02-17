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
    SSH_SRC="$HOME/.ssh/config"
    SSH_TGT="$PREFIX/ssh/config"
    set_link $SSH_SRC $SSH_TGT
}

function set_vim {
    VIM_SRC="$HOME/.vimrc"
    VIM_TGT="$PREFIX/vim/vimrc"
    set_link $VIM_SRC $VIM_TGT 
}

function set_git {
    GIT_SRC="$HOME/.gitconfig"
    GIT_TGT="$PREFIX/git/gitconfig"
    set_link $GIT_SRC $GIT_TGT 
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
