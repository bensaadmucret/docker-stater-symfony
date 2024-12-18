-- Création de la base de données
CREATE DATABASE IF NOT EXISTS ${MARIADB_DATABASE};

-- Création de l'utilisateur
CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';

-- Attribution des droits
GRANT ALL PRIVILEGES ON ${MARIADB_DATABASE}.* TO '${MARIADB_USER}'@'%'; 

-- Activation des droits
FLUSH PRIVILEGES;

-- Utilisation de la base de données
USE ${MARIADB_DATABASE};

