# BIO500 Benthos : Création d'un base de données sur les organismes benthiques du Québec

#### [Description du projet :]{.underline}

Dans le cadre du cours de Méthodes en écologie computationnelle - BIO500 - nous avons eu le mandat de réaliser la gestion, l'analyse et la présentations des données récoltées dans les dernières années de la biodiversité benthique sur les rivières du Québec.

Pour ce faire, nous avons donc rassemblé les données récoltées par les équipes sur le terrain, avons nettoyé les données, créer une base de donnée commune où il sera possible d'ajouter les nouvelles données terrain prises à chaque année par la suite.

AJOUTER DES RÉSULTATS ?

#### [Structure du répertoire :]{.underline}

-   Les fichiers CSV de données ont été mises dans le dossier DATA.

-   Les fonctions créées pour ajuster la base de données ont été mises dans le dossier Fonctions.

RESSOURCES NÉCESSAIRES ?

#### [Descriptions des fichiers :]{.underline}

-   benthos_GITHUB_partagee.R : script principal faisant appel aux fonctions

-   creation_table.R : permet de venir créer la table de benthos.

-   fonction_combine.R : permet de venir combiner toutes les données récoltées dans un même fichier.

-   supp_na.R : fonction qui vient supprimer les colonnes inutiles, étant donné qu'elles ne contiennent que de NA.

-   uniformiser_heures.R : fonction qui permet de mettre les heures toutes dans le même format.

#### [Instructions :]{.underline}

-   Premièrement, s'assurer d'avoir bien mis son working directory dans le projet en question

-   Pour l'exécution du code, nous utilisons les packages suivants : readr, dplyr, lubridate, janitor et stringr. Bien s'assurer que vous les avez installés préalablement.

-   Les données se trouvent dans le fichier DATA.

-   COMMENT REPRODUIRE LES RÉSULTATS ?

#### [Auteurs et contributeurs :]{.underline}

Léanne Beauregard, Élyse Castilloux, Maude Roy et Érick-Daniel Vasquez
