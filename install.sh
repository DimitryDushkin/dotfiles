#!/usr/bin/env bash

cd "$(dirname "$0")"
git pull
for f in `find . -name '\.*' -exec basename {} \; | grep -v 'git\|\.$'`
do
    ln -fs $PWD/$f ~
done

#
echo Настройка git ...
GIT_AUTHOR_NAME=`git config --global user.name`
GIT_AUTHOR_EMAIL=`git config --global user.email`
cp .gitconfig ~/.gitconfig
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

#
#echo Перезагрузка bash-профиля ...
#source ~/.profile

rm ~/.config/fish/config.fish
mkdir ~/.config
mkdir ~/.config/fish
ln -s ~/dotfiles/fish/config.fish ~/.config/fish/config.fish


echo Done
