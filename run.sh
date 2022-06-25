#!/usr/bin/env bash

mv vj ~/
mv make ~/
cp vimrc ~/.vimrc
cp bashrc ~/.bashrc
cp bash_profile~/.bash_profile

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
