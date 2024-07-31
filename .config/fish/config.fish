fish_vi_key_bindings

set -gx EDITOR nvim

# add personal scripts to path
contains "$HOME/bin"  $PATH
or set fish_user_paths "$HOME/bin" $PATH
contains "$HOME/.local/bin"  $PATH
or set fish_user_paths "$HOME/.local/bin" $PATH

# add GNU coreutils to the path - this may change behaviour in the Mac
# contains "/usr/local/opt/coreutils/libexec/gnubin"  $PATH
# or set fish_user_paths "/usr/local/opt/coreutils/libexec/gnubin" $PATH

# Interactive shell abbreviations
if status --is-interactive
    abbr --add --global -- blue /Users/amartins/development/amartins-mdsol-notes/Blue_Wave
end

# Config theFuck
thefuck --alias | source
eval (thefuck --alias | tr '
' ';')

# Homebrew
# TODO @alex distinguish architectures specially because of rosseta
# i386 mac
#contains "/usr/local/sbin" $PATH
#or set fish_user_paths "/usr/local/sbin" $PATH
# arm mac
contains "/opt/homebrew/bin" $PATH
or fish_add_path /opt/homebrew/bin
contains "/opt/homebrew/sbin" $PATH
or fish_add_path /opt/homebrew/sbin



# Brew will stop updating on every 'brew install'
set -x HOMEBREW_NO_AUTO_UPDATE 1

# Ruby-build from Homebrew
# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed and these are never upgraded.
# To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following to your ~/.config/fish/config.fish:
set -x RUBY_CONFIGURE_OPTS --with-openssl-dir=(brew --prefix openssl@1.1)
# Note: this may interfere with building old versions of Ruby (e.g <2.4) that use OpenSSL <1.1.

# Cargo (rust)
contains "$HOME/.cargo/bin" $PATH
or set fish_user_paths "$HOME/.cargo/bin" $PATH

# Bloop installed with curl 
# contains "$HOME/.bloop" $PATH
# or set fish_user_paths "$HOME/.bloop" $PATH
contains "$HOME/Library/Application Support/Coursier/bin" $PATH
or set fish_user_paths "$HOME/Library/Application Support/Coursier/bin" $PATH

# content has to be in .config/fish/config.fish
# if it does not exist, create the file
setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV 
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

if [ -n "$SSH_AGENT_PID" ] 
    ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    end  
else
    if [ -f $SSH_ENV ]
        . $SSH_ENV > /dev/null
    end  
    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
    if [ $status -eq 0 ]
        test_identities
    else 
        start_agent
    end  
end

# Fisher autoinstall in a new system
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# direnv - 
direnv hook fish | source

# Use most instead of less as pager (color in manpages for example)
# Commented out on 2022-03-10 because `nix --help` shows escape characters instead of colors while less behavies properly
# if which -s most;
#   set -x PAGER most
# end
set -x PAGER less
# TODO setup man pages with colors - investigate further
# attempted approach in https://unix.stackexchange.com/a/147 did not work on the mac and exhibited raw escape characters instead.

# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'


# Local configuration (not to be commited or shared with other conputers)
set local_config_fish $HOME/.config/fish/config_local.fish
if test -e $local_config_fish 
    source $local_config_fish
else
    echo "Config file $local_config_fish does not exist"
end

# fzf
fzf --fish | source

# zoxide configuration
# zoxide init fish | source


# The minimal, blazing-fast, and infinitely customizable prompt for any shell!
# https://github.com/starship/starship
starship init fish | source

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Taskwarrior Server
export TASKDDATA=/var/taskd

# Local and private configuration
source $HOME/.config/fish/config_local.fish



set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/amartins/.ghcup/bin $PATH # ghcup-env
