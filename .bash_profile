# Call bashrc so that interactive login shells have the same config as non interactive login shells
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
if [ -e /Users/amartins/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/amartins/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
