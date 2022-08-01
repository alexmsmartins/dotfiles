# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/amartins/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/amartins/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/amartins/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/amartins/.fzf/shell/key-bindings.bash"
