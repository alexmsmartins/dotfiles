fish_vi_key_bindings

set -gx EDITOR nvim

# add personal scripts to path
contains "$HOME/bin"  $PATH
or set fish_user_paths "$HOME/bin" $PATH
contains "$HOME/.local/bin"  $PATH
or set fish_user_paths "$HOME/.local/bin" $PATH

# add gnu tools (e. g. GNU make) to the path
# contains "/usr/local/opt/make/libexec/gnubin" $PATH
# or set fish_user_paths "/usr/local/opt/make/libexec/gnubin" $PATH

# Config theFuck
eval (thefuck --alias | tr '
' ';')

# Homebrew
contains "/usr/local/sbin" $PATH
or set fish_user_paths "/usr/local/sbin" $PATH

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

# Enable AWS CLI autocompletion: github.com/aws/aws-cli/issues/1079
complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'


# The lines below make sure the artifactory related variables are exported 
# and can be picked up by bash scripts
set -x ARTIFACTORY_USERNAME $ARTIFACTORY_USERNAME
launchctl setenv ARTIFACTORY_USERNAME $ARTIFACTORY_USERNAME
set -x ARTIFACTORY_USER $ARTIFACTORY_USER
launchctl setenv ARTIFACTORY_USER $ARTIFACTORY_USER
set -x ARTIFACTORY_PASSWORD $ARTIFACTORY_PASSWORD
launchctl setenv ARTIFACTORY_PASSWORD $ARTIFACTORY_PASSWORD
set -x ARTIFACTORY_URL $ARTIFACTORY_URL
launchctl setenv ARTIFACTORY_URL $ARTIFACTORY_URL


contains "/usr/local/opt/openssl@1.1/bin" $PATH
or set fish_user_paths "/usr/local/opt/openssl@1.1/bin" $PATH

# The minimal, blazing-fast, and infinitely customizable prompt for any shell!
# https://github.com/starship/starship
starship init fish | source

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

