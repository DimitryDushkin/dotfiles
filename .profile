if [[ -z `git config --global user.name` ]]; then
    echo -n "Please, enter user name for git config: "
    read GIT_AUTHOR_NAME
    git config --global user.name "$GIT_AUTHOR_NAME"
fi

if [[ -z `git config --global user.email` ]]; then
    echo -n "Please, enter email for git config: "
    read GIT_AUTHOR_EMAIL
    git config --global user.email "$GIT_AUTHOR_EMAIL"
fi

# source ~/dotfiles/git-completion.bash
# export PATH=bin:$PATH

# if [ -f /usr/local/etc/bash_completion ]; then
#     . /usr/local/etc/bash_completion
# fi

# # Save ssh agent socket for using in tmux sessions
# if [[ $SSH_AUTH_SOCK && $SSH_AUTH_SOCK != $HOME/.ssh/ssh_auth_sock ]]
# then
#     ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
# fi

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# export NVM_DIR="/Users/dndushkin/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
