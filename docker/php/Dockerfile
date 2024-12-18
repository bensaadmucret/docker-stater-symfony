# Utiliser une image PHP 8.2 avec FPM (PHP 8.4 n'existe pas encore)
FROM php:8.3-fpm

# Installer les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    libxml2-dev \
    default-mysql-client \
    git \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        pdo \
        pdo_mysql \
        intl \
        opcache \
        zip \
        xml \
        gd

# Configurer Git avec une identité par défaut
RUN git config --global user.email "bensaadmucret@gmail.com" && \
    git config --global user.name "bensaadmucret"    

# Nettoyer les caches APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Installer Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash && \
    mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# Définir le répertoire de travail
WORKDIR /var/www/html

# Créer le répertoire pour les sessions PHP
RUN mkdir -p /var/lib/php/sessions && \
    chown -R www-data:www-data /var/lib/php/sessions

# Copier les fichiers de l'application
COPY . .

# Configurer les permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Nettoyer le cache Composer
RUN composer clear-cache

# Exposer le port FPM
EXPOSE 9000
