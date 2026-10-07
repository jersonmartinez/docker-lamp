FROM php:8.2-apache

ARG PHP_MEMORY_LIMIT=256M
ARG PHP_MAX_EXECUTION_TIME=30
ARG PHP_UPLOAD_MAX_FILESIZE=20M
ARG PHP_POST_MAX_SIZE=20M

# Use production PHP settings
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Update and install dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libpng-dev \
        libzip-dev \
        zlib1g-dev \
        libonig-dev \
        curl \
        sendmail \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        pdo \
        pdo_mysql \
        zip \
        mbstring \
        gd

# Configure PHP
RUN echo "memory_limit = ${PHP_MEMORY_LIMIT}" >> /usr/local/etc/php/conf.d/docker-php-memory-limit.ini \
    && echo "max_execution_time = ${PHP_MAX_EXECUTION_TIME}" >> /usr/local/etc/php/conf.d/docker-php-max-execution-time.ini \
    && echo "upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}" >> /usr/local/etc/php/conf.d/docker-php-upload-max-filesize.ini \
    && echo "post_max_size = ${PHP_POST_MAX_SIZE}" >> /usr/local/etc/php/conf.d/docker-php-post-max-size.ini

# Configure Apache
RUN a2enmod rewrite headers ssl
RUN sed -i 's/ServerTokens OS/ServerTokens Prod/' /etc/apache2/conf-available/security.conf \
    && sed -i 's/ServerSignature On/ServerSignature Off/' /etc/apache2/conf-available/security.conf

# Allow per-directory overrides (.htaccess) under the web root.
# Debian's default <Directory /var/www/> block sets AllowOverride None, so
# `a2enmod rewrite` alone is not enough: any application that ships a
# .htaccess (WordPress, Laravel's public/, custom front controllers) has its
# rewrite/ErrorDocument rules silently ignored without this. Also set a global
# ServerName to suppress the "could not reliably determine the server's fully
# qualified domain name" startup warning.
RUN printf '%s\n' \
      '<Directory /var/www/html/>' \
      '    AllowOverride All' \
      '    Require all granted' \
      '</Directory>' \
      'ServerName localhost' \
      > /etc/apache2/conf-available/docker-lamp.conf \
    && a2enconf docker-lamp

# Create a non-root user
RUN useradd -r -u 1000 -g www-data webuser

# Create PHP log directory and set permissions
RUN mkdir -p /var/log/php \
    && chown -R webuser:www-data /var/log/php \
    && chmod 755 /var/log/php

# Set proper permissions for web directory
RUN chown -R webuser:www-data /var/www/html \
    && chmod -R 750 /var/www/html

# Switch to non-root user
USER webuser

# Health check
HEALTHCHECK --interval=30s --timeout=3s --retries=3 \
    CMD curl -f http://localhost/ || exit 1
