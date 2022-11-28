# Call bashrc so that interactive login shells have the same config as non interactive login shells
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


. "$HOME/.cargo/env"
