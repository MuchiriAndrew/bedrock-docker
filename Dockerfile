# Use webdevops/php-nginx image as the base
FROM webdevops/php-nginx:8.3

# Set the working directory inside the container
WORKDIR /app

# Copy the application code to the container
COPY . /app

ENV WEB_DOCUMENT_ROOT=/app/web

# install necessary alpine packages
RUN apt update && apt-get install -y \
    curl \
    git \
    zip \
    unzip \
    dos2unix \
    supervisor \
    nano


RUN apt update && apt-get install -y \
    libpng-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev

# # # compile native PHP packages
RUN docker-php-ext-install \
    gd \
    pcntl \
    bcmath \
    mysqli \
    pdo \
    pdo_mysql

# configure packages
RUN docker-php-ext-configure gd --with-freetype --with-jpeg


# Install Composer dependencies (assuming you have a composer.json)
RUN composer install --no-dev --optimize-autoloader

# Adjust permissions if necessary
RUN chown -R www-data:www-data /app

# Expose port 80 to access the container
EXPOSE 80

# docker run -d --name laravel-app-container --network custom-applications-network \
# -e DB_HOST=mysql-container \
# -e DB_DATABASE=bedrock-wp-site \
# -e DB_USERNAME=root \
# -e DB_PASSWORD=Muchiri1234! \
# -p 8084:80 bedrock-image:v1



# docker run --name docker-to-bedrock-container --network custom-applications-network \
#  -e WORDPRESS_DB_HOST=mysql-container \
#  -e WORDPRESS_DB_USER='root' \
#  -e WORDPRESS_DB_PASSWORD='Muchiri1234!' \
#  -e WORDPRESS_DB_NAME=wp-bedrock-site \
#  -p 8084:80 docker-to-bedrock-image:v1