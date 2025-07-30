#!/bin/bash

# Se o diretório estiver vazio, copia os arquivos do WordPress
if [ ! -f /home/site/wwwroot/index.php ]; then
  echo ">> Instalando WordPress no /home/site/wwwroot..."
  cp -a /usr/src/wordpress/. /home/site/wwwroot/
  chown -R www-data:www-data /home/site/wwwroot
else
  echo ">> WordPress já presente no /home/site/wwwroot"
fi

# Roda o apache em foreground (mantém container vivo)
exec apache2-foreground
