
#LIRE
#PAS IMPORTANT???? C'EST FAIS DANS LA FONCTION DE NETTOYAGE DES DONNÉES DÉJÀ














fonc_combine <- function(chemin_dossier) {
  
#importer les libraries nécessaires
library(readr)
library(dplyr)
  
#Créer un chemin vers nos fichiers CSV

fichier_csv<-list.files(chemin_dossier, pattern = "\\.csv$", full.names = TRUE)

# Lire et combiner les fichiers CSV 
donnees <- fichier_csv%>%
  lapply(read.csv) %>%
  bind_rows()
#donnees <- list()

#Boucle pour importer les fichiers
#for (file in fichier_csv) {
# data <- read.csv(file)
 # donnees <- append(donnees, list(data))
  

return(donnees) #Retourner la liste de dataframe
}
#fusion des tables en une seule
final_data <- bind_rows(donnees)
print(head(final_data))
#}




#Site internet, fonctionnait pas
#conn <- dbConnect(sqlite, "[db file from DBeaver]")