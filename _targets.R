#Fichier principal


#Étape 1 : Appeler les packages et fonctions nécessaires

  #Appeler les libraries
  library(targets)
  library(tarchetypes)
  
  #Appeler les scripts
  source('Fonctions/fonction_nettoyerdata.R')
  source('Fonctions/creer_tables.R')
  source('Fonctions/requete_temp.R')
  source('Fonctions/graphique.R')
  tar_option_set(packages = c("dplyr", "readr", "DBI", "RSQLite", "janitor", "ggplot2", "rmarkdown", "knitr"))  #mettre les libraries qu'on aura besoin dans le target dans le vecteur (c())

#Étape 2 : créer le target pour automatiser le pipeline
list(
    # Une target pour importer et nettoyer les données
  tar_target(
    name = final_data_clean,
    command = process_data("DATA")
  ),
  
  #Créer nos tables SQL
  tar_target(
    name = reseau.db,
    command = creerBD(final_data_clean, db_name = "reseau.db")
  ),
  
  #requête température
  tar_target(
    name = Requete_temperature,
    command = fonction_requete_temp("reseau.db"),
    format = "rds"
    
  ),

  #requête courant
  tar_target(
    name = Requete_courant,
    command = fonction_requete_cou("reseau.db"),
    format = "rds"
    

  ),
  
  # requête profondeur
  tar_target(
    name = Requete_profondeur,
    command = fonction_requete_pro("reseau.db"),
    format = "rds"
    
  
  ),
  
  # Graphique richesse en fonction de la température
  
  tar_target(
    name = Graphique_richesseXtemperature,
    command = graphique_richesse_temperature(Requete_temperature)
    
  ),
  
  # Graphique richesse en fonction du courant
  
  tar_target(
    name = Graphique_richesseXcourant,
    command = graphique_richesse_courant(Requete_courant)
    
  ),
  
  # Graphique richesse en fonction de la profondeur
  
  tar_target(
    name = Graphique_richesseXprofondeur,
    command = graphique_richesse_profondeur(Requete_profondeur)
    
  ),
  
   #Rmarkdown
  
  tar_render(Projet_final_BIO500, path = "Projet_final_BIO500.Rmd")
)
  