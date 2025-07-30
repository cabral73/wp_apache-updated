#!/bin/sh
echo "Entrypoint started" >> /home/site/wwwroot/entrypoint.log 2>&1

if [ ! -f /home/site/wwwroot/index.php ]; then
    echo "Copiando arquivos padrão do WordPress..." >> /home/site/wwwroot/entrypoint.log 2>&1
    cp -a /var/www/html/. /home/site/wwwroot/
    chown -R www-data:www-data /home/site/wwwroot
fi

echo "Iniciando Apache..." >> /home/site/wwwroot/entrypoint.log 2>&1
exec docker-entrypoint.sh apache2-foreground
