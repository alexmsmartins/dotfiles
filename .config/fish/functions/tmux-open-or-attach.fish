function tmux-open-or-attach
  # TODO change this whole function to:
  #  - be named `tmux`
  #  - handle an extra parameter called open-or-attach with the current behaviour
  #  - call `tmux` proper otherwise
  #  - actually use autocomplete including the above parameter
  #  - we will already have autocomplete for freee by using the `tmux` name, if I am not mistaken, but that does need checking
  if count $argv
    and tmux info &> /dev/null
    tmux attach
  else
    tmux $argv
  end
end
