# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Load Oh My Fish configuration.
source $OMF_PATH/init.fish

# Prepend the relative ./bin, so I can get binstubs and the like in the PATH
# automatically. The node modules binaries are also handy to have around. I
# don't like installing global node packages.
# sbin is for brew
if test -d ~/bin
  set -gx PATH $PATH "$HOME/bin"
end

set -gx PATH $PATH "./node_modules/.bin"

if test -e /usr/libexec/java_home
  set -gx JAVA_HOME (/usr/libexec/java_home)
end

# Global node_modules is bad idea! When needed use "npm link browser-sync" for example
#set -gx NODE_PATH $NODE_PATH "./node_modules" (npm prefix -g)/lib/node_modules
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

function fish_prompt --description 'Write out the prompt'
  set -l last_status $status
  set -l normal (set_color normal)

  # Hack; fish_config only copies the fish_prompt function (see #736)
  if not set -q -g __fish_classic_git_functions_defined
    set -g __fish_classic_git_functions_defined

    function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"
      if status --is-interactive
        commandline -f repaint ^/dev/null
      end
    end

    function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes"
      if status --is-interactive
        commandline -f repaint ^/dev/null
      end
    end

    function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
      if status --is-interactive
        commandline -f repaint ^/dev/null
      end
    end

    function __fish_repaint_bind_mode --on-variable fish_key_bindings --description "Event handler; repaint when fish_key_bindings changes"
      if status --is-interactive
        commandline -f repaint ^/dev/null
      end
    end

    # initialize our new variables
    if not set -q __fish_classic_git_prompt_initialized
      set -qU fish_color_user
      or set -U fish_color_user -o green
      set -qU fish_color_host
      or set -U fish_color_host -o cyan
      set -qU fish_color_status
      or set -U fish_color_status red
      set -U __fish_classic_git_prompt_initialized
    end
  end

  set -l color_cwd
  set -l prefix
  switch $USER
    case root toor
      if set -q fish_color_cwd_root
        set color_cwd $fish_color_cwd_root
      else
        set color_cwd $fish_color_cwd
      end
      set suffix '#'
    case '*'
      set color_cwd $fish_color_cwd
      set suffix '>'
  end

  set -l prompt_status
  if test $last_status -ne 0
    set prompt_status ' ' (set_color $fish_color_status) "[$last_status]" "$normal"
  end

  echo -n -s (set_color $color_cwd) (prompt_pwd) $normal (__fish_vcs_prompt) $normal $prompt_status "> "

  # echo -n -s (set_color $fish_color_user) "$USER" $normal @ (set_color $fish_color_host) (prompt_hostname) $normal ' ' (set_color $color_cwd) (prompt_pwd) $normal (__fish_vcs_prompt) $normal $prompt_status "> "
end

# Support UTF-8 in tmux
alias tmux='tmux -u'
export LC_ALL=en_IN.UTF-8
export LANG=en_IN.UTF-8
