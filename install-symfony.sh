#!/bin/bash
# Configurer Git avec une identité par défaut
git config --global user.email "bensaadmucret@gmail.com"
git config --global user.name "bensaadmucret"

# Vérifier si le dossier "vendor" existe
if [ ! -d "vendor" ]; then
    echo "Symfony application not detected. Installing the latest version..."

    # Créer un dossier temporaire pour l'installation de Symfony
    mkdir symfony_temp
    cd symfony_temp

    # Installer Symfony dans le dossier temporaire
    symfony new . --version="7.1.*" --webapp

    # Vérifier si l'installation a réussi
    if [ $? -ne 0 ]; then
        echo "Error: Symfony installation failed."
        cd ..
        rm -rf symfony_temp
        exit 1
    fi

    # Déplacer les fichiers de Symfony vers le répertoire parent
    mv * ..
    mv .* .. 2>/dev/null  # Déplacer les fichiers cachés, ignorer les erreurs

    # Retourner au répertoire parent et supprimer le dossier temporaire
    cd ..
    rm -rf symfony_temp

    # Installer les dépendances
    composer install

    echo "Symfony application installed successfully!"

    # Définir les variables d'environnement nécessaires
    MARIADB_USER=app_user
    MARIADB_PASSWORD=roapp_passwordot
    MARIADB_DATABASE=app_db

    # Créer le fichier .env.local avec les variables d'environnement
    cat <<EOL > .env.local
DATABASE_URL="mysql://\${MARIADB_USER}:\${MARIADB_PASSWORD}@mariadb:3306/\${MARIADB_DATABASE}?serverVersion=mariadb-10.11.2"
APP_SECRET=$(openssl rand -hex 32)

# Variables d'environnement pour la base de données
MARIADB_USER=${MARIADB_USER}
MARIADB_PASSWORD=${MARIADB_PASSWORD}
MARIADB_DATABASE=${MARIADB_DATABASE}

EOL

    echo "File .env.local created with database configuration."
else
    echo "Symfony application already installed. Starting the server..."
fi

# Attendre que MariaDB soit prête
echo "Waiting for MariaDB to be ready..."
until mysql -h mariadb -u "${MARIADB_USER}" -p"${MARIADB_PASSWORD}" -e "SELECT 1" &> /dev/null; do
    sleep 1
done
echo "MariaDB is ready!"
