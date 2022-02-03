# I am barely using zsh so, for now, this is mainly a file for automatic installers to drop their config so that, when I drop into ZSH, my tools still work.
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/amartins/.sdkman"
[[ -s "/Users/amartins/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/amartins/.sdkman/bin/sdkman-init.sh"

# Homebrew autocompletions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

# added by Snowflake SnowCD installer
export PATH=/opt/snowflake/snowcd:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
