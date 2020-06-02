#!/bin/sh

FILE=`readlink -f $0`
DIR=`dirname $FILE`

FILES=".gitconfig .tmux.conf .vimrc .bash_aliases"
for i in $FILES; do
	ln -s $DIR/$i ~/$i
done

BUNDLE=~/.vim/bundle
mkdir -p $BUNDLE
cd $BUNDLE
git clone https://github.com/VundleVim/Vundle.vim.git
vim +PluginInstall +qall

echo "source $DIR/bash_prompt.sh" >> ~/.bashrc
echo "source $DIR/.profile" >> ~/.profile

SUBL=".config/sublime-text-3"
SUBL_DIR=~/$SUBL/Packages/User
mkdir -p $SUBL_DIR
for i in $DIR/$SUBL/* ; do
	ln -s "$i" $SUBL_DIR
done

ATOM=".atom"
ATOM_DIR=~/$ATOM
mkdir -p $ATOM_DIR
for i in $DIR/$ATOM/* ; do
	ln -s "$i" $ATOM_DIR
done

