FROM wordpress:6.5.2-php8.2-apache

ENV APACHE_DOCUMENT_ROOT=/home/site/wwwroot

# Altera os paths padrão
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf \
    && sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Garante que o diretório exista
RUN mkdir -p /home/site/wwwroot \
    && chown -R www-data:www-data /home/site/wwwroot \
    && chmod +x /usr/local/bin/entrypoint.sh

# Copia o entrypoint corrigido
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
