FROM ghcr.io/horatjp/php-cli:7.1

ARG LOCALE=en_US.UTF-8

ENV LANGUAGE=${LOCALE}
ENV LC_ALL=${LOCALE}

RUN : \
    # locale
    && sed -i -E "s/# (${LOCALE})/\1/" /etc/locale.gen \
    && locale-gen ${LOCALE}
