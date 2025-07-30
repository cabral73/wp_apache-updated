#!/bin/sh
if [ ! -f /home/site/wwwroot/index.php ]; then
    cp -a /var/www/html/. /home/site/wwwroot/
    chown -R www-data:www-data /home/site/wwwroot
fi

exec docker-entrypoint.sh apache2-foreground
