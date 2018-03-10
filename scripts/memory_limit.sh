#!/usr/bin/env bash
# Changing Memory Limit every time you run Vagrant UP
echo "Changing memory limit to 1024M"
sed -i "s#php_admin_value[memory_limit] = 256M#php_admin_value[memory_limit] = 1024M#g" /opt/etc/fpm/fpm-pool-common.conf
sed -i "s#memory_limit = 256M#memory_limit = 1024M#g" /opt/php70/etc/php70.ini
exit
