#!/bin/bash

# apt and kernel cleaning
/usr/bin/apt-get autoremove -y
/usr/bin/apt-get --purge autoremove -y
/usr/bin/apt-get clean

# mem cleaning
/sbin/sysctl -w vm.drop_caches=3
/bin/sync && /bin/echo 3 | /usr/bin/tee /proc/sys/vm/drop_caches

# logs cleaning
/usr/bin/echo "INFO: Removing log files and junk files"
/usr/bin/docker exec -it tracker-announce rm -rf /var/log/crond.log
/usr/bin/rm -rf /root/docker/qbittorrent/data/qBittorrent/logs/*
/usr/bin/rm -rf /root/docker/plex/Library/Application\ Support/Plex\ Media\ Server/Cache/PhotoTranscoder/*

# docker clean up
/usr/bin/echo "INFO: Removing dangling images"
/usr/bin/curl --silent https://gist.githubusercontent.com/macropin/3d06cd315a07c9d8530f/raw | /bin/bash -s rm-dangling
/usr/bin/echo "INFO: stopping all containers"
/usr/bin/docker stop $(/usr/bin/docker ps -aq)
/usr/bin/echo "INFO: Restarting virtual storage"
/usr/bin/docker start $(/usr/bin/docker ps -aq --filter 'label=com.docker.compose.project=plexdrive')
/usr/bin/echo "INFO: Waiting 15s for virtual storage startup"
/usr/bin/sleep 15s
/usr/bin/echo "INFO: Restarting all containers"
/usr/bin/docker start $(/usr/bin/comm -2 -3 <(/usr/bin/docker ps -aq | /usr/bin/sort) <(/usr/bin/docker ps -aq --filter 'label=com.docker.compose.project=plexdrive' | /usr/bin/sort))