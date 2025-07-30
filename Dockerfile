FROM wordpress:latest

# Define o novo DocumentRoot
ENV APACHE_DOCUMENT_ROOT=/home/site/wwwroot

# Ajusta os arquivos de conf para refletir o novo DocumentRoot
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf \
    && sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Cria o diretório wwwroot
RUN mkdir -p /home/site/wwwroot \
    && chown -R www-data:www-data /home/site/wwwroot

# Define corretamente o ENTRYPOINT padrão
ENTRYPOINT ["docker-entrypoint.sh"]

# CMD com lógica de cópia e inicialização
CMD ["sh", "-c", "if [ ! -f /home/site/wwwroot/index.php ]; then cp -a /var/www/html/. /home/site/wwwroot/ && chown -R www-data:www-data /home/site/wwwroot; fi && apache2-foreground"]
