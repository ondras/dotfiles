#!/bin/sh

FILE=`readlink -f $0`
DIR=`dirname $FILE`

FILES=".gitconfig .hgrc .rtorrent.rc .tmux.conf .vimrc .atom .bash_aliases"
for i in $FILES; do
	ln -s $DIR/$i ~/$i 
done

BUNDLE=~/.vim/bundle
mkdir -p $BUNDLE
cd $BUNDLE
git clone https://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

# echo "source $DIR/bash_history.sh" >> ~/.bashrc

SUBL="sublime-text-3"
SUBL_DIR=~/.config/$SUBL/Packages/User
mkdir -p $SUBL_DIR
for i in $DIR/$SUBL/* ; do
	ln -s "$i" $SUBL_DIR
done
