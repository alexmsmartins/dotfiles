#!/usr/bin/env ruby
cask_deps=$(brew list --cask | \
xargs -I % /bin/bash -c "brew deps --installed --cask %;")

toremove=$(brew autoremove -n | grep -v '==>')

for dep in $cask_deps; do
    toremove=$(echo $toremove | \
        sed -e "s/[ ]$dep[ ]//g" -e "s/[ ]$dep$//g" \
            -e "s/^$dep[ ]//g" -e "s/^$dep$//g" \
            -e "s/^[ ]//g" -e "s/[ ]$//g")
    if [ ! "$toremove" ]; then
        break
    fi
done

n_toremove=$(echo $toremove | wc -w | xargs)
if [ $n_toremove -gt 0 ]; then
    echo -e "==> Would uninstall $n_toremove unneeded formulae:"
    echo $toremove | xargs -n1
    echo $toremove | xargs brew uninstall
else
    echo -e "No unneeded formulae."
fi
unset cask_deps
unset n_toremove
unset toremove
