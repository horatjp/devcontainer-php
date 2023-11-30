FROM php:7.4-fpm

ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN apt-get update \
    && apt-get install -y zip unzip libzip-dev sqlite3 libsqlite3-dev libonig-dev libpq-dev libxslt-dev libmagickwand-dev libfreetype6-dev libjpeg62-turbo-dev libpng-dev libc-client2007e-dev libkrb5-dev \
    && pecl install imagick redis-5.1.1 xdebug-3.1.1 \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-enable imagick redis xdebug \
    && docker-php-ext-install gd mbstring pdo_mysql pdo_pgsql pdo_sqlite xml zip imap \
    #
    # user
    && groupmod -o -g ${USER_GID} www-data \
    && usermod -o -u ${USER_UID} -g www-data www-data
