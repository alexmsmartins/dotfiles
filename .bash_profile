# Call bashrc so that interactive login shells have the same config as non interactive login shells
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

test -e "$HOME/.iterm2_shell_integration.bash" && source "$HOME/.iterm2_shell_integration.bash"


. "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/alexmsmartins/.sdkman"
[[ -s "/Users/alexmsmartins/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/alexmsmartins/.sdkman/bin/sdkman-init.sh"
