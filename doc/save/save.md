# Sauvegarde des données

## Dump des bases de données

Nous avons éffectués une sauvegarde des différentes bases de données des instances.

Nous pouvons retrouver cette configuration dans le playbook [**playbook_dump.yml**](../../ansible/save/1-playbook_dump.yml).

Le fonctionnement est très simple : Nous sauvegardons les données par instances sur la machine postgres pour ensuite nous les envoyer sur notre machine locale. Le playbook est alors constitué de différentes tâches :

- Création des dossiers d'acceuil de la save par instances
- Dump des bases de données qui sont mises dans les dossiers ci-dessus
- Envoie de ces saves sur la machine locale
- Suppression des saves de la machine postgres. 

Ainsi vous pourrez retrouver les différentes saves sur votre machine locale, à la racine du projet dans le dosser **save_sql**.

Vous pouvez effectuer une sauvegarde à l'aide du script [**dump.sh**](../../dump.sh)

ps: Lors d'une deuxième sauvegarde, la première est renommée en old, permmettant ainsi de réduire la marge d'érreur. La save actuelle et la n-1 sont stockées sur la machine locale.

## Restaurer les données

La restauration de la base de données s'éffectue depuis le playbook [**playbook_restore.yml**](../../ansible/save/2-playbook_restore.yml).

Ce playbook copie les fichiers de save.sql sur la machine locale, les envoies vers un endroit temporaire de la machine postgres et les restaure à l'aide de la commande **pg_restore**


Vous pouvez effectuer une restauration à l'aide du script [**dump.sh**](../../dump.sh)

> Revenir [**au point de départ de la documentation**](../main.md)