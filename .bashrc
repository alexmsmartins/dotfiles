# shellcheck shell=sh
set -o vi
set termguicolors

# When summoning bash from within another SHELL we need to set this variable so that commands that summon subshells work properly
export SHELL=/usr/local/bin/bash

# 

# infinite command line history size - lets see how big this gets
export HISTFILESIZE=
export HISTSIZE=

# Command History is stored immediately after running a new command
declare PROMPT_COMMAND="history -a;history -r"

# add bash completions
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

# git repo for dot files
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Rust's Cargo setup
. "$HOME/.cargo/env"

# Manpages setup
export MANPATH="/usr/local/man:$MANPATH"

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vi'
else
  export EDITOR='nvim'
fi

# Opening Typora from the shell on a Mac OS X
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias typora="open -a typora"
  # FIXME: handle typora not being installed
fi

# Add python libraries and executables to the PATH
PATH="$HOME/Library/Python/3.9/bin:$PATH"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# FZF
[ -f ~/.fzf.bash ] && . ~/.fzf.bash

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


cdnvm() {
    cd "$@";
    nvm_path=$(nvm_find_up .nvmrc | tr -d '\n')

    # If there are no .nvmrc file, use the default nvm version
    if [[ ! $nvm_path = *[^[:space:]]* ]]; then

        declare default_version;
        default_version=$(nvm version default);

        # If there is no default version, set it to `node`
        # This will use the latest version on your machine
        if [[ $default_version == "N/A" ]]; then
            nvm alias default node;
            default_version=$(nvm version default);
        fi

        # If the current version is not the default version, set it to use the default version
        if [[ $(nvm current) != "$default_version" ]]; then
            nvm use default;
        fi

        elif [[ -s $nvm_path/.nvmrc && -r $nvm_path/.nvmrc ]]; then
        declare nvm_version
        nvm_version=$(<"$nvm_path"/.nvmrc)

        declare locally_resolved_nvm_version
        # `nvm ls` will check all locally-available versions
        # If there are multiple matching versions, take the latest one
        # Remove the `->` and `*` characters and spaces
        # `locally_resolved_nvm_version` will be `N/A` if no local versions are found
        locally_resolved_nvm_version=$(nvm ls --no-colors "$nvm_version" | tail -1 | tr -d '\->*' | tr -d '[:space:]')

        # If it is not already installed, install it
        # `nvm install` will implicitly use the newly-installed version
        if [[ "$locally_resolved_nvm_version" == "N/A" ]]; then
            nvm install "$nvm_version";
        elif [[ $(nvm current) != "$locally_resolved_nvm_version" ]]; then
            nvm use "$nvm_version";
        fi
    fi
}
alias cd='cdnvm'
cd $PWD

alias draw.io='/Applications/draw.io.app/Contents/MacOS/draw.io'

# vim keys for info command
alias info='info --vi-keys'

# unclutter your .profile http://direnv.net
eval "$(direnv hook bash)"

# The minimal, blazing-fast, and infinitely customizable prompt for any shell!
# https://github.com/starship/starship
eval "$(starship init bash)"

# TODO @alex run uname and uname -p only once
if [[ "$(uname)" = "Darwin" ]]; then
  if [[ "$(uname -p)" = "i386" ]]; then
    export PATH="/usr/local/sbin:$PATH"
  elif [[ "$(uname -p)" = "arm" ]]; then
    eval "$("$HOMEBREW_PREFIX"/bin/brew shellenv)"
  else
    echo "Homebrew config for OS $(uname) and architecture $(uname -p) is not configured yet! Pleas fix this"
  fi
  # Setup brew under Mac OS X platform
  . /opt/homebrew/etc/profile.d/z.sh
elif [[ "$(expr substr $(uname -s) 1 5)" = "Linux" ]]; then
  echo "Linux"
  # Setup brew under GNU/Linux platform
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Brew will stop updating on every 'brew install'
export HOMEBREW_NO_AUTO_UPDATE=1

# Configure 'z' installed by brew
if [[ -z $(brew --repository)/etc/profile.d/z.sh ]] ; then
  . $(brew --repository)/etc/profile.d/z.sh
fi

# Add Nix configuartion
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Taskwarrior server
export TASKDDATA=/var/taskd


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# added by Snowflake SnowSQL installer
export PATH=/Users/amartins/bin:$PATH
