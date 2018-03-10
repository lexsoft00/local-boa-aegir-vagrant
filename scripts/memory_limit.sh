#!/usr/bin/env bash
# Changing Memory Limit every time you run Vagrant UP
echo "Changing memory limit to 1024M"
sed -i 's/256M/1024M/g' /opt/etc/fpm/fpm-pool-common.conf
exit
