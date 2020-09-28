#!/bin/sh 

_isCommand () { command -v "$@" > /dev/null 2>&1; }


echo "
###############
### Find OS ###
###############

"

_install() {
    curl -sSL https://raw.githubusercontent.com/BLRocha/vimrc/master/.vimrc > ~/.vimrc
    mkdir -p ~/.vim/bundle/ > /dev/null 2>&1
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall
}

_install_required() {
    for inst in curl vim git; do
        if _isCommand $inst; then
            echo $inst " Ok..."
        else
            echo "Instalando $inst..." 
            command "sudo" "$1" "install" "$inst" "-y"
        fi
    done
    _install
}

if _isCommand apt; then
    _install_required 'apt'
else
   _install_required 'dnf'
fi

clear
echo "
      #########################################################
      ###########                                   ###########
      ###########            Instalação             ###########
      ###########             ...Ok...              ###########
      #########################################################
"