FROM php:8.2-fpm

ARG USER_UID=1000
ARG USER_GID=${USER_UID}

RUN apt-get update \
    && apt-get install -y libc-client-dev libfreetype6-dev libjpeg62-turbo-dev libkrb5-dev libmagickwand-dev libonig-dev libpng-dev libpq-dev libsqlite3-dev libxslt-dev libzip-dev sqlite3 zip \
    && pecl install imagick mailparse redis-6.0.2 xdebug-3.3.1 \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-enable imagick mailparse redis xdebug \
    && docker-php-ext-install bcmath exif gd imap intl mysqli pdo_mysql pdo_pgsql pdo_sqlite xml zip \
    #
    # user
    && groupmod -o -g ${USER_GID} www-data \
    && usermod -o -u ${USER_UID} -g www-data www-data
