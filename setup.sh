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

#############################
##  Package Configuration  ##
#############################

echo "Package Installation:"
PACKAGES="
    build-essential
    curl
    git
    htop
    keepassxc
    kpcli
    suckless-tools
    telegram-desktop
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

#########################
##  Vim Configuration  ##
#########################
echo "Vim Setup:"
ln -s ${HOME}/Dotfiles/vimrc ${HOME}/.vimrc 2>/dev/null
mkdir -p ${HOME}/.vim/colors
mkdir -p ${HOME}/.vim/pack/plugins/start
ln -s ${HOME}/Dotfiles/wombat.vim ${HOME}/.vim/colors/ 2>/dev/null

if [ -e "${HOME}/.vim/pack/plugins/start/lightline/" ]
then
    echo " -> Lightline is already installed."
else
    echo "Install Vim Lightline with:"
    echo "  'git clone https://github.com/itchyny/lightline.vim ~/.vim/pack/plugins/start/lightline'"
fi

if [ -e "$HOME/.vim/pack/plugins/start/vimwiki/" ]
then
    echo " -> VimWiki is already installed."
else
    echo "Install VimWiki with:"
    echo "  'git clone https://github.com/vimwiki/vimwiki.git ~/.vim/pack/plugins/start/vimwiki'"
fi
echo

#########################
##  Zsh Configuration  ##
#########################
echo "Zsh Setup:"
ln -s ${HOME}/Dotfiles/zshrc ${HOME}/.zshrc 2>/dev/null
if [ "$(cat /etc/passwd | grep ^$(whoami) | cut -d : -f 7)" = "/usr/bin/zsh" ]
then
    echo " -> Zsh is already the login shell"
else
    echo "Enable Zsh with:"
    echo "  'chsh --shell /usr/bin/zsh'"
fi
echo

#########################
##  SSH Configuration  ##
#########################
echo "SSH Setup:"
if [ -e "${HOME}/.ssh/id_ed25519" ]
then
    echo " -> Key already exists."
else
    ssh-keygen -t ed25519
fi
echo

###########################
##  Other Configuration  ##
###########################
echo "Other configuration:"
echo " -> XCompose"
ln -s ${HOME}/Dotfiles/XCompose ${HOME}/.XCompose 2>/dev/null


echo
echo "Done."
echo
