# I am barely using zsh so, for now, this is mainly a file for automatic installers to drop their config so that, when I drop into ZSH, my tools still work.
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Homebrew autocompletions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# TODO @alex run uname and uname -p only once
# TODO @alex refactor shared code between .zshrc and ,bashrc
if [[ "$(uname)" = "Darwin" ]]; then
  if [[ "$(uname -p)" = "i386" ]]; then
    export PATH="/usr/local/sbin:$PATH"
  elif [[ "$(uname -p)" = "arm" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Homebrew config for OS $(uname) and architecture $(uname -p) is not configured yet! Pleas fix this"
  fi
  # Setup brew under Mac OS X platform
elif [[ "$(expr substr $(uname -s) 1 5)" = "Linux" ]]; then
  echo "Linux"
  # Setup brew under GNU/Linux platform
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  . /home/linuxbrew/.linuxbrew/etc/profile.d/z.sh
fi

# Brew will stop updating on every 'brew install'
export HOMEBREW_NO_AUTO_UPDATE=1


# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

# added by Snowflake SnowCD installer
export PATH=/opt/snowflake/snowcd:$PATH


# FZF
eval "$(fzf --zsh)"

# Fuck configuration
eval $(thefuck --alias)

# Dotfiles `config` comand
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Added by Toolbox App
export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

# added by travis gem
[ ! -s $HOME/.travis/travis.sh ] || source $HOME/.travis/travis.sh

# Created by `pipx` on 2024-04-25 23:20:58
export PATH="$PATH:/Users/alexmsmartins/.local/bin"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

