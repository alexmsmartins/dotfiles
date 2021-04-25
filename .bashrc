set -o vi

export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
source "$HOME/.cargo/env"

export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# unclutter your .profile http://direnv.net
eval "$(direnv hook bash)"

# The minimal, blazing-fast, and infinitely customizable prompt for any shell!
# https://github.com/starship/starship
eval "$(starship init bash)"

if [ "$(uname)" == "Darwin" ]; then
  echo "Setup brew in $PATH under Mac OS X platform"
  export PATH="/usr/local/sbin:$PATH"
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "Setup brew under GNU/Linux platform"
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

