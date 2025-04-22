# BIO500 Benthos : Création d'un base de données sur les organismes benthiques du Québec

#### [Description du projet :]{.underline}

Dans le cadre du cours de Méthodes en écologie computationnelle - BIO500 - nous avons eu le mandat de réaliser la gestion, l'analyse et la présentations des données récoltées dans les dernières années de la biodiversité benthique sur les rivières du Québec.

Pour ce faire, nous avons donc rassemblé les données récoltées par les équipes sur le terrain, avons nettoyé les données, créer une base de donnée commune où il sera possible d'ajouter les nouvelles données terrain prises à chaque année par la suite.

De plus, nous avons analysé certaines données en rapport avec la richesse spécifique benthique présente selon différentes conditions environnementales. Dans le jeu de données actuel, on ne trouve qu'une variable significative qui fait varier la richesse spécifique du benthos : la température de l'eau. Par contre cette dernière n'explique pas toute la variation et des analyses supplémentaires seront bienvenues à la suite de l'acquisition de nouvelles données sur la communauté benthique du Québec.

[Avertissement :]{.underline} On a rencontré une problématique lors de la création de notre fichier PDF : les graphiques que nous avions créés précédement pour faire l'analyse, avant de les mettre dans le rapport ne sont pas les mêmes que ceux dans le rapport, même si nous n'avons pas changé le code. Ce qui fait que l'analyse des graphiques ne concorde pas avec les résultats.

#### [Structure du répertoire :]{.underline}

-   Les fichiers CSV de données ont été mises dans le dossier DATA.

-   Les fonctions créées pour ajuster la base de données ont été mises dans le dossier Fonctions.

-   Le dossier latex permet de la rédaction et l'exécution du rapport final.

-   Le dossier RMarkdown_article contient le fichier RMarkdown qui permet de générer le rapport final.

-   Le dossier \_targets contient les fichiers du pipeline des données.

#### [Descriptions des fichiers :]{.underline}

-   execution.R : script principal qui permet de faire rouler le pipeline.

-   fonction_nettoyerdata.R : permet de venir combiner toutes les données récoltées dans un même fichier et de nettoyer les irrégularités des fichiers de données.

-   creer_table.R : permet de venir créer les tables SQL.

-   requete_temp.R : fichier contenant les fonctions pour créer les requêtes SQL.

-   graphique.R : fichier contenant les fonctions qui permettent de créer les graphiques présentés dans le rapport.

-   \_targets.R : fichier de pipeline de données qui permet de créer la base de données et le rapport final.

-   reseau.db : fichier contenant les tables SQL enregistrées.

-   

#### [Instructions :]{.underline}

-   Premièrement, s'assurer d'avoir bien mis son working directory dans le projet en question

-   Pour l'exécution du code, nous utilisons les packages suivants : readr, dplyr, lubridate, janitor, stringr, DBI, RSQLite, targets, rmarkdown, knitr et tarchetypes. Bien s'assurer que vous les avez installés préalablement.

-   Dans le fichier execution.R, rouler les librairies nécessaires puis la commande tar_make() pour exécuter le pipeline de données et obtenir le rapport final en pdf qui apparaîtra dans le dossier RMarkdown_article.

-   Les données se trouvent dans le dossier DATA et y sont accessibles, de même que les fonctions dans le fichier Fonctions qui permettent de créer la base de données nettoyée, les tables SQL, les requêtes et les graphiques. Le pipeline permet l'exécution de tout cela plus rapidement et de passer par-dessus les étapes inchangées.

#### [Auteurs et contributeurs :]{.underline}

Léanne Beauregard, Élyse Castilloux, Maude Roy et Érick-Daniel Vasquez
