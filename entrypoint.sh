#!/bin/sh

# Se não houver WordPress no wwwroot, copia da fonte oficial
if [ ! -f /home/site/wwwroot/index.php ]; then
    cp -a /usr/src/wordpress/. /home/site/wwwroot/
    chown -R www-data:www-data /home/site/wwwroot
fi

# Executa o entrypoint original do WordPress apontando para o Apache
exec docker-entrypoint.sh apache2-foreground
