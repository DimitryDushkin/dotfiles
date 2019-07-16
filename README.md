### Установка

```bash
git clone git://github.com/DimitryDushkin/dotfiles ~/dotfiles && ~/dotfiles/install.sh
```


### Доп. пакеты
```bash
sudo apt-add-repository ppa:fish-shell/release-3
sudo add-apt-repository ppa:git-core/ppa
sudo apt-get update
sudo apt-get install fish git tmux
```

tmux из исходников
```bash
wget https://github.com/tmux/tmux/releases/download/2.9a/tmux-2.9a.tar.gz
tar -xvzf tmux-2.9a.tar.gz
cd tmux-2.9a
sudo apt-get install automake build-essential pkg-config libevent-dev libncurses5-dev
./configure && make
sudo make install
sudo ln -s ./tmux /usr/bin/tmux
```
