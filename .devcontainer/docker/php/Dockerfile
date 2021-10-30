FROM php:8.0-fpm-bullseye

ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN apt-get update \
    && apt-get install -y libc-client-dev libfreetype6-dev libjpeg62-turbo-dev libkrb5-dev libmagickwand-dev libonig-dev libpng-dev libpq-dev libsqlite3-dev libxslt-dev libzip-dev sqlite3 zip \
    && pecl install imagick redis-5.3.4 xdebug-3.1.1 \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-enable imagick redis xdebug \
    && docker-php-ext-install bcmath gd imap intl pdo_mysql pdo_pgsql pdo_sqlite xml zip \
    #
    # user
    && groupmod -o -g ${USER_GID} www-data \
    && usermod -o -u ${USER_UID} -g www-data www-data
