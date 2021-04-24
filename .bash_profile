# Call bashrc so that interactive login shells have the same config as non interactive login shells
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
set -o vi

export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
source "$HOME/.cargo/env"
