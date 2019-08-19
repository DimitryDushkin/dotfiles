# Path to Oh My Fish install.
set -gx OMF_PATH "$HOME/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

# Support UTF-8 in tmux
alias tmux='tmux -u'
