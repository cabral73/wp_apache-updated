#!/bin/bash
set -ex

echo ">> Entrou no entrypoint"

# Se o diretório estiver vazio, copia os arquivos do WordPress
if [ ! -f /home/site/wwwroot/index.php ]; then
  echo ">> Instalando WordPress no /home/site/wwwroot..."
  cp -a /usr/src/wordpress/. /home/site/wwwroot/
  chown -R www-data:www-data /home/site/wwwroot
else
  echo ">> WordPress já presente no /home/site/wwwroot"
fi

# Roda o apache em foreground (mantém container vivo)
echo ">> Iniciando Apache..."
exec apache2ctl -D FOREGROUND
