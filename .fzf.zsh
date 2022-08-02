# Install fzf
if [[ ! -d $HOME/.fzf/.git ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
fi
# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf/shell/key-bindings.zsh"
