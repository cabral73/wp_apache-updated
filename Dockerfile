FROM wordpress:latest

# Define o novo DocumentRoot
ENV APACHE_DOCUMENT_ROOT=/home/site/wwwroot

# Ajusta os arquivos de conf para refletir o novo DocumentRoot
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf \
    && sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Cria o diretório wwwroot
RUN mkdir -p /home/site/wwwroot \
    && chown -R www-data:www-data /home/site/wwwroot

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80

ENTRYPOINT ["entrypoint.sh"]
CMD ["apache2-foreground"]