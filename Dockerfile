FROM wordpress:6.5.2-php8.2-apache

ENV APACHE_DOCUMENT_ROOT=/home/site/wwwroot

# Altera os paths padrão
RUN sed -ri -e "s!/var/www/html!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/sites-available/*.conf \
    && sed -ri -e "s!/var/www/!${APACHE_DOCUMENT_ROOT}!g" /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Instala OpenSSH e utilitários necessários
RUN apt-get update && apt-get install -y \
    openssh-server \
    vim \
    && mkdir /var/run/sshd

# Configura a senha do root (opcional, mas útil para teste)
RUN echo 'root:Docker!' | chpasswd

# Permite login como root via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Garante que o diretório exista
RUN mkdir -p /home/site/wwwroot \
    && chown -R www-data:www-data /home/site/wwwroot

# Copia o entrypoint corrigido
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80
EXPOSE 2222

CMD service ssh start
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
