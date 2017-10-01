#!/bin/sh

DIR=`dirname $0`

FILES=".gitconfig .hgrc .rtorrent.rc .tmux.conf .vimrc .atom"
for i in $FILES; do
	ln -s $DIR/$i ~/$i 
done

BUNDLE=~/.vim/bundle
mkdir -p $BUNDLE
cd $BUNDLE
git clone https://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall
