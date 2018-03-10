#!/usr/bin/env bash
# Add DNS to Local Host
echo "127.0.1.1 aegir.local o1.sub.aegir.local chive.aegir.local" >> /etc/hosts
echo "DNS Entry 127.0.1.1 to /etc/hosts"

# Install XDebug
echo "Installing XDebug..."
cd /opt
wget -U iCab http://xdebug.org/files/xdebug-2.6.0.tgz &> /dev/null
tar -xzf xdebug-2.6.0.tgz
cd xdebug-2.6.0
/opt/php70/bin/phpize
sh ./configure --with-php-config=/opt/php70/bin/php-config
make
make install

# Add xdebug config to php.ini
echo '
; Xdebug
zend_extension="/opt/php70/lib/php/extensions/no-debug-non-zts-20151012/xdebug.so"
xdebug.remote_enable=1
xdebug.remote_handler=dbgp
xdebug.remote_connect_back=1
xdebug.remote_log = /tmp/xdebug.log
xdebug.remote_port=9000

' >> /opt/php70/etc/php70.ini

# Clean up setup files
cd ..
rm -fr xdebug-2.6.0*

# Install XDebug
echo "Installing XHProf..."
/opt/php70/bin/pecl install xhprof-beta

# Add xdebug config to php.ini
echo '
; XHProf
extension="/opt/php70/lib/php/extensions/no-debug-non-zts-20151012/xhprof.so"

' >> /opt/php70/etc/php70.ini
