set -o vi

export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion


if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

alias config='/usr/bin/git --git-dir=/Users/amartins/.cfg/ --work-tree=/Users/amartins'
source "$HOME/.cargo/env"
