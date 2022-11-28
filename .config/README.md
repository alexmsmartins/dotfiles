From [Stackoverflow - Understanding home configuration file locations: ~/, ~/.config/ and ~/.local/share/](https://unix.stackexchange.com/questions/312988/understanding-home-configuration-file-locations-config-and-local-sha)

There's a long history here when it comes to the general case of "dot files",
but the `$HOME/.config` and `$HOME/.local` directories that you specifically
mention have an origin in the _XDG Base Directory Specification_.

* `$HOME/.config` is where per-user configuration files go if there is no
  `$XDG_CONFIG_HOME`.
* `$HOME/.cache` is where per-user cache files go if there is no
  `$XDG_CACHE_HOME`.
* `$HOME/.local/share` is where per-user data files go if there is no
  `$XDG_DATA_HOME`.
