#!/bin/bash -
#===============================================================================
#
#          FILE: tmux-work-setup.sh
#
#         USAGE: ./tmux-work-setup.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 10/08/2021 22:59:34
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

tmux new -s work -d
tmux rename-window -t work vim
tmux send-keys -t work 'vim' C-m

tmux new-window -t work
tmux rename-window -t work server
tmux send-keys -t work './bin/rails s' C-m
tmux split-window -v -t work
tmux send-keys -t work './bin/sidekiq' C-m
tmux select-window -t work:1
tmux attach -t work
