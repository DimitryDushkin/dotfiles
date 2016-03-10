
# Prepend the relative ./bin, so I can get binstubs and the like in the PATH
# automatically. The node modules binaries are also handy to have around. I
# don't like installing global node packages.
# sbin is for brew
#set -gx PATH $PATH "~/bin" "./bin" "./node_modules/.bin" "/usr/local/sbin"
#set npm_root (npm root -g)
#set -gx NODE_PATH $npm_root \
#                  $PWD/node_modules \
#                  /usr/local/lib/node_modules \
#                  $NODE_PATH

alias gst="git status"
alias ga='git add'
alias gp='git pull; and git push'
alias gull='git pull'
alias gush='git push'
alias gb='git branch'
alias gco='git checkout'
alias gd='git diff'
alias gdi='git difftool --extcmd icdiff'
alias gfa='git fetch --all'
alias grdi='git rebase -i origin/dev --autosquash'
alias grd='git rebase origin/dev --autosquash'
alias gfpcb='git push origin +(git rev-parse --abbrev-ref HEAD)'
alias gamend='git add .; and git commit --amend --no-edit'

function jailmount --description 'Mount remote folder via sshfs'
    set_color blue

    set JAIL $argv
    echo "===> Jail mounting"
    mkdir -p /mount/$JAIL

    echo "===> But first try to unmount it for sure"
    jailunmount $JAIL

    echo "===> Now mount it:" $JAIL
    sshfs $USER@$JAIL:/ /mount/$JAIL -oauto_cache,reconnect,volname=$1
    set_color normal
end

# размаунтить джейл
function jailunmount --description 'Unmount remote folder via sshfs'
    set JAIL $argv
    umount /mount/$JAIL >/dev/null
end

function unlink_libs
  set libs_link (readlink libs)
  unlink libs
  mv $libs_link libs
end

function unlink_node_modules
  set node_modules_link (readlink node_modules)
  unlink node_modules
  mv $node_modules_link node_modules
end
