#!/usr/bin/env bash

cd "$(dirname "$0")"
for f in `find . -name '\.*' -exec basename {} \; | grep -v 'git\|\.$'`
do
    ln -fs $PWD/$f ~
done

echo "Копирую настройки ssh"
mkdir ~/.ssh
cp .sshconfig ~/.ssh/config

echo "Настройка git ..."
GIT_AUTHOR_NAME=`git config --global user.name`
GIT_AUTHOR_EMAIL=`git config --global user.email`
cp .gitconfig ~/.gitconfig
git config --global user.name "$GIT_AUTHOR_NAME"
git config --global user.email "$GIT_AUTHOR_EMAIL"

# install oh my fish
curl -L https://github.com/oh-my-fish/oh-my-fish/raw/master/bin/install | fish
omf install nvm

# Install oh my fish config
rm -rf ~/.config
mkdir ~/.config
ln -s ~/dotfiles/.config/omf ~/.config/omf
ln -s ~/dotfiles/.config/fish ~/.config/fish

echo Done
