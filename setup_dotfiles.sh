#!/bin/bash
#
# File: setup_dotfiles.sh
# Description: setup dotfiles and custom scripts
#

PREFIX="$HOME/bin/dotfiles"

SSH_SRC="$HOME/.ssh/config"
SSH_TGT="$PREFIX/ssh/config"

VIM_SRC="$HOME/.vimrc"
VIM_TGT="$PREFIX/vim/vimrc"

GIT_SRC="$HOME/.gitconfig"
GIT_TGT="$PREFIX/git/gitconfig"


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
    '--ssh') set_link $SSH_SRC $SSH_TGT;;
    '--vim') set_link $VIM_SRC $VIM_TGT;;
    '--git') set_link $GIT_SRC $GIT_TGT;;
    *)
        set_link $SSH_SRC $SSH_TGT
        set_link $VIM_SRC $VIM_TGT
        set_link $GIT_SRC $GIT_TGT
        ;;
esac
