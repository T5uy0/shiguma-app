# shiguma-app
Application de tracking alimentaire

## Description

Cette application est une solution complète de suivi alimentaire conçue pour aider les utilisateurs à gérer efficacement leur consommation quotidienne. Elle offre les fonctionnalités suivantes :

- Ajout et gestion de repas : Les utilisateurs peuvent enregistrer leurs repas en sélectionnant des options dans une bibliothèque de repas par défaut ou en ajoutant leurs propres repas personnalisés.
- Suivi des calories consommées : Chaque repas est associé à une valeur calorique, permettant aux utilisateurs de surveiller leurs apports caloriques quotidiens.
- Visualisation des données : Des graphiques clairs et interactifs permettent de suivre l'évolution des calories consommées sur une journée, une semaine ou un mois.
- Interface intuitive : Conçue pour une utilisation simple, l'application aide les utilisateurs à atteindre leurs objectifs alimentaires tout en s'adaptant à leurs besoins individuels.

Cette application constitue un outil idéal pour tous ceux qui souhaitent mieux comprendre et gérer leur alimentation au quotidien.

## Mise en route

### Prérequis

Listez toutes les dépendances et leur version nécessaires au projet en tant que :

- OS supportées :
  - [macOS (Sonoma 14.5)](https://www.iclarified.com/91544/where-to-download-macos-sonoma)
- Langage :
  - [Ruby (3.1.2)](https://www.ruby-lang.org/en/documentation/installation/)
- Extensions :
  - [RubyLSP (v0.8.16)](https://shopify.github.io/ruby-lsp/#with-vs-code)

### Configuration

1. Installer Ruby
   [macOS](https://www.ruby-lang.org/en/documentation/installation/#homebrew)

Pour Git Flow, cela dépend du système d'exploitation que vous utilisez. Si vous utilisez Windows, tout va bien, il est déjà installé avec git. Pour les autres, [suivre ce tutoriel](https://skoch.github.io/Git-Workflow/).

Dans ce projet, j'ai utilisé Visual Studio Code comme IDE principal.

## Déploiement

### Environnement de développement

1. Cloner le dépôt git

```bash
git https://github.com/T5uy0/shiguma-app
cd shiguma-app
```

2. Setup la branche `main` et initialiser Git Flow pour le projet

```bash
git switch main

git flow init
```

3. Mise en place de la base de données et des fichiers de configuration

> Créer les fichiers de configuration pour MySQL et MongoDB et modifier le nom des fichiers

```bash
cp config/database.example.yml config/database.yml

cp .env.example .env 
```

4. Installer les dépendances de MariaDB/MySQL

> MacOS :

```bash
brew install mariadb
```

5. Installer les gems du projet

```bash
gem install bundler

bundle install
```

6. Base de données

   1. Créer et migrer la base de données SQL

   ```bash
   bundle exec rake db:create

   bundle exec rake db:migrate
   ```

8. Lancer le serveur Ruby

```bash
rerun app.rb
```

## Structure des répertoires

```bash
./shiguma-app
├── Gemfile
├── Gemfile.lock
├── README.md
├── Rakefile
├── app
│   ├── controllers
│   │   ├── consumptions_controller.rb
│   │   ├── masses_controller.rb
│   │   ├── meals_controller.rb
│   │   └── users_controller.rb
│   ├── middlewares
│   │   └── auth.rb
│   ├── models
│   │   ├── consumption.rb
│   │   ├── mass.rb
│   │   ├── meal.rb
│   │   └── user.rb
│   ├── services
│   │   └── db_connection.rb
│   └── views
│       ├── consumption
│       │   ├── create.erb
│       │   ├── edit.erb
│       │   └── index.erb
│       ├── error
│       │   └── 404.erb
│       ├── layout.erb
│       ├── login
│       │   ├── edit.erb
│       │   └── index.erb
│       ├── mass
│       │   ├── create.erb
│       │   ├── edit.erb
│       │   └── index.erb
│       ├── meal
│       │   ├── create.erb
│       │   ├── edit.erb
│       │   └── index.erb
│       └── register
│           └── index.erb
├── app.rb
├── config
│   ├── database.example.yml
│   ├── database.yml
│   ├── irb.rb
│   ├── locales
│   │   └── fr.yml
│   └── logger.rb
├── config.rb
├── db
│   ├── migrate
│   │   ├── 20250123073427_create_users.rb
│   │   ├── 20250123083235_create_meals.rb
│   │   ├── 20250123083936_drop_meals_table.rb
│   │   ├── 20250123091537_create_meals_table.rb
│   │   ├── 20250123091653_create_consuptions.rb
│   │   ├── 20250125192659_add_column_meal.rb
│   │   ├── 20250126113654_add_is_default_meal.rb
│   │   ├── 20250130084833_create_mass_table.rb
│   │   └── 20250206075609_add_way_field_img_on_meal.rb
│   └── schema.rb
├── logs
│   ├── 2025-01-23.log
│   ├── 2025-01-24.log
│   ├── 2025-01-25.log
│   ├── 2025-01-26.log
│   ├── 2025-01-27.log
│   ├── 2025-01-30.log
│   ├── 2025-02-01.log
│   ├── 2025-02-03.log
│   ├── 2025-02-04.log
│   ├── 2025-02-06.log
│   ├── 2025-02-10.log
│   ├── 2025-02-12.log
│   ├── 2025-02-13.log
│   ├── 2025-02-15.log
│   ├── 2025-02-17.log
│   ├── 2025-02-24.log
│   ├── 2025-02-27.log
│   ├── 2025-03-07.log
│   └── 2025-03-09.log
└── public
    └── img
        ├── Ananas.webp
        ├── Aubergine.jpg
        ├── Avocat.jpg
        ├── Banane.avif
        ├── Brocoli.jpg
        ├── Carotte.jpg
        ├── Cerise.jpg
        ├── Chou.jpg
        ├── Choufleur.jpg
        ├── Concombre.jpg
        ├── Courgette.jpg
        ├── Epinard.jpg
        ├── Fraise.jpg
        ├── Haricot.jpg
        ├── Kiwi.jpg
        ├── Laitue.jpeg
        ├── Mangue.webp
        ├── Oignon.png
        ├── Orange.jpg
        ├── Pasteque.webp
        ├── Patate_douce.avif
        ├── Peche.jpg
        ├── Petit_poid.png
        ├── Poire.webp
        ├── Poivron.jpg
        ├── Pomme.avif
        ├── Pomme_de_terre.jpg
        ├── Radis.png
        ├── Raisin.jpg
        └── Tomate.png
```

## Contact
- Julien : <julien.schneider@eduvaud.ch>, [GitHub](https://github.com/T5uy0)
