#!/bin/bash

# apt and kernel cleaning
/usr/bin/apt-get autoremove -y
/usr/bin/apt-get --purge autoremove -y
/usr/bin/apt-get clean

# mem cleaning
/sbin/sysctl -w vm.drop_caches=3
/bin/sync && /bin/echo 3 | /usr/bin/tee /proc/sys/vm/drop_caches

# logs cleaning

# docker clean up
/usr/bin/echo "INFO: Removing dangling images"
/usr/bin/curl --silent https://gist.githubusercontent.com/macropin/3d06cd315a07c9d8530f/raw | /bin/bash -s rm-dangling
/usr/bin/echo "INFO: Restarting storage"
/usr/bin/docker restart $(/usr/bin/docker ps -aq --filter 'label=group=storage')
/usr/bin/echo "INFO: Restarting running containers"
/usr/bin/docker restart $(/usr/bin/comm -2 -3 <(/usr/bin/docker ps -aq | /usr/bin/sort) <(/usr/bin/docker ps -aq --filter 'label=group=storage' | /usr/bin/sort)