chmod +x install-symfony.sh

Lancer les services :
docker compose up --build -d

Dans le conteneur php, lancer la console :
docker exec -it php bash
./install-symfony.sh


Arrêter les services :
docker compose down

Voir les logs :
docker compose logs -f

Accéder à un conteneur :
docker exec -it php bash

Accéder à l'application :

Symfony : Ouvrez votre navigateur et allez à http://localhost.

Adminer : Ouvrez votre navigateur et allez à http://localhost:8080.

Utilisation d'Adminer
Lorsque vous accédez à http://localhost:8080, vous verrez l'interface d'Adminer. Remplissez les champs suivants pour vous connecter à la base de données :

Système : MySQL

Serveur : mariadb

Utilisateur : app_user

Mot de passe : app_password

Base de données : app_db

