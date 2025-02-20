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

# TODO: kpcli lives in AUR
install_packages_pacman ()
{
    echo "Package Installation:"
    PACKAGES="
        base-devel
        curl
        fish
        fuzzel
        firefox
        git
        gvim
        htop
        keepassxc
        man-pages
        neovim
        telegram-desktop
        terminus-font
        wl-clipboard
        zsh"

    for PACKAGE in ${PACKAGES}
    do
        if pacman -Qi ${PACKAGE} > /dev/null 2> /dev/null
        then
            echo " -> ${PACKAGE} is already installed."
        else
            echo " -> Installing ${PACKAGE}"
            sudo pacman -S ${PACKAGE}
        fi
    done
    echo
}

install_packages_apt ()
{
    echo "Package Installation:"
    PACKAGES="
        build-essential
        curl
        git
        fish
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
}

if uname -a | grep -i arch > /dev/null
then
    install_packages_pacman
fi

if uname -a | grep -i ubuntu > /dev/null
then
    install_packages_apt
fi


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

if [ -e "${HOME}/.vim/pack/plugins/start/nerdtree/" ]
then
    echo " -> NERDTree is already installed."
else
    echo "Install NERDTree with:"
    echo "  'git clone https://github.com/preservim/nerdtree.git ~/.vim/pack/plugins/start/nerdtree'"
fi

if [ -e "$HOME/.vim/pack/plugins/start/vimwiki/" ]
then
    echo " -> VimWiki is already installed."
else
    echo "Install VimWiki with:"
    echo "  'git clone https://github.com/vimwiki/vimwiki.git ~/.vim/pack/plugins/start/vimwiki'"
fi
echo

############################
##  Neovim Configuration  ##
############################
echo "Neovim Setup:"
mkdir -p ${HOME}/.config/nvim
ln -s ${HOME}/Dotfiles/nvim/init.lua ${HOME}/.config/nvim/init.lua 2>/dev/null


#########################
##  Fish Configuration  ##
#########################
echo "Fish Setup:"
mkdir -p ${HOME}/.config/fish
ln -s ${HOME}/Dotfiles/fish/config.fish ${HOME}/.config/fish/config.fish 2>/dev/null
ln -s ${HOME}/Dotfiles/fish/fish_variables ${HOME}/.config/fish/fish_variables 2>/dev/null


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

if [ "$(whoami)" = "joppy" ]
then
    echo " -> Git"
    git config --global user.name "Joppy Furr"
    git config --global user.email "joppyfurr@gmail.com"
    git config --global init.defaultBranch main
fi

echo
echo "Done."
echo

echo "Remember to edit /etc/security/faillock.conf"
echo
