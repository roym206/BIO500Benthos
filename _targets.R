install.packages("targets")

#Fichier principal
#tar_make()
#Étape 1 : Appeler les packages et fonctions nécessaires

  #Appeler les libraries
  library(targets)
  #Appeler les scripts
  source('Fonctions/fonction_nettoyerdata.R')
  # source('Fonctions/creer_tables.R')
  # source('Fonctions/requete.R')
  # source('Fonctions/requete_temp.R')
  # source('Fonctions/figure_resume.R')
  tar_option_set(packages = c("dplyr", "readr", "DBI", "RSQLite"))  #mettre les libraries qu'on aura besoin dans le target dans le vecteur (c())

#Étape 2 : créer le target pour automatiser le pipeline
list(
  #Une target pour le chemin du fichier de données
  tar_target(
    name = chemin ,
    command = list.files( "DATA" , full.names = TRUE),
    format = "file"
  ),
  
  # tar_target(
  #   name = donnees,
  #   purrr::map(chemin, read.csv)
  # ),
  
  # Une target pour importer et nettoyer les données
  tar_target(
    name = 'final_data_clean',
    command = process_data(chemin)
  )
)




# #Combiner les fichiers en un seul data frame et
# #faire un nettoyage des données :
# 
# 
#source('Fonctions/fonction_nettoyerdata.R')
 #directory_path <- "DATA"
# final_data_clean<-process_data(directory_path)
# print(head(final_data_clean))
# 
# #Créer les bases de données et injecter les données dans les tables de notre fonction 
# 
# source('Fonctions/creer_tables.R')
# creerBD(final_data_clean, db_name = "reseau.db")
# 
# #tester notre BD avec des requêtes 
# source('Fonctions/requete.R')
# 
# 
# tar_read(chemin)
# 
# 
# 
