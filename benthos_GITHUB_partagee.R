
install.packages("dplyr" , dependencies = TRUE)

library(readr)
library(dplyr)
library(lubridate)
library(janitor)
library(stringr)


#Combiner less fichiers en un seul data frame et
#faire un nettoyage des données :


source('Fonctions/fonction_nettoyerdata.R')
directory_path <- "DATA"
final_data_clean<-process_data(directory_path)

#Créer les bases de données et injecter les données dans les tables de notre fonction 

source('Fonctions/creer_tables.R')
creerBD(final_data_clean, db_name = "reseau.db")

#tester notre BD avec des requêtes 
source('Fonctions/requete.R')





