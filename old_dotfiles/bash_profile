# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/login.defs
#umask 022

# include .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ] ; then
    PATH=~/bin:"${PATH}"
fi

if [ -d /sbin ] ; then
    PATH=/sbin:"${PATH}"
fi

if [ -d /usr/sbin ] ; then
    PATH=/usr/sbin:"${PATH}"
fi

#alex# PATH para aplicação CloudPT
if [ -d ~/CloudPT ] ; then
  PATH=~/CloudPT:$PATH
fi

bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
if [ "$PS1" ] && [ $bmajor -eq 2 ] && [ $bminor '>' 04 ] ; then
  if [ -f ~/bin/bash_completion   ] ; then
      BASH_COMPLETION=~/bin/bash_completion
      BASH_COMPLETION_DIR=~/.bash_completion.d
      export BASH_COMPLETION BASH_COMPLETION_DIR
      . ~/bin/bash_completion
  fi
fi  
unset bash bmajor bminor


#
#  Lines added by 'hex_configure.bin' for Hex 4e
#

export HEX_ROOT=/home/alex/hex
export PATH=${PATH}:${HEX_ROOT}/bin

export HEX_CACHE=/home/alex/hex_cache

#alex# git-achivements :D
export PATH=${HOME}/git-achievements:${PATH}
alias git="git-achievements"

#alex# less with colors

alias less="less -R"

#alex# vi mode
set -o vi

[ -s $HOME/.nvm/nvm.sh ] && source $HOME/.nvm/nvm.sh # This loads NVM
