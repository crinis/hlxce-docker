FROM php:5-apache

ENV HLXCE_VERSION=1_6_19 \
    DB_NAME=hlxce \
    DB_USERNAME=hlxce \
    DB_PASSWORD=hlxce \
    DB_HOST=db

COPY docker-hlxce-entrypoint /usr/local/bin/
COPY hlxce.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/html/

RUN set -x \
        && apt-get update && apt-get -y install mysql-client sed libfreetype6-dev libjpeg62-turbo-dev \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install mysql gd \
        && chmod +x /usr/local/bin/docker-hlxce-entrypoint \
        && curl -L https://bitbucket.org/Maverick_of_UC/hlstatsx-community-edition/downloads/hlxce_${HLXCE_VERSION}.tar.gz -o hlxce.tar.gz \
        && tar -zxvf hlxce.tar.gz --strip-components=1 web/ \
        && rm -R updater/ \
        && rm -rf hlxce.tar.gz \
        && chown -R www-data:www-data .

ENTRYPOINT ["docker-hlxce-entrypoint"]

CMD ["apache2-foreground"]
