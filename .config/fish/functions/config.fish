# Defined in /var/folders/ny/cxvbndcx03sb0yrbx6hd35j8qslqdf/T//fish.rxGvUk/config.fish @ line 2
function config
  git --git-dir={$HOME}/.cfg/ --work-tree={$HOME} $argv
end
