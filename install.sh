#!/usr/bin/env bash

declare -r GH_POWERLINE_FONTS=https://github.com/Lokaltog/powerline-fonts.git
declare -r GH_OH_MY_ZSH=https://github.com/robbyrussell/oh-my-zsh.git

declare -r GH_DEB_CONFIGS=https://github.com/ranjanashish/debian-configuration-files.git

declare -r -a CLI_PACKAGES=(autojump awscli bash-completion curl httpie mtr ncdu pandoc silversearcher-ag vim zsh)
declare -r -a GUI_PACKAGES=(clipit tilda vim-gnome)

declare -r -a PROGRAMMING_PACKAGES=(
    git git-extras git-flow                             # git
    clang clang++ gcc g++ nodejs openjdk-8-jdk python3  # compilers and interpreters
    gradle make maven npm python3-pip                   # build tools and package managers
    flake8 mypy pylint3                                 # linters
    astyle tidy                                         # formatters
)
declare -r -a PYTHON3_PACKAGES=(python3-{alembic,boto3,celery,falcon,flask,gevent,libcloud,numpy,psycopg2,pytest,requests,selenium,sqlalchemy,tornado})

# install packages from debian repositories
__install_packages() {
    sudo apt-get update && sudo apt-get install -y $*
}

# download config files and create symlinks
__setup_configs() {
    if ! command -v git >/dev/null 2>&1; then
        return
    fi

    printf 'Downloading debian config files... \n'
    mkdir -p ~/git
    git clone ${GH_DEB_CONFIGS} ~/git/debian-configuration-files >/dev/null 2>&1 && {
        printf 'Success!\n'
        printf 'Creating symlinks to config files... '
        mkdir -p ~/.config/awesome
        ln -s ~/git/debian-configuration-files/home/ashish/.config/awesome/rc.lua ~/.config/awesome/rc.lua
        ln -s ~/git/debian-configuration-files/home/ashish/.gitconfig ~/.gitconfig
        ln -s ~/git/debian-configuration-files/home/ashish/.vimrc ~/.vimrc
        ln -s ~/git/debian-configuration-files/home/ashish/.Xdefaults ~/.Xdefaults
        ln -s ~/git/debian-configuration-files/home/ashish/.xinitrc ~/.xinitrc
        ln -s ~/git/debian-configuration-files/home/ashish/.zshrc ~/.zshrc
        ln -s ~/.xinitrc ~/.xsession 
        printf 'Done!\n'
    } || printf 'Failed!\n'
}

__install_powerline_fonts() {
    printf '\nInstalling powerline fonts... '
    mkdir -p ~/.fonts
    git clone ${GH_POWERLINE_FONTS} ~/.fonts >/dev/null 2>&1 && {
        fc-cache -f ~/.fonts && printf 'success.\n' || printf 'font cache update FAILED!\n'
    } || printf 'download FAILED!\n'
}

__install_oh_my_zsh() {
    printf '\nInstalling oh-my-zsh... '
    git clone ${GH_OH_MY_ZSH} ~/.oh-my-zsh >/dev/null 2>&1 && printf 'Success!\n' || printf 'Failed!\n'
}

__install_vim_plug() {
    printf '\nInstalling vim-plug... '
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >/dev/null 2>&1 && {
        printf 'Success!\n'
        printf 'Installing vim plugins\n'
        sed -i 's/colorscheme molokai/#colorscheme molokai/' ~/.vimrc
        vim +PlugInstall +qall
        sed -i 's/#colorscheme molokai/colorscheme molokai/' ~/.vimrc
        printf 'Done!\n'
    } || printf 'Failed!\n'
}

__install_packages ${CLI_PACKAGES[@]} ${GUI_PACKAGES[@]} ${PROGRAMMING_PACKAGES[@]} ${PYTHON3_PACKAGES[@]}
__setup_configs
__install_powerline_fonts
__install_oh_my_zsh
__install_vim_plug

# change default shell to zsh
printf '\nChanging default shell to zsh\n'
chsh -s $(which zsh)
printf 'Done!\n'

# add keys
sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 5CB26B26
curl -s http://mozilla.debian.net/archive.asc | sudo apt-key add -
