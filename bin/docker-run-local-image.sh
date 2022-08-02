#!/bin/bash -
#===============================================================================
#
#          FILE: docker-run-local-image.sh
#
#         USAGE: ./docker-run-local-image.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 09/23/2021 09:30:41
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error
docker image ls | fzf | awk '{print $3}' | xargs docker run -it
