FROM dylanlindgren/docker-phpcli:latest

RUN apt-get update -y && \
    apt-get install -y curl git php5-mcrypt php5-gd apache2 && \
    curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    composer self-update && \
    apt-get remove --purge curl -y && \
    apt-get clean

RUN rm /etc/apache2/sites-enabled/*
COPY apache.conf /etc/apache2/sites-enabled/

RUN mkdir -p /var/www
VOLUME ["/var/www"]
WORKDIR "/var/www"

ENTRYPOINT ["/usr/sbin/apache2ctl"]
CMD ["-DFOREGROUND"]
