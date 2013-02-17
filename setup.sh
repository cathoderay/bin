#!/bin/bash
#
# File: setup.sh
# Description: setup dotfiles and custom scripts
#

PREFIX="$HOME/bin/dotfiles"

function task_done {
    echo -e "\e[1;32mDone!\e[0m"
}

function set_link {
    local SRC="$1"
    local TGT="$2"

    if [ -s "$SRC" ]; then
        echo -e "\e[1;34m $SRC already exists. \e[0m"
        return 1
    else
        ln -s $TGT $SRC 
        if [ "$?" = 0 ]; then
            echo -e "\e[1;32m $SRC configured! \e[0m"
        fi
    fi
}

function set_ssh {
    echo -e "\e[1;33m[ssh]\e[0m"
    set_link "$HOME/.ssh/config" "$PREFIX/ssh/config"
}

function set_vim {
    echo -e "\e[1;33m[vim]\e[0m"
    set_link "$HOME/.vimrc" "$PREFIX/vim/vimrc" 
}

function set_git {
    echo -e "\e[1;33m[git]\e[0m"
    set_link "$HOME/.gitconfig" "$PREFIX/git/gitconfig"
}

function add_line {
    local LINE="$1"
    local FILE="$2"
        
    if [ ! -f "$FILE" ]; then
        echo -e "\e[1;34mFile: $FILE does not exists. \e[0m"
        return 1        
    fi
    grep "$LINE" "$FILE"
    if [ ! "$?" = 0 ]; then
        echo "$LINE" >> "$FILE"
        if [ "$?" = 0 ]; then
            echo -e "\e[1;32mLine: \"$LINE\" added to $FILE!\e[0m"
        fi
    else
        echo -e "\e[1;34mLine: \"$LINE\" already exists in $FILE. \e[0m"
    fi
}
    
function set_bashmarks {
    echo -e "\e[1;33m[bashmarks]\e[0m"
    git clone git://github.com/huyng/bashmarks.git /tmp/bashmarks
    if [ ! "$?" = 0 ]; then
        echo -e "\e[1;31mProblem during repository cloning.\e[0m"
        return 1
    fi

    cd /tmp/bashmarks && 
        make install >/dev/null &&
        add_line ". ~/.local/bin/bashmarks.sh" "$PREFIX/bashrc" &&
        cd - &&
        rm -rf /tmp/bashmarks && 
        task_done
}

function set_bashrc {
    echo -e "\e[1;33m[bashrc]\e[0m"
    touch ~/.bashrc && 
        add_line ". $PREFIX/bashrc" ~/.bashrc &&
        task_done
}

case $1 in
    '--bashrc') set_bashrc;;
    '--ssh') set_ssh;;
    '--vim') set_vim;;
    '--git') set_git;;
    '--bashmarks') set_bashmarks;;
    *)
        set_bashrc
        set_ssh
        set_vim
        set_git
        set_bashmarks
        ;;
esac
