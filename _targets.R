#Pipeline

# Étape 1 : Charger les packages et scripts
library(targets)
library(tarchetypes)

source('Fonctions/fonction_nettoyerdata.R')
source('Fonctions/creer_tables.R')
source('Fonctions/requete_temp.R')
source('Fonctions/graphique.R')

tar_option_set(packages = c("dplyr", "readr", "DBI", "RSQLite", "janitor", "ggplot2", "rmarkdown", "knitr"))

# Étape 2 : Définir les targets
list(
  # Nettoyage des données
  tar_target(
    name = final_data_clean,
    command = process_data("DATA")
  ),
  
  # Création de la base de données SQLite
  tar_target(
    name = reseau_db,
    command = creerBD(final_data_clean),
    format = "file"
  ),
  
  # Requêtes SQL
  tar_target(
    name = Requete_temperature,
    command = fonction_requete_temp(reseau_db)
  ),
  
  tar_target(
    name = Requete_courant,
    command = fonction_requete_cou(reseau_db)
  ),
  
  tar_target(
    name = Requete_profondeur,
    command = fonction_requete_pro(reseau_db)
  ),
  
  # Graphiques
  tar_target(
    name = Graphique_richesseXtemperature,
    command = graphique_richesse_temperature(Requete_temperature)
  ),
  
  tar_target(
    name = Graphique_richesseXcourant,
    command = graphique_richesse_courant(Requete_courant)
  ),
  
  tar_target(
    name = Graphique_richesseXprofondeur,
    command = graphique_richesse_profondeur(Requete_profondeur)
  ),
  
  # Rapport RMarkdown
  tar_render(
    Projet_final_BIO500, 
    path = "RMarkdown_article/RMarkdown-article.Rmd",
  )
)
