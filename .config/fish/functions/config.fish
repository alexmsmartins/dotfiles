# Defined in /var/folders/ny/cxvbndcx03sb0yrbx6hd35j8qslqdf/T//fish.YxLHnD/config.fish @ line 2
function config
  # https://www.atlassian.com/git/tutorials/dotfiles
  git --git-dir={$HOME}/.cfg/ --work-tree={$HOME} $argv
end
