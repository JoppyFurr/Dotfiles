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

echo
echo "  ╭────────────────────────╮"
echo "  │  Snepper Setup Script  │"
echo "  ╰────────────────────────╯"
echo

echo "Package Installation:"

PACKAGES="
    build-essential
    curl
    git
    htop
    keepassxc
    kpcli
    suckless-tools
    vim
    vim-gtk
    xfonts-terminus
    zsh"

for PACKAGE in ${PACKAGES}
do
    if dpkg -s ${PACKAGE} > /dev/null 2> /dev/null
    then
        echo " -> ${PACKAGE} is already installed."
    else
        echo " -> Installing ${PACKAGE}"
        sudo apt-get install ${PACKAGE}
    fi
done
echo

# Vim
echo "Vim Setup:"
ln -s ${HOME}/Dotfiles/vimrc ${HOME}/.vimrc 2>/dev/null
mkdir -p ${HOME}/.vim/colors
mkdir -p ${HOME}/.vim/pack/plugins/start
ln -s ${HOME}/Dotfiles/wombat.vim ${HOME}/.vim/colors/ 2>/dev/null
echo "Install Vim Lightline with:"
echo "  'git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline'"
echo "Install VimWiki with:"
echo "  'git clone https://github.com/vimwiki/vimwiki.git ~/.vim/pack/plugins/start/vimwiki'"
echo

# Zsh
ln -s ${HOME}/Dotfiles/zshrc ${HOME}/.zshrc 2>/dev/null
