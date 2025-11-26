FROM php:8.4-apache

# Copy customized Apache configuration
COPY vhost.conf /etc/apache2/sites-available/vhost.conf

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    libzip-dev \
    libicu-dev \
    ca-certificates \
    lsb-release \
    gnupg \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql intl zip

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
    && apt-get install -y nodejs

ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN corepack enable pnpm && corepack prepare pnpm@latest --activate

# Enable Apache mod_rewrite
RUN a2enmod rewrite

COPY vhost.conf /etc/apache2/sites-available/000-default.conf

# Copy application into the image
COPY . /var/www/html

# Set working directory
WORKDIR /var/www/html

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install Composer dependencies
RUN git config --global --add safe.directory /var/www/html
RUN composer install --no-interaction --no-plugins --no-scripts --prefer-dist
RUN CI=true pnpm install
RUN CI=true pnpm run build

# Set file ownership for Apache
RUN chown -R www-data:www-data /var/www/html
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80