#!/bin/bash

# Copied from /bin/start.sh
# in https://hub.docker.com/r/simplyintricate/mediawiki/~/dockerfile/
chown www-data:www-data /usr/share/nginx/html/images
chown www-data:www-data /usr/share/nginx/html/LocalSettings.php
chown -R www-data:www-data /tmp/extensions/
cp -r /tmp/extensions/* /usr/share/nginx/html/extensions/

service php5-fpm start

# REplace "nginx daemon off" below with "daemon on" and tail syslog
# nginx -g "daemon off;"
service nginx start
service rsyslog start
