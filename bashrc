# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=erasedups

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#xterm-color)
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\[\033[00m\]\W\$ '
#    ;;
#*)
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
#    ;;
#esac

# Comment in the above and uncomment this below for a color prompt
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#alex# haskell cabal path
if [ -d ~/.cabal/bin ] ; then
     export PATH=~/.cabal/bin:$PATH
fi


#alex# shoud change this to default jvm -> later
#export SCALA_HOME="/home/alex/scala"
#export JAVA_HOME="/usr/lib/jvm/java-6-sun"
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
export JDK_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
export PATH=$JAVA_HOME/bin:$PATH


if [ -z $CLASSPATH ]; then
	CLASSPATH=.
else
	CLASSPATH=.:$CLASSPATH
fi


CLASSPATH=/home/alex/classpath:$CLASSPATH



CLASSPATH=/usr/local/lib/libsbmlj.jar:$CLASSPATH

export CLASSPATH

#alex# Jena's SDB
SDBROOT=/home/alex/SDB-1.3.0
export SDBROOT
export SDB_JDBC=/home/alex/classpath/postgresql-8.3-603.jdbc4.jar

#alex# copasi
export COPASIDIR=/home/alex/copasi

#alex# SBW
export SBW_HOME=/home/alex/SBW
export PATH=$SBW_HOME/bin:$PATH
if [ -z LD_LIBRARY_PATH ]; then
  LD_LIBRARY_PATH=$SBW_HOME/lib:$LD_LIBRARY_PATH
else
  LD_LIBRARY_PATH=$SBW_HOME/lib
fi
LD_LIBRARY_PATH="/usr/local:/usr/local/lib"
export LD_LIBRARY_PATH


## /home/alex/CellDesigner4.1
export PATH=$HOME/CellDesigner4.1:$PATH

#alex# Configuration for Intellij IDEA. This might just be general enough to be usefull with other IDEs or programs.
# That is the reason for choosing to configure it here and not inside IDEA.
if [ -z "$M2_HOME" ] ; then
  export M2_HOME="/usr/share/maven"
fi


#alex# localization
export LANG="pt_PT.UTF-8"
export LC_ALL="pt_PT.UTF-8"
export LC_CTYPE="pt_PT.UTF-8"
#export LANGUAGE="pt_PT.UTF-8"

export HISTFILESIZE=10000000
export HISTSIZE=10000000

export COPASIDIR="/home/alex/copasi"

#alex# mvn 
#export MAVEN_OPTS="$MAVEN_OPTS -noverify -javaagent:~/ZeroTurnaround/JRebel/jrebel.jar" 

#Taken from http://madebynathan.com/2011/10/04/a-nicer-way-to-use-xclip/
# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
    # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
      # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
    fi
  fi
}
# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
function cbf() { cat "$1" | cb; }  
# Copy current working directory
alias cbwd="pwd | cb"  
# Copy most recent command in bash history
alias cbhs="cat $HISTFILE | tail -n 1 | cb"  

# path added to sbt 0.12
export PATH=/home/alex/sbt-0.12/bin:$PATH
