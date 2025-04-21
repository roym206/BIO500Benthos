# #Fichier principal
# 
# 
# #Étape 1 : Appeler les packages et fonctions nécessaires
# 
#   #Appeler les libraries
#   library(targets)
#   library(tarchetypes)
#   
#   #Appeler les scripts
#   source('Fonctions/fonction_nettoyerdata.R')
#   source('Fonctions/creer_tables.R')
#   source('Fonctions/requete_temp.R')
#   source('Fonctions/graphique.R')
#   tar_option_set(packages = c("dplyr", "readr", "DBI", "RSQLite", "janitor", "ggplot2", "rmarkdown", "knitr"))  #mettre les libraries qu'on aura besoin dans le target dans le vecteur (c())
# 
# #Étape 2 : créer le target pour automatiser le pipeline
# list(
#     # Une target pour importer et nettoyer les données
#   tar_target(
#     name = final_data_clean,
#     command = process_data("DATA"),
#     #cue = tar_cue("always")
#   ),
#   
#   # tar_target(
#   #   name = con,
#   #   command = dbConnect(SQLite(), dbname= "reseau.db"),
#   #   cue = tar_cue("always"),
#   #   format = "qs"
#   # ),
#   
#   
#   #Créer nos tables SQL
#   tar_target(
#     name = reseau_db,
#     command = creerBD(final_data_clean),
#     format = "file"
#     #cue = tar_cue("always")
#   ),
#   
#   #requête température
#   tar_target(
#     name = Requete_temperature,
#     command = fonction_requete_temp()
#     #deps = c(reseau_db),
#    # format = "rds",
#    # cue = tar_cue("always")
#     
#   ),
# 
#   #requête courant
#   tar_target(
#     name = Requete_courant,
#     command = fonction_requete_cou()
#     #format = "rds",
#     #cue = tar_cue("always")
#     
# 
#   ),
#   
#   # requête profondeur
#   tar_target(
#     name = Requete_profondeur,
#     command = fonction_requete_pro()
#    # format = "rds",
#     #cue = tar_cue("always")
#     
#   
#   ),
#   
#   #tar_target(
#    # name = disc,
#     #command = {dbDisconnect(con)
#     #  "Déconnecté"
#     #  },
#     #deps = c(Requete_profondeur, Requete_courant, Requete_temperature)
#     #cue = tar_cue("always")
#  # ),
#   
#   # Graphique richesse en fonction de la température
#   
#   tar_target(
#     name = Graphique_richesseXtemperature,
#     command = graphique_richesse_temperature(Requete_temperature)
#     
#   ),
#   
#   # Graphique richesse en fonction du courant
#   
#   tar_target(
#     name = Graphique_richesseXcourant,
#     command = graphique_richesse_courant(Requete_courant)
#     
#   ),
#   
#   # Graphique richesse en fonction de la profondeur
#   
#   tar_target(
#     name = Graphique_richesseXprofondeur,
#     command = graphique_richesse_profondeur(Requete_profondeur)
#     
#   ),
#   
#    #Rmarkdown
#   
#   tar_render(
#     Projet_final_BIO500, 
#     path = "Projet_final_BIO500.Rmd"
#     )
# )
#   

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
    path = "Projet_final_BIO500.Rmd"
  )
)
