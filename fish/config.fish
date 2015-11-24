rvm default

bass source ~/.nvm/nvm.sh

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Prepend the relative ./bin, so I can get binstubs and the like in the PATH
# automatically. The node modules binaries are also handy to have around. I
# don't like installing global node packages.
# sbin is for brew
set -gx PATH $PATH "./bin" "./node_modules/.bin" "/usr/local/sbin"

set -gx NODE_PATH $PWD/node_modules \
                  /usr/local/lib/node_modules \
                  $NODE_PATH

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


set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate green


function fish_prompt --description 'Write out the prompt'

  set -l last_status $status

  if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
  end

  # PWD
  set_color $fish_color_cwd
  echo -n (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)

  if not test $last_status -eq 0
  set_color $fish_color_error
  end

  echo -n '$ '

end

function nvm --description 'NVM wrapper'
  bass source ~/.nvm/nvm.sh ';' nvm $argv
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
