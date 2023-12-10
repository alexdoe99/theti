# Use an official PHP image as the base image
FROM php:8.1-fpm

# Set the working directory in the container
WORKDIR /var/www/html

# Copy composer files and install dependencies
COPY composer.json composer.lock ./
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    && apt-get clean \
    && docker-php-ext-install pdo_mysql \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && composer install --no-scripts --no-autoloader

# Copy the rest of the application
COPY . .

# Set permissions if needed
RUN chown -R www-data:www-data /var/www/html
RUN chmod -R 755 /var/www/html/var

# Expose port 8000 to the outside world
EXPOSE 8000

# Start the Symfony server
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
#
