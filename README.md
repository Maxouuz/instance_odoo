
## Déploiement Odoo sur Azure


## 1 Scénario

On trouve assez facilement des offres d’hébergement de la solution Odoo permettant aux entreprises de se décharger des questions d’installation, de paramétrage et de maintenance.

Globalement, sur ces offres on retrouve :

- la possibilité d’avoir une installation d’Odoo dans une version spécifique
- une isolation des différents clients (chacun son installation)
- un accès HTTPS
- une sauvegarde des données
- la sécurité

Dans le cadre de ce projet, on vous propose de vous mettre en position d’hébergeur. Vous devrez donc mettre en place une infrastructure permettant de réaliser l’hébergement de différents serveurs Odoo pour des clients. Dans la mesure où vous pourrez être amenés à réaliser plusieurs installations d’Odoo en fonction des besoins des clients, il devient primordial d’automatiser le processus de déploiment. **L’élément central de ce projet sera donc la production de configurations terraform et ansible permettant ce déploiment automatique.**


## 2 Infrastructure et technologies

La figure ci-dessous vous présente l’infrastructure à mettre en place qui est assez similaire à celle de la SAÉ de semestre 4.

![](https://i.ibb.co/BrWxnXn/odoo.jpg)

Les choix d’infastructure sont les suivants :

- Vous utiliserez une base PostgreSQL. Chaque client aura une base spécifique pour son instance Odoo
- Le serveur Odoo sera utilisé pour le déploiement des différents Odoo des clients sous forme de containers docker
- Le reverse proxy permettra un accès différencié pour chaque client

La sécurisation doit être prise en compte :

- Les instances Odoo et la base de données ne sont pas accessibles directement et les connexions vers la base de données seront reduites au strict nécessaire (Odoo client -> base client)

## 3 Travail attendu

Le travail sera réalisé en binômes.

Vous devrez produire les configurations pour automatiser le déploiement ainsi que les procédures d’utilisation.

## 4 Rendu / évaluation

Votre travail sera rendu sur gitlab.
