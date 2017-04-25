FROM php:5-apache

ENV HLXCE_VERSION=1_6_19 \
    DB_NAME=hlxce \
    DB_USERNAME=hlxce \
    DB_PASSWORD=hlxce \
    DB_HOST=db

COPY docker-hlxce-entrypoint /usr/local/bin/

WORKDIR /var/www/html/

RUN set -x \
        && apt-get update && apt-get -y install mysql-client sed \
        && docker-php-ext-install mysql \
        && chmod +x /usr/local/bin/docker-hlxce-entrypoint \
        && curl -L https://bitbucket.org/Maverick_of_UC/hlstatsx-community-edition/downloads/hlxce_${HLXCE_VERSION}.tar.gz -o hlxce.tar.gz \
        && tar -zxvf hlxce.tar.gz --strip-components=1 web/ \
        && rm -R updater/ \
        && rm -rf hlxce.tar.gz \
        && chown -R www-data:www-data .

ENTRYPOINT ["docker-hlxce-entrypoint"]

CMD ["apache2-foreground"]
