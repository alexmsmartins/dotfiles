function tmux-open-or-attach
  if count $argv
    and tmux info &> /dev/null
    tmux attach
  else
    tmux $argv
  end
end
