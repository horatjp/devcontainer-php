FROM php:8.0-cli

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=${USER_UID}

ARG LOCALE=en_US.UTF-8
ARG TIME_ZONE=UTC

ENV PKG="bash-completion curl dnsutils git imagemagick jq locales mariadb-client postgresql-client rsync sqlite3 tree unzip vim wget zip"
ENV PKG_LIB="libc-client-dev libfreetype6-dev libjpeg62-turbo-dev libkrb5-dev libmagickwand-dev libonig-dev libpng-dev libpq-dev libsqlite3-dev libxslt-dev libzip-dev"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV DEBIAN_FRONTEND noninteractive
ENV LANG=${LOCALE}
ENV TZ=${TIME_ZONE}

COPY --from=composer:2.4.3 /usr/bin/composer /usr/bin/composer
COPY --from=node:18 /usr/local/bin/node /usr/local/bin/
COPY --from=node:18 /usr/local/lib/node_modules/ /usr/local/lib/node_modules/
RUN ln -s /usr/local/bin/node /usr/local/bin/nodejs \
    && ln -s /usr/local/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm \
    && ln -s /usr/local/lib/node_modules/npm/bin/npx-cli.js /usr/local/bin/npx

RUN apt-get update \
    && apt-get install -y $PKG $PKG_LIB \
    && pecl install imagick redis-5.3.4 xdebug-3.1.1 \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-enable imagick redis xdebug \
    && docker-php-ext-install bcmath exif gd imap intl pdo_mysql pdo_pgsql pdo_sqlite xml zip \
    #
    # locale
    && sed -i -E "s/# (${LOCALE})/\1/" /etc/locale.gen \
    && locale-gen ${LOCALE} \
    && dpkg-reconfigure locales \
    && update-locale LANG=${LOCALE} \
    #
    # timezone
    && ln -snf /usr/share/zoneinfo/${TIME_ZONE} /etc/localtime && echo ${TIME_ZONE} > /etc/timezone \
    #
    # user
    && groupadd --gid ${USER_GID} ${USERNAME} \
    && useradd -s /bin/bash --uid ${USER_UID} --gid ${USER_GID} -m ${USERNAME} \
    && apt-get install -y sudo \
    && echo ${USERNAME} ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}
