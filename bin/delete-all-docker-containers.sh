G#!/bin/bash -
#===============================================================================
#
#          FILE: delete-all-docker-containers.sh
#
#         USAGE: ./delete-all-docker-containers.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (), 
#  ORGANIZATION: 
#       CREATED: 13/10/2020 12:41:39
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error


echo "Stop containers" ;
docker ps -a -q | xargs docker stop
echo "Delete containers" 
docker ps -a -q | docker rm

