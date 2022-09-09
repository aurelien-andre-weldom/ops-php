#
# OPS PHP
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
# @see https://github.com/aurelien-andre-weldom/ops-php
#
FROM ops-debian/debian:100.0.0-bullseye

USER root

RUN set -eux; \
apt-get update; \
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg; \
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list

RUN set -eux; \
apt-get update \
&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
php8.1-cli \
php8.1-common \
php8.1-bcmath \
php8.1-opcache \
php8.1-apcu \
php8.1-amqp \
php8.1-xdebug \
php8.1-redis \
php8.1-curl \
php8.1-soap \
php8.1-mbstring \
php8.1-mysql \
php8.1-xml \
php8.1-xsl \
php8.1-gd \
php8.1-intl \
php8.1-ftp \
php8.1-zip

RUN set -eux; \
ln -sf \
/etc/php/8.1/90-php.ini \
/etc/php/8.1/cli/conf.d/90-php.ini


RUN set -eux; \
mkdir -p \
/etc/php \
/bin; \
chmod 777 -R \
/etc/php \
/bin; \
chown rootless:rootless \
/etc/php \
/bin

COPY --chown=rootless:rootless system .

RUN set -eux; \
chmod +x /usr/bin/docker-*; \
chmod +x /usr/bin/php*

RUN set -eux; \
echo "docker-entrypoint-php" >> /docker-entrypoint.list


ENTRYPOINT ["docker-entrypoint.sh"]

STOPSIGNAL SIGQUIT

EXPOSE 9001

CMD ["supervisord"]

USER rootless
