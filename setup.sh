#!/bin/sh

if [ "$(whoami)" = root ]
then
    echo "Run this as a user, not as root."
    exit
fi

if [ -z "${HOME}" ]
then
    echo '$HOME undefined.'
    exit
fi

# Vim
ln -s ${HOME}/Dotfiles/vimrc ${HOME}/.vimrc
mkdir -p ${HOME}/.vim/colors
ln -s ${HOME}/Dotfiles/wombat.vim ${HOME}/.vim/colors/

# Zsh
ln -s ${HOME}/Dotfiles/zshrc ${HOME}/.zshrc
