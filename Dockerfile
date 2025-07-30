FROM wordpress:latest

# Define o DocumentRoot do Apache para /home/site/wwwroot
ENV APACHE_DOCUMENT_ROOT=/home/site/wwwroot

# Altera os arquivos de configuração do Apache para o novo DocumentRoot
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf \
    && sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Cria o diretório wwwroot
RUN mkdir -p /home/site/wwwroot \
    && chown -R www-data:www-data /home/site/wwwroot

EXPOSE 80

CMD ["/bin/sh", "-c", "if [ ! -f /home/site/wwwroot/index.php ]; then cp -a /var/www/html/. /home/site/wwwroot/ && chown -R www-data:www-data /home/site/wwwroot; fi && exec docker-entrypoint.sh apache2-foreground"]
