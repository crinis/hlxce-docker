FROM php:5-apache

ENV HLXCE_VERSION=1_6_19 \
    DB_NAME=hlxce \
    DB_USERNAME=hlxce \
    DB_PASSWORD=hlxce \
    DB_HOST=db \
    UPDATE_DB=false

COPY docker-hlxce-entrypoint /usr/local/bin/
COPY hlxce.ini /usr/local/etc/php/conf.d/

WORKDIR /var/www/html/

RUN set -xe \
        && buildDeps=" \
		        git \
	    " \
        && apt-get update && apt-get -y install $buildDeps mysql-client sed libfreetype6-dev libjpeg62-turbo-dev --no-install-recommends \
        && rm -rf /var/lib/apt/lists/* \
        && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
        && docker-php-ext-install mysql gd \
        && chmod +x /usr/local/bin/docker-hlxce-entrypoint \
        && git clone https://crinis@bitbucket.org/Maverick_of_UC/hlstatsx-community-edition.git hlstatsx \
        && mv hlstatsx/web/* . \
        && mv hlstatsx/sql/ . \
        && rm -R hlstatsx/ \
        && chown -R www-data:www-data . \
        && docker-php-source delete \
        && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false $buildDeps

ENTRYPOINT ["docker-hlxce-entrypoint"]

CMD ["apache2-foreground"]
