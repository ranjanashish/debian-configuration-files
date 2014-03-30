#!/usr/bin/env bash

declare -r GH_DEB_CONFIGS=https://github.com/ranjanashish/debian-configuration-files.git
declare -r GH_POWERLINE_FONTS=https://github.com/Lokaltog/powerline-fonts.git
declare -r GH_OH_MY_ZSH=https://github.com/robbyrussell/oh-my-zsh.git
declare -r GH_VUNDLE=https://github.com/gmarik/vundle.git

# install basic packages from debian repositories
sudo apt-get install astyle autojump clipit curl gcc g++ git python-pip tidy tilda vim zsh

# download config files and create symlinks
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

# install powerline fonts
printf '\nInstalling powerline fonts... '
mkdir -p ~/.fonts
git clone ${GH_POWERLINE_FONTS} ~/.fonts >/dev/null 2>&1 && {
    fc-cache -f ~/.fonts && printf 'success.\n' || printf 'font cache update FAILED!\n'
} || printf 'download FAILED!\n'

# install oh-my-zsh
printf '\nInstalling oh-my-zsh... '
git clone ${GH_OH_MY_ZSH} ~/.oh-my-zsh >/dev/null 2>&1 && printf 'Success!\n' || printf 'Failed!\n'

# install vundle and vim plugins
printf '\nInstalling vundle... '
git clone ${GH_VUNDLE} ~/.vim/bundle/vundle >/dev/null 2>&1 && {
    printf 'Success!\n'
    printf 'Installing vim plugins\n'
    sed -i 's/colorscheme molokai/#colorscheme molokai/' ~/.vimrc
    vim +PluginInstall +qall
    sed -i 's/#colorscheme molokai/colorscheme molokai/' ~/.vimrc
    printf 'Done!\n'
} || printf 'Failed!\n'

# change default shell to zsh
printf '\nChanging default shell to zsh\n'
chsh -s $(which zsh)
printf 'Done!\n'

# install python packages from pip
sudo pip install awscli

# add keys
sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 5CB26B26
curl -s http://mozilla.debian.net/archive.asc | sudo apt-key add -

