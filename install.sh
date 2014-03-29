#!/usr/bin/env bash

mkdir -p ~/git

# clone git repo
################
printf 'Cloning git repo\n'
git clone https://github.com/ranjanashish/debian-configuration-files ~/git/debian-configuration-files
printf 'Done!\n'

# install oh-my-zsh
###################
printf '\nInstalling oh-my-zsh... '
git clone -q https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
exit_status_install_oh_my_zsh=$?
if [[ ${exit_status_install_oh_my_zsh} -eq 0 ]]; then
    printf 'Success!\n'
else
    printf 'Failed!\n'
fi

# install vundle
################
printf '\nInstalling vundle... '
git clone -q https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
exit_status_install_vundle=$?
if [[ ${exit_status_install_vundle} -eq 0 ]]; then
    printf 'Success!\n'
else
    printf 'Failed!\n'
fi

# create symlinks
#################
printf '\nCreating symlinks... '
ln -s ~/git/debian-configuration-files/home/ashish/.gitconfig ~/.gitconfig
ln -s ~/git/debian-configuration-files/home/ashish/.vimrc ~/.vimrc
ln -s ~/git/debian-configuration-files/home/ashish/.Xdefaults ~/.Xdefaults
ln -s ~/git/debian-configuration-files/home/ashish/.xinitrc ~/.xinitrc
ln -s ~/git/debian-configuration-files/home/ashish/.zshrc ~/.zshrc
printf 'Done!\n'

# install vim plugins
#####################
if [[ ${exit_status_install_vundle} -eq 0 ]]; then
    printf '\nInstalling vim plugins\n'
    vim +PluginInstall +qall
    printf 'Done!\n'
fi

# change default shell to zsh
#############################
printf '\nChanging default shell to zsh\n'
chsh -s /bin/zsh
printf 'Done!\n'

